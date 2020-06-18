import json
import os
import shutil
import socket
from datetime import timedelta
from threading import Thread

import requests
from flask import *
from flask_cors import CORS

from cnc.app_code.DB import *
from cnc.malware_importer import MalwareImporter

app = Flask(__name__)
CORS(app)
app.secret_key = "abc"
app.permanent_session_lifetime = timedelta(minutes=5)
app.config['UPLOAD_FOLDER_MALWARES'] = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'STORAGE\\Malwares\\')


@app.route('/connection', methods=['GET', 'POST'])
def connection():
    return json.dumps({
        "status": True,
        "err_code": 0,
        "msg": 'ok'
    })


@app.route('/uploader', methods=['GET', 'POST'])
def upload_file():
    try:
        if request.method == 'POST':
            malware_id = None
            malware_name = request.form['malware_name']
            malware_description = request.form['malware_description']
            malware_exe = request.files['malware_exe']
            malware_csv = request.files['malware_csv']
            malware_json = request.files['malware_json']

            # Save data in database
            malware_id = MalwaresDB().INSERT(malware_name, malware_description)

            # create dir and save files
            dir = app.config['UPLOAD_FOLDER_MALWARES'] + str(malware_id)
            if os.path.exists(dir):
                shutil.rmtree(dir)
            os.makedirs(dir)
            path = app.config['UPLOAD_FOLDER_MALWARES'] + str(malware_id) + '/'

            malware_exe.save(os.path.join(path, str(malware_id) + '.exe'))
            malware_csv.save(os.path.join(path, str(malware_id) + '.csv'))
            malware_json.save(os.path.join(path, str(malware_id) + '.json'))

            # create assets (pre,exe,post,config,..)
            mi = MalwareImporter(app.config['UPLOAD_FOLDER_MALWARES'], str(malware_id))
            # mi.create_assets()
            t1 = Thread(target=mi.create_assets, args=())
            t1.start()

            print("done")
            return json.dumps({
                "status": True,
                "id": malware_id
            })
    except Exception as e:
        if (malware_id != None and malware_id > -1):
            MalwaresDB().DELETE(malware_id)
        return json.dumps({
            "status": False,
            "err_code": 500
        })


@app.route('/')
def check_status():
    try:
        # check avaiable agents status
        agents = AgentsDB().get_all_available_agents
        print(agents)
        for agent in agents:
            try:
                res = requests.get(url="http://{0}:{1}".format(agent[2], agent[3]), data={}, verify=False, timeout=5)
            except:
                AgentsDB().update_agent_status(agent[0], "DIED")
        return json.dumps({
            "status": True,
            "err_code": 0
        })
    except:
        return json.dumps({
            "status": False,
            "err_code": -1,
            "msg": "connection to database failed"
        })


@app.route('/agents')
def agents():
    # check avaiable agents status
    agents = AgentsDB().get_all_available_agents
    online_agents = []

    for agent in agents:
        try:
            r = requests.get(url="http://{0}:{1}".format(agent[2], agent[3]), data={}, verify=False, timeout=5)
            online_agents.append({"ip": agent[2], "port": agent[3], "id": agent[0]})
        except:
            AgentsDB().update_agent_status(agent[0], "DIED")
    return json.dumps({
        "status": True,
        "agents": online_agents,
        "err_code": 0
    })


