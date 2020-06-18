import unittest
import os
import psutil
import time
from cnc.iocs.process_ioc import ProcessIOCs
from cnc.iocs.operation.create_operation import CreateOpertaion
from cnc.revert.compiler import Compiler
from subprocess import call


class TestProcessIOC(unittest.TestCase):

    process_name = "Calculator"
    os.system('calc')
    ioc = [ProcessIOCs(process_name, CreateOpertaion())]
    compiler = Compiler(ioc)
    pre_code, in_code, post_code = compiler.get_code_as_string()

    def tearDown(self):
        for proc in psutil.process_iter():
            if self.process_name + ".exe" == proc.name() or self.process_name == proc.name():
                proc.kill()

    def test_create_happy(self):

        exec(self.pre_code+self.in_code+self.post_code)
        for proc in psutil.process_iter():
            if self.process_name + ".exe" == proc.name() or self.process_name == proc.name():
                self.assertFalse(True)
        self.assertTrue(True)

    # nothing to delete
    def test_create_sad(self):

        exec(self.pre_code+self.in_code+self.post_code)
        for proc in psutil.process_iter():
            if self.process_name + ".exe" == proc.name() or self.process_name == proc.name():
                self.assertFalse(True)
        self.assertTrue(True)


