import datetime
import glob
import json
import logging
import os
import queue
import shutil
import socket
import sqlite3
import sys
import time
from datetime import timedelta
from threading import Thread
from zipfile import ZipFile

import pandas as pd
import requests
from flask import *
from flask_cors import CORS

# ----------------------------------- Global Vars -----------------------------------------------
AGENT_ID = -1
HOST_NAME = ""
HOST_IP = -1
HOST_PORT = -1
CNC_IP = -1
CNC_PORT = -1
que = queue.Queue()
app = Flask(__name__)
conn = sqlite3.connect('local.db', check_same_thread=False)
MALWARE_CSV_PATH = os.path.join("C:" + os.sep, "csvlog")
READ_CSV_INDEXES = []
READ_CSV_FLAG = False

# ---------------------------------- Configuration ----------------------------------------------

CORS(app)
app.secret_key = "abc"
app.permanent_session_lifetime = timedelta(minutes=5)

app.config['AGENT_FOLDER'] = os.path.join("C:" + os.sep, "Users", "Public", "ReWare Agent")
LOGS_CSV_PATH = os.path.join(app.config['AGENT_FOLDER'], "logs")

if not os.path.isdir(app.config['AGENT_FOLDER']):
    os.mkdir(app.config['AGENT_FOLDER'])

app.config['TEMP_FOLDER'] = os.path.join(app.config['AGENT_FOLDER'], "temp")
if __name__ == "__main__":
    logging.basicConfig(filename=os.path.join(app.config['AGENT_FOLDER'], "agent.log"), filemode='w',
                        format='%(asctime)s - %(levelname)s: %(message)s',
                        level=logging.DEBUG, datefmt='%d-%m-%Y %H:%M:%S')


# ----------------------------------- Help Functions --------------------------------------------
def check_files(malware_id):
    """
    Checks that the files received to malware 'malware_id' are according to structure:
    Folder temp/<malware_id> containing:
    -pre.exe
    -malware.exe
    -post.exe
    :return: boolean, True if files of malware 'malware_id' are correct, false otherwise
    """
    dirPath = os.path.join(app.config['TEMP_FOLDER'], malware_id)
    result = True
    result = result & os.path.exists(os.path.join(dirPath, 'pre.exe'))
    result = result & os.path.exists(os.path.join(dirPath, 'malware.exe'))
    result = result & os.path.exists(os.path.join(dirPath, 'post.exe'))
    return result


def check_connection(hostname):
    """
    Check if host is connected to the internet
    :return: boolean, True if there is an internet connection to hostname, False otherwise
    """
    try:
        host = socket.gethostbyname(hostname)
        s = socket.create_connection((host, 80), 2)
        s.close()
        return True
    except:
        pass
    return False


def get_ip():
    """
    Retrieves the host's IP, if several web interfaces exists, returns the one that's connected to the internet
    :return: Host's IP
    """
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        # doesn't even have to be reachable
        s.connect(('10.255.255.255', 1))
        IP = s.getsockname()[0]
    except:
        IP = '127.0.0.1'
    finally:
        s.close()
    return IP


def get_port():
    """
    Retreives an available port from the system
    :return: An available Port
    """
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.bind(('localhost', 0))
    a_port = sock.getsockname()[1]
    sock.close()
    return a_port


def read_csv(malware_id, csv_file):
    """
    Reads a CSV file from dataframe 'csv_file'
    Writes lines not read yet to the local db
    Read lines indexes will be saved in READ_CSV_INDEXES array
    :return: boolean: True if successful, False otherwise
    """
    global READ_CSV_INDEXES
    for row in csv_file.iterrows():
        # check if row was read, if it was: continue to next row
        if row[0] in READ_CSV_INDEXES:
            continue
        # read row
        action_log = row[1]['DateTime'] + ': IOCType: ' + row[1]['IOCType'] + ' | IOCPath: ' + row[1]['IOCPath'] + \
                     ' | OpType: ' + row[1]['OperationType'] + ' | OpResult: ' + row[1]['OpResult']
        if 'Info' in csv_file.columns:
            action_log += ' | Info: ' + str(row[1]['Info'])
        # insert to local db
        insert_agent_log(malware_id, "RUNNING", action_log, row[0])
        # mark row read
        READ_CSV_INDEXES += [row[0]]