@app.route('/send_malware', methods=['GET'])
def send_malware_to_agent():
    malware_id = request.args.get('malware_id', type=int)
    agent_id = request.args.get('agent_id', type=int)
    try:
        # check if malware exist
        ml = MalwaresDB().GET_MALWARE(malware_id)

        if (ml == []):
            return json.dumps({
                "status": False,
                "err_code": -1,
                "msg": "Malware doesnt exist"
            })

        agent = AgentsDB().get_agent_by_id(agent_id)

        if (agent == []):
            return json.dumps({
                "status": False,
                "err_code": -1,
                "msg": "Agent doesnt exist"
            })

        ip = agent[2]
        port = agent[3]

        with  open(app.config['UPLOAD_FOLDER_MALWARES'] + "/" + str(malware_id) + "/assets.zip", 'rb') as assets_zip:
            files = {'malware_files': assets_zip}
            values = {'malware_id': malware_id}
            r = requests.post("http://{0}:{1}/upload".format(ip, port), files=files, data=values)
            return json.dumps({
                "status": True,
                "err_code": 0,
                "msg": r.json()
            })

        return json.dumps({
            "status": False,
            "err_code": -1,
            "msg": "cannot open assets_zip"
        })
    except NameError:
        return json.dumps({
            "status": False,
            "err_code": -1,
            "msg": NameError
        })


def exe2_all_agents(malware_id, agent_id, pre_or_post):
    # try:
    pre_or_post = pre_or_post.lower()
    # check malware type
    if (MalwareImporter.is_lateral_movement(
            app.config['UPLOAD_FOLDER_MALWARES'] + "/" + str(malware_id) + "/" + str(malware_id) + ".csv") == False):
        print("not - leteral movement malware")
        return
    print("leteral movement malware")
    # check if malware exist
    ml = MalwaresDB().GET_MALWARE(malware_id)
    if (ml == []):
        return json.dumps({
            "status": False,
            "err_code": -1,
            "msg": "Malware not exist"
        })
    target_agent = AgentsDB().get_agent_by_id(agent_id)
    if (target_agent == []):
        return json.dumps({
            "status": False,
            "err_code": -1,
            "msg": "Agent not exist"
        })

    # UPDATE AGENTs Status
    allagents = AgentsDB().get_all_available_agents
    for agent in allagents:
        try:
            print(agent)
            res = requests.get(url="http://{0}:{1}".format(agent[2], agent[3]), data={}, verify=False, timeout=5)
            if agent[0] == agent_id: continue
            # agent is ok
            # send exe to agent
            ip = agent[2]
            port = agent[3]
            with  open(app.config['UPLOAD_FOLDER_MALWARES'] + "/" + str(malware_id) + "/assets/" + pre_or_post + ".exe",
                       'rb') as exe_file:
                files = {'exe_file': exe_file}
                r = requests.post("http://{0}:{1}/run_exe".format(ip, port), files=files)
                print(r.json())
            print("exe sent to {0}".format(agent[1]))
        except:
            AgentsDB().update_agent_status(agent[0], "DIED")
            print("ERROR : agent died {0} {1} {2} {3}".format(target_agent[0], target_agent[1], target_agent[2],
                                                              target_agent[3]))

    return json.dumps({
        "status": True,
        "err_code": 0,
        "msg": 'Done'
    })


# except  Exception as e:
#    return json.dumps({
#        "status": False,
#        "err_code": -1,
#        "msg": e.__str__()
# })


@app.route('/run_malware', methods=['GET'])
def run_malware():
    malware_id = request.args.get('malware_id', type=int)
    agent_id = request.args.get('agent_id', type=int)
    try:
        # check if malware exist
        ml = MalwaresDB().GET_MALWARE(malware_id);

        if (ml == []):
            return json.dumps({
                "status": False,
                "err_code": -1,
                "msg": "Malware not exist"
            })

        agent = AgentsDB().get_agent_by_id(agent_id)

        if (agent == []):
            return json.dumps({
                "status": False,
                "err_code": -1,
                "msg": "Agent not exist"
            })

        ip = agent[2]
        port = agent[3]

        # check malware type and if lateral_movement send pre to all agents
        exe2_all_agents(malware_id, agent_id, 'pre')

        values = {'malware_id': malware_id}
        r = requests.post("http://{0}:{1}/run".format(ip, port), data=values)

        if r.json()["status"] == False:
            return json.dumps({
                "status": False,
                "err_code": -1,
                "msg": r.json()["msg"]
            })

        return json.dumps({
            "status": True,
            "err_code": 0,
            "msg": r.text
        })

    except  Exception as e:
        return json.dumps({
            "status": False,
            "err_code": -1,
            "msg": e.__str__()
        })


