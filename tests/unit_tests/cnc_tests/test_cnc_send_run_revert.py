import unittest
import requests
from agent import agent_stub
from cnc import cnc_main
import json
import os


class TestCNCMethods(unittest.TestCase):
    cnc_ip = -1
    cnc_port = -1

    STORAGE_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'STORAGE_TEST')

    def setUp(self):
        self.cnc_ip = "127.0.0.1"
        self.cnc_port = "5000"
        # Run cnc
        cnc_thread = cnc_main.cnc();
        cnc_thread.setDaemon(True);
        cnc_thread.start()

    def test_status(self):
        result = None
        try:
            values = {}
            result = requests.get("http://{0}:{1}/".format(self.cnc_ip, self.cnc_port))
            expected = {"status": True, "err_code": 0}
            self.assertEqual(str(expected), str(result.json()))
        except NameError:
            self.fail(NameError)

    def test_agents(self):
        result = None
        try:
            values = {}
            result = requests.get("http://{0}:{1}/agents".format(self.cnc_ip, self.cnc_port))
            if (result.json()["status"] == False): self.fail("server response false")

        except NameError:
            self.fail(NameError)

    def test_agents_validate_response(self):
        result = None
        try:
            values = {}
            result = requests.get("http://{0}:{1}/agents".format(self.cnc_ip, self.cnc_port))

            if (len(result.json()["agents"]) < 0): self.fail("agents array is < 0")

        except NameError:
            self.fail(NameError)

    def test_upload_Demo_malware(self):

        result = None
        try:
            values = {'malware_name': 'Im_a_test_malware',
                      'malware_description': 'malware_description_is_just_a_test'

                      }

            test_status = False
            with  open(self.STORAGE_PATH + "\\demo_malware.exe", 'rb') as malware_exe:
                with  open(self.STORAGE_PATH + "\\demo_malware.csv", 'rb') as malware_csv:
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
                        # print(result.json())

            if (test_status == False): self.fail("Test_ERROR -> test_upload_Demo_malware ")

        except Exception as e:
            self.fail(e.__str__())

    def test_upload_Null_File_malware(self):
        result = None
        try:
            values = {'malware_name': 'Im_a_test_malware',
                      'malware_description': 'malware_description_is_just_a_test'
                      }
            result = requests.post("http://{0}:{1}/uploader".format(self.cnc_ip, self.cnc_port), files=None,
                                   data=values)
            if (result.json()["status"] == True or result.json()["err_code"] != 500): self.fail(
                "response : " + result.text)
            print(result.json())
        except NameError:
            self.fail(NameError)

    def test_upload_None_File_malware(self):
        result = None
        try:
            result = requests.post("http://{0}:{1}/uploader".format(self.cnc_ip, self.cnc_port), files=None, data=None)
            if (result.json()["status"] == True or result.json()["err_code"] != 500): self.fail(
                "response : " + result.text)
        except NameError:
            self.fail(NameError)

    def test_upload_None_File_malware(self):
        result = None
        try:
            result = requests.post("http://{0}:{1}/uploader".format(self.cnc_ip, self.cnc_port), files=None, data=None)
            if (result.json()["status"] == True or result.json()["err_code"] != 500): self.fail(
                "response : " + result.text)
        except NameError:
            self.fail(NameError)
