import inspect

from cnc.iocs.abstract_ioc import AbstractIOCs
from cnc.iocs.operation.create_operation import CreateOpertaion
from cnc.iocs.operation.delete_operation import DeleteOpertaion
from cnc.iocs.operation.modify_operation import ModifyOpertaion
from cnc.revert.code_template import *


def task_create_post(self):
    path = r'{ioc_val}'

    try:
        os.system(f"schtasks /delete /tn {path} /f")
    except Exception as e:
        pass


def task_delete_pre(self):
    path = r'{ioc_val}'

    try:
        id = str(uuid.uuid4())
        db = os.getenv('APPDATA') + "\\TempBackUpDB.txt"
        f = open(db, "a+")
        f.write(path + " " + id + "\n")
        f.close()
        os.system(f"schtasks /query /xml /tn {path} > " + os.getenv('APPDATA') + "\\BackUpTask" + id + ".xml")
    except Exception as e:
        pass


def task_delete_post(self):
    path = r'{ioc_val}'

    try:
        db = os.getenv('APPDATA') + "\\TempBackUpDB.txt"
        f = open(db, "r")
        content = f.readlines()
        for line in content:
            if line.split(' ')[0] == path:
                bkpath = os.getenv('APPDATA') + "\\BackUpTask" + line.split(' ')[1].rstrip() + ".xml"
        f.close()

        os.system(f"schtasks /create /XML {bkpath} /tn {path}")
        os.remove(bkpath)
    except Exception as e:
        pass


def task_modify_pre(self):
    path = r'{ioc_val}'

    try:
        id = str(uuid.uuid4())
        db = os.getenv('APPDATA') + "\\TempBackUpDB.txt"
        f = open(db, "a+")
        f.write(path + " " + id + "\n")
        f.close()
        os.system(f"schtasks /query /xml /tn {path} > " + os.getenv('APPDATA') + "\\BackUpTask" + id + ".xml")
    except Exception as e:
        pass


def task_modify_post(self):
    path = r'{ioc_val}'

    try:
        db = os.getenv('APPDATA') + "\\TempBackUpDB.txt"
        f = open(db, "r")
        content = f.readlines()
        for line in content:
            if line.split(' ')[0] == path:
                bkpath = os.getenv('APPDATA') + "\\BackUpTask" + line.split(' ')[1].rstrip() + ".xml"
        f.close()

        os.system(f"schtasks /delete /tn {path} /f")
        os.system(f"schtasks /create /XML {bkpath} /tn {path}")
        os.remove(bkpath)
    except Exception as e:
        pass


class TaskIOCs(AbstractIOCs):
    def __init__(self, value, operation):
        super().__init__('Task', value, operation)

    def get_code_create(self, operation: CreateOpertaion):
        ioc_val = self._ioc_value
        pre_code = None
        in_code = None
        post_code = inspect.getsourcelines(task_create_post)[0]
        post_code = self.standartisize_code(post_code, ioc_val)
        return pre_code, in_code, post_code

    def get_code_delete(self, operation: DeleteOpertaion):
        ioc_val = self._ioc_value
        pre_code = inspect.getsourcelines(task_delete_pre)[0]
        pre_code = self.standartisize_code(pre_code, ioc_val)
        in_code = None
        post_code = inspect.getsourcelines(task_delete_post)[0]
        post_code = self.standartisize_code(post_code, ioc_val)
        return pre_code, in_code, post_code

    def get_code_modify(self, operation: ModifyOpertaion):
        ioc_val = self._ioc_value
        pre_code = inspect.getsourcelines(task_modify_pre)[0]
        pre_code = self.standartisize_code(pre_code, ioc_val)
        in_code = None
        post_code = inspect.getsourcelines(task_modify_post)[0]
        post_code = self.standartisize_code(post_code, ioc_val)
        return pre_code, in_code, post_code