@app.route('/revert_malware', methods=['GET'])
def revert_malware():
    malware_id = request.args.get('malware_id', type=int)
    agent_id = request.args.get('agent_id', type=int)
    try:
        # check if malware exist
        ml = MalwaresDB().GET_MALWARE(malware_id);

        if (ml == []):
            return json.dumps({
                "status": False,
                "err_code": -1,
                "msg": "Malware not exist"
            })
        agent = AgentsDB().get_agent_by_id(agent_id)
        if (agent == []):
            return json.dumps({
                "status": False,
                "err_code": -1,
                "msg": "Agent not exist"
            })

        ip = agent[2]
        port = agent[3]
        # check malware type and if lateral_movement send post to all agents
        exe2_all_agents(malware_id, agent_id, 'post')
        values = {'malware_id': malware_id}
        r = requests.post("http://{0}:{1}/revert".format(ip, port), data=values)

        return json.dumps({
            "status": True,
            "err_code": 0,
            "msg": r.text
        })

    except:
        return json.dumps({
            "status": False,
            "err_code": -1,
            "msg": "connection error"
        })


@app.route('/malware_info', methods=['GET'])
def malware_info():
    malware_id = request.args.get('malware_id', type=int)
    try:
        # check if malware exist
        ml = MalwaresDB().GET_MALWARE(malware_id);
        if (ml == []):
            return json.dumps({
                "status": False,
                "err_code": -1,
                "msg": "Malware not exist"
            })

        # print(ml[0])
        malware_status = ml[0][5]
        return json.dumps({
            "status": True,
            "err_code": 0,
            "msg": malware_status
        })


    except Exception as e:
        return json.dumps({
            "status": False,
            "err_code": -1,
            "msg": e.__str__()
        })


@app.route('/get_log_agent', methods=['GET'])
def get_agent_log():
    try:
        agent_id = request.args.get('agent_id', type=int)
        agent = AgentsDB().get_agent_by_id(agent_id)
        if (agent == []):
            return json.dumps({
                "status": False,
                "err_code": -1,
                "msg": "Agent not exist"
            })
        res = requests.get(url="http://{0}:{1}/get_logs".format(agent[2], agent[3]))
        return json.dumps({
            "status": True,
            "err_code": 0,
            "id": agent_id,
            "msg": res.text
        })
    except Exception as e:
        return json.dumps({
            "status": False,
            "err_code": -1,
            "msg": e.__str__()
        })


# ------------------------------------------------------------------------------------------- DB ---------------------------------------------------------------------------------
# AGENT -> CNC -> DB CONNECTION
@app.route('/agent/insert', methods=['POST'])
def insert_agent():
    try:
        host_name = request.form['host_name']
        host_ip = request.form['host_ip']
        host_port = request.form['host_port']
        ids = AgentsDB().get_agent_id(host_name, host_ip)
        exists = len(ids) != 0
        if exists:
            agent_id = ids[0][0]
            AgentsDB().update_agent_status_port(agent_id, host_port, "WAITING")
        else:
            agent_id = AgentsDB().insert_agent(host_name, host_ip, host_port)
        return json.dumps({
            "status": True,
            "err_code": 0,
            "id": agent_id,
            "msg": "ok"
        })
    except Exception as e:
        return json.dumps({
            "status": False,
            "err_code": -1,
            "msg": e.__str__()
        })


@app.route('/agent/malware/insert', methods=['POST'])
def insert_malware_to_agent():
    try:
        agent_id = request.form['agent_id']
        malware_id = request.form['malware_id']
        agent_malware_id = AgentsDB().insert_malware_to_agent(agent_id, malware_id)
        return json.dumps({
            "status": True,
            "err_code": 0,
            "id": agent_malware_id,
            "msg": 'ok'
        })
    except Exception as e:
        return json.dumps({
            "status": False,
            "err_code": -1,
            "msg": e.__str__()
        })