def read_malware_csv(malware_id):
    """
    Reads the malware CSV located in folder MALWARE_CSV_PATH
    Uses sub function read_csv()
    :return: boolean: True if successful, False otherwise
    """
    global MALWARE_CSV_PATH
    csv_fp = glob.glob(os.path.join(MALWARE_CSV_PATH, '*.csv'))
    if len(csv_fp) == 0:
        return False  # no files found
    csv_fp = csv_fp[0]  # we use the 1st file we find, COULD DO: iterate over all files, if there are more than 1->error
    csv_file = pd.read_csv(csv_fp)
    read_csv(malware_id, csv_file)
    return True


def read_exe_csv(malware_id, filename):
    """
    Reads the CSV file of an exe (pre/post), located in folder LOGS_CSV_PATH
    Uses sub function read_csv()
    CSV file name is of the format: <malware_id>_<exe_name>.csv, e.g: 1_POST.csv
    :return: boolean: True if successful, False otherwise
    """
    global LOGS_CSV_PATH
    if not os.path.isdir(LOGS_CSV_PATH):
        return False  # no logs folder exists
    csv_fp = glob.glob(os.path.join(LOGS_CSV_PATH, str(malware_id) + '_' + filename + '.csv'))
    if len(csv_fp) == 0:
        return False  # no files found
    csv_fp = csv_fp[0]  # we use the 1st file we find
    csv_file = pd.read_csv(csv_fp)
    read_csv(malware_id, csv_file)
    return True


def csv_process_loop(read_csv_function, *argv):
    """
    Function to be run by a side process while the malware runs
    this function loops and reads the csv until stopped by the main process
    when the malware finishes running
    places in que the boolean answer returned
    :return: True if the read was successful, false otherwise
    """
    global READ_CSV_FLAG
    time.sleep(3)
    while READ_CSV_FLAG:
        time.sleep(1)
        if not read_csv_function(*argv):
            que.put(False)
            return False
    if not read_csv_function(*argv):  # read malware csv last time, to be sure
        que.put(False)
        return False
    que.put(True)
    return True


# ---------------------------------------------- API Functions ---------------------------------------------------

@app.route('/')
def check_status():
    """
    An is alive function that returns a message, to be used to check if agent is alive
    :return: json including 'status' True and 'err_code' 0
    """
    return json.dumps({
        "status": True,
        "err_code": 0
    })


@app.route('/upload', methods=['GET', 'POST'])
def upload_malware():
    """
    Upload a malware to the agent
    receive malware id and files, extract files to 'temp/<malware_id>' folder
    check files are correct format
    :return: json message with results
    """
    global HOST_NAME, HOST_PORT, HOST_IP
    if request.method == 'POST':
        malware_id = None
        error_code = -10
        try:
            malware_id = request.form['malware_id']
            malware_zip = request.files['malware_files']

            logging.info("Malware upload request received for malware id: %s", malware_id)
            insert_agent_log(malware_id, "WAITING", "Malware uploaded request received", "-1")

            # Create malware's temp dir and extract files
            path = os.path.join(app.config['TEMP_FOLDER'], str(malware_id))
            if os.path.isdir(path):  # if malware folder already exists, remove it and it's contents
                shutil.rmtree(path)
            os.mkdir(path)
            file_path = os.path.join(path, str(malware_id) + '.zip')
            malware_zip.save(file_path)
            with ZipFile(file_path) as zipObj:
                zipObj.extractall(os.path.join(app.config['TEMP_FOLDER'], str(malware_id)))

            # Check all needed files are there
            if not check_files(malware_id):
                error_code = -20
                raise Exception("Files inside zip were not correctly formatted")

            # Update CNC malware was uploaded
            if add_malware_in_db(malware_id):
                logging.info("Uploaded malware %s successfully - Updated in CNC DB", malware_id)
                insert_agent_log(malware_id, "WAITING", "Malware uploaded successfully, CNC DB updated", "-1")
            else:
                logging.info("Uploaded malware %s successfully - Error updating CNC DB", malware_id)
                insert_agent_log(malware_id, "WAITING", "Malware uploaded successfully, CNC DB update failed", "-1")

            return json.dumps({
                "status": True,
                "err_code": 0
            })
        except Exception as e:
            logging.error("Error receiving malware %s, Error: ", malware_id, e.__str__())
            insert_agent_log(malware_id, "WAITING", "Error receiving malware: " + e.__str__(), "-1")
            print(e.__str__())
            return json.dumps({
                "status": False,
                "err_code": error_code,
                "msg": e.__str__()
            })


