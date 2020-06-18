import csv
import os
import os.path
import stat
import time
import unittest
from datetime import datetime, timedelta

from cnc.iocs.file_ioc import FileIOCs
from cnc.iocs.operation.create_operation import CreateOpertaion
from cnc.iocs.operation.delete_operation import DeleteOpertaion
from cnc.iocs.operation.modify_operation import ModifyOpertaion
from cnc.revert.compiler import Compiler


class TestFileIOCreate(unittest.TestCase):

    file_path = os.getenv('APPDATA') + "\\TestFileIocCreate.txt"

    @classmethod
    def setUpClass(cls):
        ioc = [FileIOCs(cls.file_path, CreateOpertaion())]
        compiler = Compiler(ioc)
        cls.pre_code, cls.in_code, cls.post_code = compiler.get_code_as_string()

    def setUp(self):
        f = open(r'c:\csvlog\csvlog.csv', "w")
        f.close()

    def tearDown(self):
        try:
            os.remove(r'c:\csvlog\csvlog.csv')
            os.remove(self.file_path)
        except:
            pass

    def test_create_happy(self):
        f = open(self.file_path, "w")
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now(), 'File', self.file_path, 'Created', 'Completed'])
        f.close()

        exec(self.post_code)

        self.assertFalse(os.path.exists(self.file_path))

    # The User modified the file, therefore it should not be deleted
    def test_create_sad(self):
        f = open(self.file_path, "w")
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now()-timedelta(days=1), 'File', self.file_path, 'Created', 'Completed'])
        f.close()

        exec(self.post_code)

        self.assertTrue(os.path.exists(self.file_path))

    # The file does not exist
    def test_create_bad(self):
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now(), 'File', self.file_path, 'Created', 'Completed'])
        f.close()

        exec(self.post_code)

        self.assertFalse(os.path.exists(self.file_path))


class TestFileIOCDelete(unittest.TestCase):

    file_path = os.getenv('APPDATA') + "\\TestFileIocDelete.txt"

    @classmethod
    def setUpClass(cls):
        ioc = [FileIOCs(cls.file_path, DeleteOpertaion())]
        compiler = Compiler(ioc)
        cls.pre_code, cls.in_code, cls.post_code = compiler.get_code_as_string()

    def setUp(self):
        f = open(r'c:\csvlog\csvlog.csv', "w")
        f.close()

    def tearDown(self):
        try:
            os.remove(r'c:\csvlog\csvlog.csv')
            os.remove(self.file_path)
        except FileNotFoundError:
            pass

    def test_create_happy(self):
        f = open(self.file_path, "w")
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now(), 'File', self.file_path, 'Deleted', 'Completed'])
        f.close()

        exec(self.pre_code)

        os.remove(self.file_path)

        exec(self.post_code)

        self.assertTrue(os.path.exists(self.file_path))

    # File was not deleted by the malware
    def test_create_sad(self):
        f = open(self.file_path, "w")
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now(), 'File', self.file_path, 'Deleted', 'Completed'])
        f.close()

        exec(self.pre_code)

        exec(self.post_code)

        self.assertTrue(os.path.exists(self.file_path))

    #
    def test_create_bad(self):
        f = open(self.file_path, "w")
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now(), 'File', self.file_path, 'Deleted', 'Completed'])
        f.close()

        exec(self.pre_code)

        os.remove(self.file_path)

        db = os.getenv('APPDATA') + "\\TempBackUpDB.txt"
        f = open(db, "r")
        content = f.readlines()
        for line in content:
            if line.split(' ')[0] == self.file_path:
                os.remove(os.getenv('APPDATA') + "\\backupTemp" + line.split(' ')[1].rstrip())
        f.close()

        exec(self.post_code)

        self.assertFalse(os.path.exists(self.file_path))


class TestFileIOCModify(unittest.TestCase):

    file_path = os.getenv('APPDATA') + "\\TestFileIocModify.txt"

    @classmethod
    def setUpClass(cls):
        ioc = [FileIOCs(cls.file_path, ModifyOpertaion())]
        compiler = Compiler(ioc)
        cls.pre_code, cls.in_code, cls.post_code = compiler.get_code_as_string()

    def setUp(self):
        f = open(r'c:\csvlog\csvlog.csv', "w")
        f.close()

    def tearDown(self):
        try:
            os.remove(r'c:\csvlog\csvlog.csv')
            os.remove(self.file_path)
        except FileNotFoundError:
            pass

    def test_create_happy(self):
        f = open(self.file_path, "w")
        f.close()
        stats = os.stat(self.file_path)
        timestr = time.ctime(stats[stat.ST_MTIME])
        mtime = datetime.strptime(timestr, '%a %b  %d %H:%M:%S %Y')
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now(), 'File', self.file_path, 'Updated', 'Completed'])
        f.close()

        exec(self.pre_code)

        exec(self.post_code)

        stats = os.stat(self.file_path)
        timestr = time.ctime(stats[stat.ST_MTIME])
        mtimeU = datetime.strptime(timestr, '%a %b  %d %H:%M:%S %Y')
        self.assertTrue(mtimeU == mtime)

    # The User modified the file, therefore it should not be recreated
    def test_create_sad(self):
        f = open(self.file_path, "w")
        f.close()
        stats = os.stat(self.file_path)
        timestr = time.ctime(stats[stat.ST_MTIME])
        mtime = datetime.strptime(timestr, '%a %b  %d %H:%M:%S %Y')
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now()-timedelta(days=1), 'File', self.file_path, 'Updated', 'Completed'])
        f.close()

        exec(self.pre_code)

        exec(self.post_code)

        stats = os.stat(self.file_path)
        timestr = time.ctime(stats[stat.ST_MTIME])
        mtimeU = datetime.strptime(timestr, '%a %b  %d %H:%M:%S %Y')
        self.assertTrue(mtimeU >= mtime)

    # The file does not exist
    def test_create_bad(self):
        f = open(self.file_path, "w")
        f.close()
        stats = os.stat(self.file_path)
        timestr = time.ctime(stats[stat.ST_MTIME])
        mtime = datetime.strptime(timestr, '%a %b  %d %H:%M:%S %Y')
        f = open(r'c:\csvlog\csvlog.csv', "w")
        filewriter = csv.writer(f, delimiter=',')
        test = csv.DictWriter(f, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType','OpResult'])
        test.writeheader()
        f.close()
        f = open(r'c:\csvlog\csvlog.csv', 'a')
        writer = csv.writer(f)
        writer.writerow(['127.0.0.1', datetime.now(), 'File', self.file_path, 'Updated', 'Completed'])
        f.close()

        exec(self.pre_code)
        os.remove(self.file_path)
        exec(self.post_code)

        self.assertFalse(os.path.exists(self.file_path))
