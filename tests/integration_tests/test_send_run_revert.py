import unittest
import requests
from agent import agent_main
from unittest import mock
from cnc import cnc_main
import os


class TestCNCMethods(unittest.TestCase):
    cnc_ip = -1
    cnc_port = -1
    malware_id = 20
    STORAGE_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'STORAGE_TEST')

    def setUp(self):
        self.cnc_ip = "127.0.0.1"
        self.cnc_port = "5000"
        # Run cnc
        cnc_thread = cnc_main.cnc()
        cnc_thread.setDaemon(True)
        cnc_thread.start()

        with mock.patch('agent.agent_main.input', side_effect=["127.0.0.1", 5000]):
            # run agent stub
            agent, agent_id, agent_ip, agent_port = agent_main.agent()

        agent.setDaemon(True)
        agent.start()

    def test_send_malware_to_agent(self):

        result = None
        try:

            # get Online Agent
            result = requests.get("http://{0}:{1}/agents".format(self.cnc_ip, self.cnc_port))
            if (len(result.json()["agents"]) <= 0): self.fail("no agents")

            # select agent
            agent = result.json()["agents"][0]

            values = {'malware_id': self.malware_id,
                      'agent_id': agent["id"]
                      }
            result = requests.get("http://{0}:{1}/send_malware".format(self.cnc_ip, self.cnc_port), params=values)
            print(result.text)
            # clean delete agent
            # agent_stub.delete_agent_from_db(agent_id)

            if (result.json()["status"] == False): self.fail(result.json()["msg"])
        # print(result.text)
        except NameError:
            self.fail(NameError)

    def test_malware_run(self):
        result = None
        try:

            # get Online Agent
            result = requests.get("http://{0}:{1}/agents".format(self.cnc_ip, self.cnc_port))
            if (len(result.json()["agents"]) <= 0): self.fail("no agents")

            # select agent
            agent = result.json()["agents"][0]

            values = {'malware_id': self.malware_id,
                      'agent_id': agent["id"]
                      }
            result = requests.get("http://{0}:{1}/send_malware".format(self.cnc_ip, self.cnc_port), params=values)

            if (result.json()["status"] == False): self.fail(result.json()["msg"])

            # run malware
            result = requests.get("http://{0}:{1}/run_malware".format(self.cnc_ip, self.cnc_port), params=values)

            if (result.json()["status"] == False): self.fail(result.json()["msg"])
            print(result.json())
            # clean delete agent
            # agent_main.delete_agent_from_db(agent_id)
        except Exception as e:
            self.fail(e.__str__())

    def test_malware_revert(self):
        result = None
        try:

            # get Online Agent
            result = requests.get("http://{0}:{1}/agents".format(self.cnc_ip, self.cnc_port))
            if (len(result.json()["agents"]) <= 0): self.fail("no agents")

            # select agent
            agent = result.json()["agents"][0]

            values = {'malware_id': self.malware_id,
                      'agent_id': agent["id"]
                      }

            # send
            result = requests.get("http://{0}:{1}/send_malware".format(self.cnc_ip, self.cnc_port), params=values)
            if (result.json()["status"] == False): self.fail(result.json()["msg"])

            # run
            result = requests.get("http://{0}:{1}/run_malware".format(self.cnc_ip, self.cnc_port), params=values)
            if (result.json()["status"] == False): self.fail(result.json()["msg"])

            # revert
            result = requests.get("http://{0}:{1}/revert_malware".format(self.cnc_ip, self.cnc_port), params=values)
            if (result.json()["status"] == False): self.fail(result.json()["msg"])

            # clean delete agent
            # agent_stub.delete_agent_from_db(agent_id)
        except Exception as e:
            self.fail(e.__str__())
