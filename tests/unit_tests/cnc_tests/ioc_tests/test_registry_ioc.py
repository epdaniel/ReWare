import unittest
import os
import csv
from cnc.iocs.registry_ioc import RegistryIOCs
from cnc.iocs.operation.create_operation import CreateOpertaion
from cnc.iocs.operation.delete_operation import DeleteOpertaion
from cnc.iocs.operation.modify_operation import ModifyOpertaion
from cnc.revert.compiler import Compiler
from winreg import *
import winreg
import subprocess
from datetime import datetime, timedelta
from cnc.iocs.csv_reader.csv_parser import CsvParser


class TestRegistryIOCreate(unittest.TestCase):

    path = 'HKEY_CURRENT_USER\\Software\\testReg'

    @classmethod
    def setUpClass(cls):
        ioc = [RegistryIOCs(cls.path, CreateOpertaion())]
        compiler = Compiler(ioc)
        cls.pre_code, cls.in_code, cls.post_code = compiler.get_code_as_string()

    def setUp(self):
        f = open(r'c:\csvlog\csvlog.csv', "w")
        f.close()

    def tearDown(self):
        try:
            os.remove(r'c:\csvlog\csvlog.csv')
            with subprocess.Popen(r'REG QUERY ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
                out, err = p.communicate()
                if not err:
                    p2 = subprocess.Popen(r'REG DELETE ' + self.path,stdin=subprocess.PIPE,
                                          stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
                    p2.communicate('Yes')
        except:
            pass

    def test_create_happy(self):
        with subprocess.Popen(r'REG ADD ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
            p.communicate()
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now(), 'Registry', self.path, 'Created', 'Completed'])
        f.close()

        exec(self.post_code)

        try:
            with subprocess.Popen(r'REG QUERY ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
                out, err = p.communicate()
                self.assertTrue(err)
        except:
            self.assertFalse(True)

    # User Modified the file after the malware, therfore should not be deleted
    def test_create_sad(self):
        with subprocess.Popen(r'REG ADD ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
            p.communicate()
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now()-timedelta(days=1), 'Registry', self.path, 'Created', 'Completed'])
        f.close()

        exec(self.post_code)

        try:
            with subprocess.Popen(r'REG QUERY ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
                out, err = p.communicate()
                self.assertFalse(err)
        except:
            self.assertFalse(True)

    # Key does not exist
    def test_create_bad(self):
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now(), 'Registry', self.path, 'Created', 'Completed'])
        f.close()

        exec(self.post_code)

        try:
            with subprocess.Popen(r'REG QUERY ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
                out, err = p.communicate()
                self.assertTrue(err)
        except:
            self.assertFalse(True)


class TestRegistryIOCDelete(unittest.TestCase):

    path = 'HKEY_CURRENT_USER\\Software\\testReg'

    @classmethod
    def setUpClass(cls):
        ioc = [RegistryIOCs(cls.path, DeleteOpertaion())]
        compiler = Compiler(ioc)
        cls.pre_code, cls.in_code, cls.post_code = compiler.get_code_as_string()

    def setUp(self):
        f = open(r'c:\csvlog\csvlog.csv', "w")
        f.close()

    def tearDown(self):
        try:
            os.remove(r'c:\csvlog\csvlog.csv')
            with subprocess.Popen(r'REG QUERY ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
                out, err = p.communicate()
                if not err:
                    p2 = subprocess.Popen(r'REG DELETE ' + self.path,stdin=subprocess.PIPE,
                                          stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
                    p2.communicate('Yes')
        except:
            pass

    def test_create_happy(self):
        with subprocess.Popen(r'REG ADD ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
            p.communicate()
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now(), 'Registry', self.path, 'Created', 'Completed'])
        f.close()

        exec(self.pre_code)

        p = subprocess.Popen(r'REG DELETE ' + self.path, stdin=subprocess.PIPE,
                             stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        p.communicate('Yes')

        exec(self.post_code)

        try:
            with subprocess.Popen(r'REG QUERY ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
                out, err = p.communicate()
                self.assertFalse(err)
        except:
            self.assertFalse(True)

    # User created new reg before post therfore no need to restore
    def test_create_sad(self):
        with subprocess.Popen(r'REG ADD ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
            p.communicate()
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now(), 'Registry', self.path, 'Created', 'Completed'])
        f.close()

        exec(self.pre_code)

        exec(self.post_code)

        try:
            with subprocess.Popen(r'REG QUERY ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
                out, err = p.communicate()
                self.assertFalse(err)
        except:
            self.assertFalse(True)

    # no such reg exists
    def test_create_bad(self):
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now(), 'Registry', self.path, 'Created', 'Completed'])
        f.close()

        exec(self.pre_code)

        exec(self.post_code)

        try:
            with subprocess.Popen(r'REG QUERY ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
                out, err = p.communicate()
                self.assertTrue(err)
        except:
            self.assertFalse(True)


class TestRegistryIOCModify(unittest.TestCase):

    path = 'HKEY_CURRENT_USER\\Software\\testReg'

    @classmethod
    def setUpClass(cls):
        ioc = [RegistryIOCs(cls.path, ModifyOpertaion())]
        compiler = Compiler(ioc)
        cls.pre_code, cls.in_code, cls.post_code = compiler.get_code_as_string()

    def setUp(self):
        f = open(r'c:\csvlog\csvlog.csv', "w")
        f.close()

    def tearDown(self):
        try:
            os.remove(r'c:\csvlog\csvlog.csv')
            with subprocess.Popen(r'REG QUERY ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
                out, err = p.communicate()
                if not err:
                    p2 = subprocess.Popen(r'REG DELETE ' + self.path,stdin=subprocess.PIPE,
                                          stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
                    p2.communicate('Yes')
        except:
            pass

    def test_create_happy(self):
        with subprocess.Popen(r'REG ADD ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
            p.communicate()
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now(), 'Registry', self.path, 'Created', 'Completed'])
        f.close()

        exec(self.pre_code)

        exec(self.post_code)

        try:

            with subprocess.Popen(r'REG QUERY ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
                out, err = p.communicate()
                if not err:
                    key = winreg.OpenKey(winreg.HKEY_CURRENT_USER, 'Software\\testReg')
                    mtime = datetime(1601, 1, 1) + timedelta(microseconds=winreg.QueryInfoKey(key)[2] // 10)
                    winreg.CloseKey(key)
                    parser = CsvParser(r'c:\csvlog\csvlog.csv')
                    line = parser.get_ioc_line_by_value(self.path)
                    csvtime = datetime.strptime(line.get_date_time(), '%Y-%m-%d %H:%M:%S.%f')
                    self.assertFalse(mtime > csvtime)
        except:
            self.assertFalse(True)

    # User modifed the reg after the malware therfore should not be restored
    def test_create_sad(self):
        with subprocess.Popen(r'REG ADD ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
            p.communicate()
        key = winreg.OpenKey(winreg.HKEY_CURRENT_USER, 'Software\\testReg')
        mtime = datetime(1601, 1, 1) + timedelta(microseconds=winreg.QueryInfoKey(key)[2] // 10)
        winreg.CloseKey(key)
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now()-timedelta(days=1), 'Registry', self.path, 'Created', 'Completed'])
        f.close()

        exec(self.pre_code)

        exec(self.post_code)

        try:

            with subprocess.Popen(r'REG QUERY ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
                out, err = p.communicate()
                if not err:
                    key = winreg.OpenKey(winreg.HKEY_CURRENT_USER, 'Software\\testReg')
                    mtime2 = datetime(1601, 1, 1) + timedelta(microseconds=winreg.QueryInfoKey(key)[2] // 10)
                    winreg.CloseKey(key)
                    self.assertTrue(mtime2 == mtime)
        except:
            self.assertFalse(True)

    # Reg does not exist
    def test_create_bad(self):
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now(), 'Registry', self.path, 'Created', 'Completed'])
        f.close()

        exec(self.pre_code)

        exec(self.post_code)

        try:

            with subprocess.Popen(r'REG QUERY ' + self.path, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
                out, err = p.communicate()
                if not err:
                    self.assertFalse(True)
                else:
                    self.assertTrue(True)
        except:
            self.assertFalse(True)
