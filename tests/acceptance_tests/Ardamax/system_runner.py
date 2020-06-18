import os
import time
from unittest import mock

import requests

from cnc import cnc_main


class SystemRunner():
    cnc_ip = -1
    cnc_port = -1
    malware_id = -1
    agent_id = -1
    STORAGE_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'STORAGE_TEST')

    def __init__(self, malware_name):
        self.cnc_ip = "127.0.0.1"
        self.cnc_port = "5000"
        self.malware_exe_path = self.STORAGE_PATH + f"\\{malware_name}.exe"
        self.malware_csv_path = self.STORAGE_PATH + f"\\{malware_name}.csv"
        self.malware_json_path = self.STORAGE_PATH + f"\\{malware_name}.json"
        # Run cnc
        cnc_thread = cnc_main.cnc()
        cnc_thread.setDaemon(True)
        cnc_thread.start()

        with mock.patch('agent.agent_main.input', side_effect=["127.0.0.1", 5000]):
            from agent import agent_main

            # run agent stub
            agent, self.agent_id, agent_ip, agent_port = agent_main.agent()

        agent.setDaemon(True)
        agent.start()

        values = {'malware_name': f'malware_name_Acceptance',
                  'malware_description': malware_name
                  }
        test_status = False

        self.values = values

    def upload_malware_to_cnc(self):
        test_status = False

        with  open(self.malware_exe_path, 'rb') as malware_exe:
            with  open(self.malware_csv_path, 'rb') as malware_csv:
                with  open(self.malware_json_path, 'rb') as malware_json:
                    files = {'malware_exe': malware_exe,
                             'malware_csv': malware_csv,
                             'malware_json': malware_json
                             }
                    result = requests.post("http://{0}:{1}/uploader".format(self.cnc_ip, self.cnc_port),
                                           files=files, data=self.values)
        test_status = bool(result.json()["status"])
        return (result.json()["status"] == False or result.json()["id"] < 0)

        # check malware status - READY , UPLOAD

    def wait_for_upload_to_cnc(self):
        waiting = True
        while (waiting):
            values = {'malware_id': self.malware_id}
            result = requests.get("http://{0}:{1}/malware_info".format(self.cnc_ip, self.cnc_port), params=values)
            print(result.json()['msg'])
            if (result.json()['msg'] == 'READY'):
                waiting = False
            else:
                time.sleep(15)
        return True

    def upload_malware_to_agent(self):
        self.values = {'malware_id': self.malware_id,
                       'agent_id': self.agent_id}

        result = requests.get("http://{0}:{1}/send_malware".format(self.cnc_ip, self.cnc_port), params=self.values)
        return result.json()["status"] == False

    def run_malware(self):
        result = requests.get("http://{0}:{1}/run_malware".format(self.cnc_ip, self.cnc_port), params=self.values)
        return (result.json()["status"] == False)

    def run_revert(self):
        result = requests.get("http://{0}:{1}/run_malware".format(self.cnc_ip, self.cnc_port), params=self.values)
        return (result.json()["status"] == False)