@app.route('/run', methods=['GET', 'POST'])
def run_malware():
    """
    Runs malware <malware_id> on agent
    First, run pre.exe, in a different run in.exe and run malware.exe
    :return: json message with results
    """
    global HOST_NAME, HOST_PORT, HOST_IP, READ_CSV_INDEXES, READ_CSV_FLAG
    if request.method == 'POST':
        malware_id = None
        error_code = -1
        try:
            malware_id = request.form['malware_id']

            insert_agent_log(malware_id, "RUNNING", "Malware run request received", -1)
            logging.info("Malware run request received for malware id: %s", malware_id)

            # check malware exists
            if not check_files(malware_id):
                error_code = -404
                raise Exception("Malware with id doesn't exist")
            path = os.path.join(app.config['TEMP_FOLDER'], str(malware_id))

            # CSV folder
            if os.path.isdir(MALWARE_CSV_PATH):  # if malware csv folder already exists, remove it and it's contents
                shutil.rmtree(MALWARE_CSV_PATH)
            os.mkdir(MALWARE_CSV_PATH)

            change_status_in_db("RUNNING")
            insert_agent_log(malware_id, "RUNNING", "Started running malware", -1)
            logging.info("Started running malware %s", malware_id)

            READ_CSV_INDEXES = []  # reset collection of read indexes
            READ_CSV_FLAG = True
            # run csv reading thread in the background while running the pre.exe
            t = Thread(target=csv_process_loop, args=(read_exe_csv, malware_id, "PRE"))
            t.start()

            os.system('\"' + os.path.join(path, 'pre.exe\"'))
            READ_CSV_FLAG = False

            t.join()
            if not que.get():  # we use a queue to get the result from the thread
                insert_agent_log(malware_id, "WAITING", "Error opening pre CSV", -1)
                logging.info("Error opening pre CSV for malware id: %s", malware_id)

            insert_agent_log(malware_id, "RUNNING", "pre.exe finished running successfully", -1)
            logging.info("pre.exe finished running successfully for malware id: %s", malware_id)

            READ_CSV_INDEXES = []  # reset collection of read indexes
            READ_CSV_FLAG = True
            # run csv reading thread in the background while running the malware.exe
            t = Thread(target=csv_process_loop, args=(read_malware_csv, malware_id))
            t.start()

            os.system('\"' + os.path.join(path, 'malware.exe\"'))
            READ_CSV_FLAG = False

            t.join()
            if not que.get():  # we use a queue to get the result from the thread
                insert_agent_log(malware_id, "WAITING", "Error opening malware CSV", -1)
                change_status_in_db("WAITING")
                error_code = -100
                raise Exception("Error opening malware CSV")

            change_status_in_db("WAITING")
            insert_agent_log(malware_id, "WAITING", "Finished running malware successfully", -1)
            logging.info("Finished running malware %s successfully", malware_id)
            return json.dumps({
                "status": True,
                "err_code": 0
            })
        except Exception as e:
            logging.error("Error running malware %s, Error: %s", malware_id, e.__str__())
            insert_agent_log(malware_id, "WAITING", "Error running malware", -1)
            print(e.__str__())
            return json.dumps({
                "status": False,
                "err_code": error_code,
                "msg": e.__str__()
            })


