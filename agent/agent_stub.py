import os
import json
import shutil
import socket
from multiprocessing import Process
from flask import *
from zipfile import ZipFile
from flask_cors import CORS
from threading import Thread
from datetime import timedelta

from agent.app_code.Agents import AgentsDb
import logging

# ----------------------------------- Global Vars -----------------------------------------------
AGENT_ID = -1
HOST_NAME = ""
HOST_IP = -1
HOST_PORT = -1

app = Flask(__name__)

# ---------------------------------- Configuration ----------------------------------------------
CORS(app)
app.secret_key = "abc"
app.permanent_session_lifetime = timedelta(minutes=5)


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
    dirPath = app.config['TEMP_FOLDER'] + '/' + malware_id + '/'
    result = True
    result = result & os.path.exists(dirPath + 'pre.exe')
    result = result & os.path.exists(dirPath + 'malware.exe')
    result = result & os.path.exists(dirPath + 'post.exe')
    return result


def does_host_exist():
    global HOST_NAME, HOST_PORT, HOST_IP
    """
    Check if host exists in database
    If it does, changes status to WAITING
    :return: boolean, True if host exists, false otherwise
    """
    global AGENT_ID
    ids = AgentsDb().get_agent(HOST_NAME, HOST_IP, HOST_PORT)
    exists = len(ids) != 0
    if exists:
        agent_id = ids[0][0]
        AGENT_ID = agent_id
        AgentsDb().update_agent_status(agent_id, "WAITING")
        logging.info("Agent '%s' | IP: %s:%d | Id %d - Online, Status: WAITING", HOST_NAME, HOST_IP, HOST_PORT,
                     agent_id)
    return exists


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
    port = sock.getsockname()[1]
    sock.close()
    return port


# ----------------------------------- API Functions --------------------------------------------
@app.route('/')
def check_status():
    global HOST_NAME, HOST_PORT, HOST_IP
    """
    An is alive function that returns a message, to be used to check if agent is alive
    :return: json with 'Agent is running' message
    """
    return json.dumps({
        "status": True
    })


@app.route('/upload', methods=['GET', 'POST'])
def upload_malware():
    if request.method == 'POST':
        malware_id = None
        try:
            malware_id = int(request.form['malware_id'])
            malware_zip = request.files['malware_files']

            if (isinstance(malware_id, int) == False):
                raise Exception('malware_id or malware_files parameters not in correct format')

            return json.dumps({
                "status": True,
                "err_code": 0
            })
        except  Exception as e:
            return json.dumps({
                "status": False,
                "err_code": -1,
                "msg": e.__str__()
            })


def run_in_exe(path):
    os.system(path + 'in.exe')


@app.route('/run', methods=['GET', 'POST'])
def run_malware():
    global HOST_NAME, HOST_PORT, HOST_IP

    if request.method == 'POST':
        malware_id = None
        try:
            malware_id = request.form['malware_id']
            return json.dumps({
                "status": True,
                "err_code": 0
            })
        except Exception as e:
            return json.dumps({
                "status": False,
                "err_code": -1,
                "msg": e.__str__()
            })


@app.route('/revert', methods=['GET', 'POST'])
def revert_malware():
    if request.method == 'POST':
        malware_id = None
        try:
            malware_id = request.form['malware_id']

            return json.dumps({
                "status": True,
                "err_code": 0
            })
        except Exception as e:
            return json.dumps({
                "status": False,
                "err_code": -1,
                "msg": e.__str__()
            })


def add_agent_to_db():
    global HOST_NAME, HOST_PORT, HOST_IP
    global AGENT_ID
    agent_id = AgentsDb().insert_agent(HOST_NAME, HOST_IP, HOST_PORT)
    AGENT_ID = agent_id
    return AGENT_ID


def delete_agent_from_db(agent_id):
    agent_id = AgentsDb().delete_agent(agent_id)


def agent():
    global HOST_NAME, HOST_PORT, HOST_IP
    global AGENT_ID
    HOST_NAME = socket.gethostname()
    HOST_IP = get_ip()
    HOST_PORT = get_port()
    HOST_PORT = 62998  # TODO: DELETE THIS TO GET PORT DYNAMICALLY
    AGENT_ID = add_agent_to_db()
    return Thread(target=app.run, args=(get_ip(), HOST_PORT)), AGENT_ID


if __name__ == '__main__':
    agent_thread, id = agent()
    agent_thread.start()
