import os
import shutil
import unittest

from cnc.exceptions.failed_to_compile_exception import FailedToCompileException
from cnc.ioc_parser import IocParser
from cnc.iocs.file_ioc import FileIOCs
from cnc.iocs.operation.create_operation import CreateOpertaion
from cnc.revert.compiler import Compiler


class TestCompileCode(unittest.TestCase):
    def setUp(self):
        self.cur_dir = os.getcwd()
        self.assets_dir = f'{self.cur_dir}\\assets'
        if os.path.isdir(self.assets_dir):
            shutil.rmtree(self.assets_dir)
        os.mkdir(self.assets_dir)

    def tearDown(self):
        self.assets_dir = f'{self.cur_dir}\\assets'
        self.build_dir = f'{self.cur_dir}\\build'
        if os.path.isdir(self.assets_dir):
            shutil.rmtree(self.assets_dir)
        if os.path.isdir(self.build_dir):
            shutil.rmtree(self.build_dir)

    def test_get_code_simple(self):
        f1 = FileIOCs('c:\\test1', CreateOpertaion())
        f2 = FileIOCs('c:\\test2', CreateOpertaion())
        c = Compiler([f1, f2], 1)
        res = c.get_code_as_string()
        self.assertEqual(len(res), 3)

    def test_compile_to_exe_simple(self):
        f1 = FileIOCs('c:\\test1', CreateOpertaion())
        f2 = FileIOCs('c:\\test2', CreateOpertaion())
        c = Compiler([f1, f2], 1)
        cur_dir = os.getcwd()
        python_text = 'print("hello world")'
        file_name = 'test_python_1'
        temp_python_path = f'{cur_dir}\\{file_name}.py'
        with open(temp_python_path, 'w') as f:
            f.write(python_text)
        c.compile_to_exe(self.cur_dir + '\\', temp_python_path)
        res = os.popen(f'{self.assets_dir}\\{file_name}.exe').read()
        os.remove(f'{self.cur_dir}\\{file_name}.py')
        os.remove(f'{self.cur_dir}\\{file_name}.spec')
        self.assertEqual(res, 'hello world\n')

    def test_sad(self):
        f = FileIOCs('c:\\test2', CreateOpertaion())
        c = Compiler([f], 1)
        cur_dir = os.getcwd()
        python_text = 'print("hello world)'
        file_name = 'test_python_1'
        temp_python_path = f'{cur_dir}\\{file_name}.py'
        with open(temp_python_path, 'w') as f:
            f.write(python_text)
        try:
            c.compile_to_exe(self.cur_dir + '\\', temp_python_path)
            res = os.popen(f'{self.assets_dir}\\{file_name}.exe').read()
            self.assertFalse(True)
        except FailedToCompileException:
            self.assertTrue(True)
        finally:
            os.remove(f'{self.cur_dir}\\{file_name}.py')
            os.remove(f'{self.cur_dir}\\{file_name}.spec')

    def test_dyre_compile_pre(self):
        cur_dir = os.getcwd()

        csv = 'DyreCSV.csv'
        ip = IocParser(csv)
        res = ip.get_parsed_results()
        c = Compiler(res, 1)
        python_text = c.get_code_as_string()[2]
        file_name = 'test_dyre'
        temp_python_path = f'{cur_dir}\\{file_name}.py'
        with open(temp_python_path, 'w') as f:
            f.write(python_text)
        try:
            c.compile_to_exe(self.cur_dir + '\\', temp_python_path)
            res = os.popen(f'{self.assets_dir}\\{file_name}.exe').read()
            self.assertTrue(True)
        except FailedToCompileException:
            self.assertFalse(True)
        finally:
            os.remove(f'{self.cur_dir}\\{file_name}.py')
            os.remove(f'{self.cur_dir}\\{file_name}.spec')

    def test_ardamax_compile_pre(self):
        cur_dir = os.getcwd()

        csv = 'PoweliksCSV.csv'
        ip = IocParser(csv)
        res = ip.get_parsed_results()
        c = Compiler(res, 1)
        python_text = c.get_code_as_string()[0]
        pre_file_name = 'pre_Powliks'
        pre_python_path = f'{cur_dir}\\{pre_file_name}.py'
        with open(pre_python_path, 'w') as f:
            f.write(python_text)
        try:
            c.compile_to_exe(self.cur_dir + '\\', pre_python_path)
            res = os.popen(f'{self.assets_dir}\\{pre_file_name}.exe').read()
            self.assertTrue(True)
        except FailedToCompileException:
            self.assertFalse(True)

        python_text = c.get_code_as_string()[2]
        post_file_name = 'post_Powliks'
        pre_python_path = f'{cur_dir}\\{post_file_name}.py'
        with open(pre_python_path, 'w') as f:
            f.write(python_text)
        try:
            c.compile_to_exe(self.cur_dir + '\\', pre_python_path)
            res = os.popen(f'{self.assets_dir}\\{post_file_name}.exe').read()
            self.assertTrue(True)
        except FailedToCompileException:
            self.assertFalse(True)
        os.remove(f'{pre_python_path}')
        os.remove(f'{self.cur_dir}\\{post_file_name}.spec')
        os.remove(f'{self.cur_dir}\\{pre_file_name}.py')
        os.remove(f'{self.cur_dir}\\{pre_file_name}.spec')

    def test_demo_malware_compile_pre(self):
        cur_dir = os.getcwd()

        csv = 'demo_malware.csv'
        ip = IocParser(csv)
        res = ip.get_parsed_results()
        c = Compiler(res, 1)
        python_text = c.get_code_as_string()[2]
        file_name = 'demo_malware'
        temp_python_path = f'{cur_dir}\\{file_name}.py'
        with open(temp_python_path, 'w') as f:
            f.write(python_text)
        try:
            c.compile_to_exe(self.cur_dir + '\\', temp_python_path)
            res = os.popen(f'{self.assets_dir}\\{file_name}.exe').read()
            self.assertTrue(True)
        except FailedToCompileException:
            self.assertFalse(True)
        finally:
            os.remove(f'{self.cur_dir}\\{file_name}.py')
            os.remove(f'{self.cur_dir}\\{file_name}.spec')