@app.route('/revert', methods=['GET', 'POST'])
def revert_malware():
    """
    Reverts the observables created by the malware <malware_id> by running post.exe
    :return: json message with results
    """
    global HOST_NAME, HOST_PORT, HOST_IP, READ_CSV_INDEXES, READ_CSV_FLAG
    if request.method == 'POST':
        malware_id = None
        error_code = -1
        try:
            malware_id = request.form['malware_id']

            insert_agent_log(malware_id, "REVERTING", "Malware revert request received", -1)
            logging.info("Malware revert request received for malware id: %s", malware_id)

            # check malware exists
            if not check_files(malware_id):
                error_code = -404
                raise Exception("Malware with id doesn't exist")
            path = os.path.join(app.config['TEMP_FOLDER'], malware_id)

            change_status_in_db("REVERTING")
            insert_agent_log(malware_id, "REVERTING", "Started reverting malware", -1)
            logging.info("Started reverting malware %s", malware_id)

            READ_CSV_INDEXES = []  # reset collection of read indexes
            READ_CSV_FLAG = True
            # run csv reading thread in the background while running the pre.exe
            t = Thread(target=csv_process_loop, args=(read_exe_csv, malware_id, "POST"))
            t.start()

            os.system('\"' + os.path.join(path, 'post.exe\"'))
            READ_CSV_FLAG = False

            t.join()

            if not que.get():  # we use a queue to get the result from the thread
                insert_agent_log(malware_id, "WAITING", "Error opening post CSV", -1)
                change_status_in_db("WAITING")
                error_code = -80
                raise Exception("Error opening post CSV")

            change_status_in_db("WAITING")
            insert_agent_log(malware_id, "WAITING", "Finished reverting malware successfully", -1)
            logging.info("Finished reverting malware %s successfully", malware_id)
            return json.dumps({
                "status": True,
                "err_code": 0
            })
        except Exception as e:
            logging.error("Error reverting malware %s, Error: %s", malware_id, e.__str__())
            insert_agent_log(malware_id, "WAITING", "Error reverting malware ", -1)
            print(e.__str__())
            return json.dumps({
                "status": False,
                "err_code": error_code,
                "msg": e.__str__()
            })


@app.route('/get_logs', methods=['GET', 'POST'])
def get_logs():
    """
    Returns in a json format the recent logs from the local SQLite DB
    the json will be an array where each member is an array of the following structure:
    [id, agent_id, malware_id, status, time, action_log, csv_row_id]
    :return: json message with recent logs
    """
    return json.dumps(get_recent_logs())


@app.route('/run_exe', methods=['GET', 'POST'])
def run_exe():
    """
    Receives and runs an exe file
    :return: json message with results
    """
    global HOST_NAME, HOST_PORT, HOST_IP, READ_CSV_INDEXES, READ_CSV_FLAG
    file_name = "not_found"
    if request.method == 'POST':
        try:
            exe_file = request.files['exe_file']
            file_name = request.files['exe_file'].filename

            logging.info("Receiving .exe file: %s", file_name)
            insert_agent_log(-1, "WAITING", "Receiving .exe file: " + file_name, "-1")

            file_path = os.path.join(app.config['TEMP_FOLDER'], file_name)
            exe_file.save(file_path)

            logging.info("Running .exe file: %s", file_name)
            insert_agent_log(-1, "WAITING", "Running .exe file: " + file_name, "-1")

            os.system('\"' + file_path + '\"')

            logging.info("Ran .exe file: %s successfully", file_name)
            insert_agent_log(-1, "WAITING", "Ran .exe file: " + file_name + " successfully", "-1")

            return json.dumps({
                "status": True,
                "err_code": 0
            })
        except Exception as e:
            logging.error("Error running exe file: %s, Error: %s", file_name, e.__str__())
            insert_agent_log(-1, "WAITING", "Error running .exe file: " + file_name, "-1")
            print(e.__str__())
            return json.dumps({
                "status": False,
                "err_code": -700,
                "msg": e.__str__()
            })


# ----------------------------------- Remote CNC DB Functions ---------------------------------------------------

def turn_agent_active():
    global HOST_NAME, HOST_PORT, HOST_IP, CNC_IP, CNC_PORT, AGENT_ID
    """
    Creates connection with CNC
    Sends POST request to CNC asking to:
    Add the current agent to the DB with the status 'WAITING'
    :return: boolean: True if successful, False otherwise
    """
    values = {'host_name': HOST_NAME, 'host_ip': HOST_IP, 'host_port': HOST_PORT}
    r = requests.post("http://{0}:{1}/agent/insert".format(CNC_IP, CNC_PORT), data=values)
    res = r.json()
    if res["status"]:
        AGENT_ID = res["id"]
        logging.info("Agent '%s' | IP: %s:%d | Id %d - Online, Status: WAITING", HOST_NAME, HOST_IP, HOST_PORT,
                     AGENT_ID)
        return True
    else:
        print(r.content)
        return False


