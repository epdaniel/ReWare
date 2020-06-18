import os
import shutil
import time
import unittest
from unittest import mock

import requests

from acceptance_tests.common_checks import does_file_or_folder_exist, does_registry_exist
from agent import agent_main
from cnc import cnc_main


# from agent import agent_main


class ArdamaxAcceptanceTest(unittest.TestCase):
    cnc_ip = -1
    cnc_port = -1
    malware_id = -1
    agent_id = -1
    STORAGE_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'STORAGE_TEST')

    def setUp(self):
        # self.sr = SystemRunner('Ardamax')
        self.cnc_ip = "127.0.0.1"
        self.cnc_port = "5000"
        try:
            shutil.rmtree('build')
            os.remove('in.spec')
            os.remove('pre.spec')
            os.remove('post.spec')
        except:
            pass

        # Run cnc
        cnc_thread = cnc_main.cnc()
        cnc_thread.setDaemon(True)
        cnc_thread.start()

        with mock.patch('agent.agent_main.input', side_effect=["127.0.0.1", 5000]):
            # run agent stub
            agent, self.agent_id, agent_ip, agent_port = agent_main.agent()

        agent.setDaemon(True)
        agent.start()

    def tearDown(self):
        try:
            shutil.rmtree('build')
            os.remove('in.spec')
            os.remove('pre.spec')
            os.remove('post.spec')
        except:
            pass

    def test_ardamax_run_simple(self):
        # res_upload_cnc = self.sr.upload_malware_to_cnc()
        # self.assertFalse(res_upload_cnc)
        # res_wait_cnc = self.sr.wait_for_upload_to_cnc()
        # res_upload_agent = self.sr.upload_malware_to_agent()
        # self.assertFalse(res_upload_agent)
        # self.assertFalse(does_file_or_folder_exist('c:\\windows\\system32\\28643'))
        # self.assertFalse(does_file_or_folder_exist('c:\\windows\\system32\\28643\\2020060800'))
        # self.assertFalse(
        #     does_registry_exist('HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\\DPBJ Agent'))
        # self.sr.run_malware()
        # self.assertTrue(does_file_or_folder_exist('c:\\windows\\system32\\28643'))
        # self.assertTrue(does_file_or_folder_exist('c:\\windows\\system32\\28643\\2020060800'))
        # self.assertTrue(
        #     does_registry_exist('HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\\DPBJ Agent'))
        # self.sr.run_revert()
        # self.assertFalse(does_file_or_folder_exist('c:\\windows\\system32\\28643'))
        # self.assertFalse(does_file_or_folder_exist('c:\\windows\\system32\\28643\\2020060800'))
        # self.assertFalse(
        #     does_registry_exist('HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\\DPBJ Agent'))
        # try:
        # upload
        values = {'malware_name': 'Ardamax_Acceptance',
                  'malware_description': 'test'
                  }
        test_status = False
        with  open(self.STORAGE_PATH + "\\Ardamax.exe", 'rb') as malware_exe:
            with  open(self.STORAGE_PATH + "\\ArdamaxCSV.csv", 'rb') as malware_csv:
                with  open(self.STORAGE_PATH + "\\demo_malware.json", 'rb') as malware_json:
                    files = {'malware_exe': malware_exe,
                             'malware_csv': malware_csv,
                             'malware_json': malware_json
                             }
                    result = requests.post("http://{0}:{1}/uploader".format(self.cnc_ip, self.cnc_port),
                                           files=files, data=values)
                    test_status = bool(result.json()["status"])
                    if (result.json()["status"] == False or result.json()["id"] < 0): self.fail(
                        "response : " + result.text)
                    self.malware_id = result.json()["id"]

        # check malware status - READY , UPLOAD
        waiting = True
        while (waiting):
            values = {'malware_id': self.malware_id}
            result = requests.get("http://{0}:{1}/malware_info".format(self.cnc_ip, self.cnc_port), params=values)
            print(result.json()['msg'])
            if (result.json()['msg'] == 'READY'):
                waiting = False
            else:
                time.sleep(15)
        if (test_status == False): self.fail("Test_ERROR -> test_upload_Demo_malware ")

        print('malware_id ', self.malware_id, 'READY')

        # send
        values = {'malware_id': self.malware_id,
                  'agent_id': self.agent_id}

        result = requests.get("http://{0}:{1}/send_malware".format(self.cnc_ip, self.cnc_port), params=values)
        """
        Before the malware starts running, check that there is no residue from previous runs
        """
        if (result.json()["status"] == False): self.fail(result.json()["msg"])
        self.assertFalse(does_file_or_folder_exist('c:\\users\\%USERNAME%\\appdata\\local\\@28640.zip'))
        self.assertFalse(does_file_or_folder_exist('c:\\windows\\system32\\28643'))
        self.assertFalse(
            does_registry_exist('HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\\DPBJ Agent'))
        # run
        result = requests.get("http://{0}:{1}/run_malware".format(self.cnc_ip, self.cnc_port), params=values)
        if (result.json()["status"] == False): self.fail(result.json()["msg"])
        """
        After the malware has ran, there should be artifacts left
        """
        self.assertTrue(does_file_or_folder_exist('c:\\users\\%USERNAME%\\appdata\\local\\@28640.zip'))
        self.assertTrue(does_file_or_folder_exist('c:\\windows\\system32\\28643'))
        self.assertTrue(
            does_registry_exist('HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\\DPBJ Agent'))
        # revert
        """
        After the revert has happened, there should be no artifacts left on the system
        """
        result = requests.get("http://{0}:{1}/revert_malware".format(self.cnc_ip, self.cnc_port), params=values)
        if (result.json()["status"] == False): self.fail(result.json()["msg"])
        self.assertFalse(does_file_or_folder_exist('c:\\users\\%USERNAME%\\appdata\\local\\@28640.zip'))
        self.assertFalse(does_file_or_folder_exist('c:\\windows\\system32\\28643'))
        self.assertFalse(
            does_registry_exist('HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\\DPBJ Agent'))

        # except Exception as e:
        #     pass