# maybe unused??
@app.route('/agent/log/insert', methods=['POST'])
def insert_agent_log():
    try:
        print("this")
        agent_id = request.form['agent_id']
        malware_id = request.form['malware_id']
        log = request.form['log']
        status = request.form['status']
        csv_row_id = request.form['csv_row_id']
        log_id = AgentsDB().insert_agent_log(agent_id, malware_id, status, log, csv_row_id)
        return json.dumps({
            "status": True,
            "err_code": 0,
            "id": log_id,
            "msg": 'ok'
        })
    except Exception as e:
        return json.dumps({
            "status": False,
            "err_code": -1,
            "msg": e.__str__()
        })


@app.route('/agent/status/update', methods=['POST'])
def update_agent_status():
    try:
        agent_id = request.form['agent_id']
        status = request.form['status']
        AgentsDB().update_agent_status(agent_id, status)
        return json.dumps({
            "status": True,
            "err_code": 0,
            "msg": 'ok'
        })
    except Exception as e:
        return json.dumps({
            "status": False,
            "err_code": -1,
            "msg": e.__str__()
        })


@app.route('/agent/delete', methods=['POST'])
def delete_agent():
    try:
        agent_id = request.form['agent_id']
        AgentsDB().delete_agent(agent_id)
        return json.dumps({
            "status": True,
            "err_code": 0,
            "msg": 'ok'
        })
    except Exception as e:
        return json.dumps({
            "status": False,
            "err_code": -1,
            "msg": e.__str__()
        })


@app.route('/agent/get', methods=['POST'])
def get_agent():
    try:
        host_name = request.form['host_name']
        host_ip = request.form['host_ip']
        host_port = request.form['host_port']
        agent_id = AgentsDB().get_agent_id(host_name, host_ip)

        return json.dumps({
            "status": True,
            "err_code": 0,
            "id": agent_id,
            "msg": 'ok'
        })
    except Exception as e:
        return json.dumps({
            "status": False,
            "err_code": -1,
            "msg": e.__str__()
        })


def cnc():
    HOST_NAME = socket.gethostname()
    HOST_IP = socket.gethostbyname(HOST_NAME)

    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.bind(('localhost', 0))
    port = sock.getsockname()[1]
    sock.close()

    app.debug = False
    # app.run(HOST_IP, port, debug='true')
    # HOST_IP = '132.72.81.38'
    HOST_IP = '127.0.0.1'
    port = 5000
    return Thread(target=app.run, kwargs={'host': HOST_IP, 'port': port, 'debug': True, 'use_reloader': False})


if __name__ == '__main__':
    cnc().start()
    # print(exe2_all_agents(9,1,'pre'))
    pass

"""import hydra

from cnc.server import ServerDecorator
import logging

logPath='C:\\Users\\Public'
logName = 'log.log'
def config_logger():
    logFormatter = logging.Formatter("%(asctime)s [%(threadName)-12.12s] [%(levelname)-5.5s]  %(message)s")
    rootLogger = logging.getLogger()
    fileHandler = logging.FileHandler("{0}/{1}.log".format(logPath, logName))
    fileHandler.setFormatter(logFormatter)
    rootLogger.addHandler(fileHandler)
    consoleHandler = logging.StreamHandler()
    consoleHandler.setFormatter(logFormatter)
    rootLogger.addHandler(consoleHandler)
    return rootLogger
"""

"""
@hydra.main(config_path='config.yaml')
def main(cfg):
    logger_config = cfg.logger
    db = cfg.db

    logger = config_logger()
    logger.info("configured logger")
    server = ServerDecorator(logger)
    server.start()

if __name__ == "__main__":
    main()
"""