def add_malware_in_db(malware_id):
    """
    Sends POST request to CNC asking to:
    Add the a malware to an agent in the DB
    :return: boolean: True if successful, False otherwise
    """
    global AGENT_ID
    values = {'agent_id': AGENT_ID, 'malware_id': malware_id}
    r = requests.post("http://{0}:{1}/agent/malware/insert".format(CNC_IP, CNC_PORT), data=values)
    res = r.json()
    if res["status"]:
        # res["agent_malware_id"] # received id
        return True
    else:
        print(r.content)
        return False


def change_status_in_db(status):
    """
    Sends POST request to CNC asking to:
    Change agent status in db
    :return: boolean: True if successful, False otherwise
    """
    global AGENT_ID
    values = {'agent_id': AGENT_ID, 'status': status}
    r = requests.post("http://{0}:{1}/agent/status/update".format(CNC_IP, CNC_PORT), data=values)
    res = r.json()
    if res["status"]:
        return True
    else:
        print(r.content)
        return False


# ----------------------------------------- Local DB Functions ---------------------------------------------------

def insert_agent_log(malware_id, status, action_log, csv_row_id):
    """
    Inserts one line in local db 'agent_log', recording recent action in agent
    :return: None
    """
    global AGENT_ID
    query = "INSERT INTO agent_log (agent_id, malware_id, status, time, action_log, csv_row_id) \
    VALUES (" + str(AGENT_ID) + "," + str(malware_id) + ",\"" + status + "\"," + "\"" + str(datetime.datetime.now()) + \
            "\"" + ",\"" + action_log + "\"," + str(csv_row_id) + ")"
    conn.execute(query)
    conn.commit()


def get_recent_logs():
    """
    A getter for the logs inserted in the last 2 hours
    :return: Result set of last entries in 'agent_log'
    """
    query = "SELECT * FROM agent_log  WHERE datetime(time) >= datetime('now', '-2 Hour')"
    res = conn.execute(query)
    return res.fetchall()


# ------------------------------------ Constructor and Main function ---------------------------------------------

def agent():
    """
    Creates a thread that will run the flask app
    Sets up the Agent with the relevant fields
    :return: Thread
    """
    global HOST_NAME, HOST_PORT, HOST_IP, AGENT_ID, CNC_IP, CNC_PORT

    # create local db
    conn.execute('''CREATE TABLE IF NOT EXISTS agent_log
             (Id INTEGER PRIMARY KEY AUTOINCREMENT,
             agent_id           INT    NOT NULL,
             malware_id            INT     NOT NULL,
             status       TEXT NOT NULL,
             time         TEXT NOT NULL,
             action_log     TEXT NOT NULL,
             csv_row_id    INT NOT NULL);''')

    app.debug = False
    # create agent folder and temp folder for malwares, if non existent
    if not os.path.isdir(app.config['AGENT_FOLDER']):
        os.mkdir(app.config['AGENT_FOLDER'])
    if not os.path.isdir(app.config['TEMP_FOLDER']):
        os.mkdir(app.config['TEMP_FOLDER'])

    # connection info
    REMOTE_SERVER = "www.google.com"  # Just to check internet connectivity, Could change to CNC address
    # HOST_NAME = socket.gethostname()
    # HOST_IP = '132.72.201.142'
    # HOST_PORT = 5001
    HOST_NAME = socket.gethostname()
    HOST_IP = get_ip()
    HOST_PORT = get_port()
    # CNC ip and port could be retrieved using the args or terminal prompt
    if len(sys.argv) > 2:
        CNC_IP = sys.argv[1]
        CNC_PORT = sys.argv[2]
    else:
        CNC_IP = input("Enter CNC IP: ")
        CNC_PORT = input("Enter CNC Port: ")
    if check_connection(REMOTE_SERVER):
        if turn_agent_active():
            return Thread(target=app.run, args=(HOST_IP, HOST_PORT)), AGENT_ID, HOST_IP, HOST_PORT
        else:
            logging.error("Could not connect to CNC. Agent did not run")
            return False, -1, -1, -1
    else:
        logging.error("No internet connection. Agent did not run")
        return False, -1, -1, -1


if __name__ == '__main__':
    """
    Main function running the agent's thread
    :return: void
    """
    agent_thread, a_id, ip, port = agent()
    if agent_thread:
        agent_thread.start()
