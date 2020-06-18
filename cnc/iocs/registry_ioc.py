import inspect

from cnc.iocs.abstract_ioc import AbstractIOCs
from cnc.iocs.operation.create_operation import CreateOpertaion
from cnc.iocs.operation.delete_operation import DeleteOpertaion
from cnc.iocs.operation.modify_operation import ModifyOpertaion
from cnc.revert.code_template import *


def reg_create_post(self):


    name = r'{ioc_val}'
    try:
        split = name.split('\\', 1)
        Rkey = split[1].rsplit('\\', 1)[0]
        value = split[1].rsplit('\\', 1)[1]
        baseSTR = split[0]
        if split[0] == 'HKEY_CURRENT_USER':
            base = winreg.HKEY_CURRENT_USER
            baseSTR = 'HKCU'
        if split[0] == 'HKLM':
            base = winreg.HKEY_LOCAL_MACHINE
        if split[0] == 'HKCU':
            base = winreg.HKEY_CURRENT_USER
        if split[0] == 'HKCC':
            base = winreg.HKEY_CURRENT_CONFIG
        if split[0] == 'HKU':
            base = winreg.HKEY_USERS
        if split[0] == 'HKCR':
            base = winreg.HKEY_CLASSES_ROOT
        pathReg = baseSTR + '\\' + Rkey
        pathReg = pathReg.replace('\\\\', '\\')
        key = winreg.OpenKey(base, Rkey)
        mtime = datetime(1601, 1, 1) + timedelta(microseconds=winreg.QueryInfoKey(key)[2] // 10)
        winreg.CloseKey(key)

        line = parser.get_ioc_line_by_value(name)
        csvtime = datetime.strptime(line.get_date_time(), '%Y-%m-%d %H:%M:%S.%f')

        try:
            if csvtime >= mtime:
                p = subprocess.Popen(r'REG DELETE "' + pathReg + '" /v "' + value + '" /f',
                                     stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
                p.communicate()
        except Exception as e:
            pass
    except Exception as e:
        pass


def reg_delete_pre(self):
    name = r'{ioc_val}'
    split = name.split('\\', 1)
    Rkey = name.rsplit('\\', 1)[0]
    baseSTR = split[0]
    if split[0] == 'HKEY_CURRENT_USER':
        base = winreg.HKEY_CURRENT_USER
        baseSTR = 'HKCU'
    if split[0] == 'HKLM':
        base = winreg.HKEY_LOCAL_MACHINE
    if split[0] == 'HKCU':
        base = winreg.HKEY_CURRENT_USER
    if split[0] == 'HKCC':
        base = winreg.HKEY_CURRENT_CONFIG
    if split[0] == 'HKU':
        base = winreg.HKEY_USERS
    if split[0] == 'HKCR':
        base = winreg.HKEY_CLASSES_ROOT
    pathReg = baseSTR + '\\' + Rkey
    pathReg = pathReg.replace('\\\\', '\\')
    id = str(uuid.uuid4())
    db = os.getenv('APPDATA') + "\\TempBackUpDB.txt"
    bkpath = os.getenv('APPDATA') + "\\backupTemp" + id + ".hiv"
    try:
        p = subprocess.Popen(r'REG QUERY "' + pathReg + '"', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        out, err = p.communicate()
        if not err:
            p = subprocess.Popen(r'REG SAVE "' + pathReg + '" ' + bkpath, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            p.communicate()
            f = open(db, "a+")
            f.write(name + " " + id + "\n")
            f.close()
    except Exception as e:
        pass


def reg_delete_post(self):
    name = r'{ioc_val}'
    split = name.split('\\', 1)
    Rkey = name.rsplit('\\', 1)[0]
    baseSTR = split[0]
    if split[0] == 'HKEY_CURRENT_USER':
        base = winreg.HKEY_CURRENT_USER
        baseSTR = 'HKCU'
    if split[0] == 'HKLM':
        base = winreg.HKEY_LOCAL_MACHINE
    if split[0] == 'HKCU':
        base = winreg.HKEY_CURRENT_USER
    if split[0] == 'HKCC':
        base = winreg.HKEY_CURRENT_CONFIG
    if split[0] == 'HKU':
        base = winreg.HKEY_USERS
    if split[0] == 'HKCR':
        base = winreg.HKEY_CLASSES_ROOT
    pathReg = baseSTR + '\\' + Rkey
    pathReg = pathReg.replace('\\\\', '\\')
    try:
        db = os.getenv('APPDATA') + "\\TempBackUpDB.txt"
        f = open(db, "r")
        content = f.readlines()
        for line in content:
            if line.split(' ')[0] == name:
                bkpath = os.getenv('APPDATA') + "\\backupTemp" + line.split(' ')[1].rstrip() + ".hiv"
        f.close()

        if os.path.exists(bkpath):
            p = subprocess.Popen(r'REG QUERY "' + pathReg + '"', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            out, err = p.communicate()
            if err:
                with subprocess.Popen(r'REG ADD "' + pathReg + '"', stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
                    p.communicate()
                p = subprocess.Popen(r'REG RESTORE "' + pathReg + '" ' + bkpath, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                p.communicate()
            else:
                key = winreg.OpenKey(base, split[1])
                mtime = datetime(1601, 1, 1) + timedelta(microseconds=winreg.QueryInfoKey(key)[2] // 10)
                winreg.CloseKey(key)
                line = parser.get_ioc_line_by_value(name)
                csvtime = datetime.strptime(line.get_date_time(), '%Y-%m-%d %H:%M:%S.%f')

                if csvtime >= mtime:
                    p = subprocess.Popen(r'REG RESTORE "' + pathReg + '" ' + bkpath, stdout=subprocess.PIPE,
                                         stderr=subprocess.PIPE)
                    p.communicate()
            try:
                os.remove(bkpath)
            except:
                pass
    except Exception as e:
        pass


def reg_modify_pre(self):
    name = r'{ioc_val}'
    Rkey = name.rsplit('\\', 1)[0]
    split = name.split('\\', 1)
    baseSTR = split[0]
    if split[0] == 'HKEY_CURRENT_USER':
        base = winreg.HKEY_CURRENT_USER
        baseSTR = 'HKCU'
    if split[0] == 'HKLM':
        base = winreg.HKEY_LOCAL_MACHINE
    if split[0] == 'HKCU':
        base = winreg.HKEY_CURRENT_USER
    if split[0] == 'HKCC':
        base = winreg.HKEY_CURRENT_CONFIG
    if split[0] == 'HKU':
        base = winreg.HKEY_USERS
    if split[0] == 'HKCR':
        base = winreg.HKEY_CLASSES_ROOT
    pathReg = baseSTR + '\\' + Rkey
    pathReg = pathReg.replace('\\\\', '\\')
    id = str(uuid.uuid4())
    db = os.getenv('APPDATA') + "\\TempBackUpDB.txt"
    bkpath = os.getenv('APPDATA') + "\\backupTemp" + id + ".hiv"
    try:
        p = subprocess.Popen(r'REG QUERY "' + pathReg + '"', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        out, err = p.communicate()
        if not err:
            p = subprocess.Popen(r'REG SAVE "' + pathReg + '" ' + bkpath, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            p.communicate()
            f = open(db, "a+")
            f.write(name + " " + id + "\n")
            f.close()
    except Exception as e:
        pass


def reg_modify_post(self):

    name = r'{ioc_val}'
    Rkey = name.rsplit('\\', 1)[0]
    split = name.split('\\', 1)
    baseSTR = split[0]
    if split[0] == 'HKEY_CURRENT_USER':
        base = winreg.HKEY_CURRENT_USER
        baseSTR = 'HKCU'
    if split[0] == 'HKLM':
        base = winreg.HKEY_LOCAL_MACHINE
    if split[0] == 'HKCU':
        base = winreg.HKEY_CURRENT_USER
    if split[0] == 'HKCC':
        base = winreg.HKEY_CURRENT_CONFIG
    if split[0] == 'HKU':
        base = winreg.HKEY_USERS
    if split[0] == 'HKCR':
        base = winreg.HKEY_CLASSES_ROOT
    pathReg = baseSTR + '\\' + Rkey
    pathReg = pathReg.replace('\\\\', '\\')
    db = os.getenv('APPDATA') + "\\TempBackUpDB.txt"
    f = open(db, "r")
    content = f.readlines()
    for line in content:
        if line.split(' ')[0] == name:
            bkpath = os.getenv('APPDATA') + "\\backupTemp" + line.split(' ')[1].rstrip() + ".hiv"
    f.close()

    key = winreg.OpenKey(base, split[1])
    mtime = datetime(1601, 1, 1) + timedelta(microseconds=winreg.QueryInfoKey(key)[2] // 10)
    winreg.CloseKey(key)

    line = parser.get_ioc_line_by_value(name)
    csvtime = datetime.strptime(line.get_date_time(), '%Y-%m-%d %H:%M:%S.%f')
    if os.path.exists(bkpath):
        p = subprocess.Popen(r'REG QUERY ' + pathReg, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        out, err = p.communicate()
        if not err:
            if csvtime >= mtime:
                p = subprocess.Popen(r'REG DELETE "' + pathReg + '"', stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                                     stderr=subprocess.PIPE, universal_newlines=True)
                p.communicate('Yes')
                p = subprocess.Popen(r'REG RESTORE "' + pathReg + '" ' + bkpath, stdout=subprocess.PIPE,
                                     stderr=subprocess.PIPE)
                p.communicate()
        else:
            with subprocess.Popen(r'REG ADD "' + pathReg + '"', stdout=subprocess.PIPE, stderr=subprocess.PIPE) as p:
                p.communicate()
            p = subprocess.Popen(r'REG RESTORE "' + pathReg + '" ' + bkpath, stdout=subprocess.PIPE,
                                 stderr=subprocess.PIPE)
            p.communicate()
        try:
            os.remove(bkpath)
        except:
            pass


class RegistryIOCs(AbstractIOCs):
    def __init__(self, value, operation):
        super().__init__('Registry', value, operation)

    """
    returns 3pule of (pre, in, post) code sections, if no code action is required, None will be returned in appropriate location
    """
    def get_code_create(self, operation: CreateOpertaion):
        ioc_val = self._ioc_value
        pre_code = None
        in_code = None
        post_code = inspect.getsourcelines(reg_create_post)[0]
        post_code = self.standartisize_code(post_code, ioc_val)
        return pre_code, in_code, post_code

    def get_code_delete(self, operation: DeleteOpertaion):
        ioc_val = self._ioc_value
        pre_code = inspect.getsourcelines(reg_delete_pre)[0]
        pre_code = self.standartisize_code(pre_code, ioc_val)
        in_code = None
        post_code = inspect.getsourcelines(reg_delete_post)[0]
        post_code = self.standartisize_code(post_code, ioc_val)
        return pre_code, in_code, post_code

    def get_code_modify(self, operation: ModifyOpertaion):
        ioc_val = self._ioc_value
        pre_code = inspect.getsourcelines(reg_modify_pre)[0]
        pre_code = self.standartisize_code(pre_code, ioc_val)
        in_code = None
        post_code = inspect.getsourcelines(reg_modify_post)[0]
        post_code = self.standartisize_code(post_code, ioc_val)
        return pre_code, in_code, post_code
