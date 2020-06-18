import os
import unittest
import requests
import shutil
from unittest import mock
from agent import agent_main

MALWARE_CSV_PATH = os.path.join("C:" + os.sep, "csvlog")
STORAGE_PATH = os.path.join("..", "..", "STORAGE_TEST")
AGENT_PATH = os.path.join("C:" + os.sep, "Users", "Public", "ReWare Agent")
LOGS_PATH = os.path.join(AGENT_PATH, 'logs')


class TestAgentMethods(unittest.TestCase):
    agent_ip = -1
    agent_port = -1

    def setUp(self):
        if os.path.isdir('c:/temp_deletemeplease'):
            shutil.rmtree('c:/temp_deletemeplease')
        with mock.patch('agent.agent_main.input', return_value="-1"):
            with mock.patch('agent.agent_main.turn_agent_active', return_value=True):
                agent_thread, agent_id, self.agent_ip, self.agent_port = agent_main.agent()
        agent_thread.setDaemon(True)
        agent_thread.start()

    def test_status(self):
        result = None
        try:
            values = {}
            result = requests.get("http://{0}:{1}/".format(self.agent_ip, self.agent_port))
            expected = {"status": True, "err_code": 0}
            self.assertEqual(expected, result.json())
        except NameError:
            self.fail(NameError)

    def test_upload_malware(self):
        result = None
        try:
            with mock.patch('agent.agent_main.add_malware_in_db', return_value=True):
                m_id = 1
                path = AGENT_PATH + "/temp/" + str(m_id)
                with open(STORAGE_PATH + '/test_csv_malware.zip', 'rb') as zip_file:
                    files = {'malware_files': zip_file}
                    values = {'malware_id': m_id}
                    result = requests.post("http://{0}:{1}/upload".format(self.agent_ip, self.agent_port), files=files,
                                           data=values)

                expected = {"status": True, "err_code": 0}
                self.assertEqual(expected, result.json())
                self.assertTrue(os.path.isdir(path))
                self.assertTrue(os.path.exists(path + '/pre.exe'))
                self.assertTrue(os.path.exists(path + '/malware.exe'))
                self.assertTrue(os.path.exists(path + '/post.exe'))
        except NameError:
            self.fail(NameError)

    def test_upload_same_malware(self):
        self.test_upload_malware()
        self.test_upload_malware()

    def test_upload_bad_filetype_malware(self):
        result = None
        try:
            with open(STORAGE_PATH + '/bad_file_type.txt', 'rb') as zip_file:
                files = {'malware_files': zip_file}
                values = {'malware_id': 1}
                result = requests.post("http://{0}:{1}/upload".format(self.agent_ip, self.agent_port), files=files,
                                       data=values)

            expected = {"status": False, "err_code": -10}
            self.assertEqual(result.json()["status"], expected["status"])
            self.assertEqual(result.json()["err_code"], expected["err_code"])
        except NameError:
            self.fail(NameError)

    def test_upload_bad_malware_zip(self):
        result = None
        try:
            with open(STORAGE_PATH + '/test_bad_malware.zip', 'rb') as zip_file:
                files = {'malware_files': zip_file}
                values = {'malware_id': 1}
                result = requests.post("http://{0}:{1}/upload".format(self.agent_ip, self.agent_port), files=files,
                                       data=values)

            expected = {"status": False, "err_code": -20}
            self.assertEqual(result.json()["status"], expected["status"])
            self.assertEqual(result.json()["err_code"], expected["err_code"])
        except NameError:
            self.fail(NameError)

    def test_run_malware(self):
        result = None
        try:
            with mock.patch('agent.agent_main.change_status_in_db', return_value=True):
                self.test_upload_malware()
                values = {'malware_id': 1}
                result = requests.post("http://{0}:{1}/run".format(self.agent_ip, self.agent_port), data=values)
                expected = {"status": True, "err_code": 0}
                self.assertEqual(expected, result.json())
                self.assertTrue(os.path.isdir("C:/temp_deletemeplease"))
        except NameError:
            self.fail(NameError)

    def test_run_nonexistant_malware(self):
        result = None
        try:
            values = {'malware_id': 500}
            result = requests.post("http://{0}:{1}/run".format(self.agent_ip, self.agent_port), data=values)
            expected = {"status": False, "err_code": -404}
            self.assertEqual(result.json()["status"], expected["status"])
            self.assertEqual(result.json()["err_code"], expected["err_code"])
        except NameError:
            self.fail(NameError)

    def test_revert_malware(self):
        result = None
        try:
            with mock.patch('agent.agent_main.change_status_in_db', return_value=True):
                self.test_run_malware()
                values = {'malware_id': 1}
                result = requests.post("http://{0}:{1}/revert".format(self.agent_ip, self.agent_port), data=values)
                expected = {"status": True, "err_code": 0}
                self.assertEqual(expected, result.json())
        except NameError:
            self.fail(NameError)

    def test_revert_nonexistant_malware(self):
        result = None
        try:
            values = {'malware_id': 500}
            result = requests.post("http://{0}:{1}/revert".format(self.agent_ip, self.agent_port), data=values)
            expected = {"status": False, "err_code": -404}
            self.assertEqual(result.json()["status"], expected["status"])
            self.assertEqual(result.json()["err_code"], expected["err_code"])
        except NameError:
            self.fail(NameError)

    def test_run_malware_no_csv(self):
        result = None
        try:
            with mock.patch('agent.agent_main.change_status_in_db', return_value=True):
                with mock.patch('agent.agent_main.add_malware_in_db', return_value=True):
                    if os.path.isdir(MALWARE_CSV_PATH):  # if malware csv folder already exists, remove it
                        shutil.rmtree(MALWARE_CSV_PATH)
                    m_id = 20
                    with open(STORAGE_PATH + '/no_csv_malware.zip', 'rb') as zip_file:
                        files = {'malware_files': zip_file}
                        values = {'malware_id': m_id}
                        requests.post("http://{0}:{1}/upload".format(self.agent_ip, self.agent_port),
                                               files=files,
                                               data=values)

                    result = requests.post("http://{0}:{1}/run".format(self.agent_ip, self.agent_port), data=values)
                    expected = {"status": False, "err_code": -100}
                    self.assertEqual(result.json()["status"], expected["status"])
                    self.assertEqual(result.json()["err_code"], expected["err_code"])
        except NameError:
            self.fail(NameError)

    def test_read_malware_csv(self):
        result = None
        try:
            if os.path.isdir(MALWARE_CSV_PATH):  # if malware csv folder already exists, remove it and it's contents
                shutil.rmtree(MALWARE_CSV_PATH)
            os.mkdir(MALWARE_CSV_PATH)

            agent_main.READ_CSV_INDEXES = []
            shutil.copy2(STORAGE_PATH + '/test_csv.csv', MALWARE_CSV_PATH)
            self.assertEqual(agent_main.read_malware_csv(1), True)
        except NameError:
            self.fail(NameError)

    def test_read_malware_csv_no_csv(self):
        result = None
        try:
            if os.path.isdir(MALWARE_CSV_PATH):  # if malware csv folder already exists, remove it and it's contents
                shutil.rmtree(MALWARE_CSV_PATH)
            os.mkdir(MALWARE_CSV_PATH)

            agent_main.READ_CSV_INDEXES = []
            self.assertEqual(agent_main.read_malware_csv(1), False)
        except NameError:
            self.fail(NameError)

    def test_get_logs(self):
        result = None
        try:
            self.test_run_malware()
            res = requests.post("http://{0}:{1}/get_logs".format(self.agent_ip, self.agent_port))
            res = res.json()
            last_elem = res[len(res) - 1]
            second_last_elem = res[len(res) - 2]
            self.assertEqual(len(last_elem), 7)
            self.assertEqual(len(second_last_elem), 7)
            self.assertEqual('RUNNING' in second_last_elem, True)
            self.assertEqual(1 in second_last_elem, True)
            self.assertEqual('Finished running malware successfully' in last_elem, True)
            self.assertEqual('WAITING' in last_elem, True)
            self.assertEqual(1 in last_elem, True)
        except NameError:
            self.fail(NameError)

    def test_run_exe(self):
        result = None
        try:
            with open(STORAGE_PATH + '/test_exe.exe', 'rb') as exe_file:
                files = {'exe_file': exe_file}
                values = {}
                result = requests.post("http://{0}:{1}/run_exe".format(self.agent_ip, self.agent_port), files=files,
                                           data=values)

            expected = {"status": True, "err_code": 0}
            self.assertEqual(expected, result.json())
            self.assertEqual(True, os.path.isdir('c:/temp_deletemeplease'))
        except NameError:
            self.fail(NameError)

    def test_read_exe_csv(self):
        result = None
        try:
            if os.path.isdir(LOGS_PATH):  # if logs csv folder already exists, remove it and it's contents
                shutil.rmtree(LOGS_PATH)
            os.mkdir(LOGS_PATH)

            agent_main.READ_CSV_INDEXES = []
            shutil.copy2(STORAGE_PATH + '/1_POST.csv', LOGS_PATH)
            self.assertEqual(agent_main.read_exe_csv(1, "POST"), True)
        except NameError:
            self.fail(NameError)

    def test_read_exe_csv_no_csv(self):
        result = None
        try:
            if os.path.isdir(LOGS_PATH):  # if logs csv folder already exists, remove it and it's contents
                shutil.rmtree(LOGS_PATH)
            os.mkdir(LOGS_PATH)

            agent_main.READ_CSV_INDEXES = []
            self.assertEqual(agent_main.read_exe_csv(1, "POST"), False)
        except NameError:
            self.fail(NameError)