import getpass
import os
import winreg
from os import path

from IPy import xrange


def does_file_or_folder_exist(p):
    if '%USERNAME%' in p:
        p = p.split('%USERNAME%')[0] + getpass.getuser() + p.split('%USERNAME%')[1]
    if 'system32' in p:
        try:
            os.stat(p.split('system32')[0] + 'SYSNATIVE' + p.split('system32')[1])
            p = p.split('system32')[0] + 'SYSNATIVE' + p.split('system32')[1]
        except Exception as e:
            try:
                os.stat(p.split('system32')[0] + 'Syswow64' + p.split('system32')[1])
                p = p.split('system32')[0] + 'Syswow64' + p.split('system32')[1]
            except:
                pass
    return path.exists(p)


def does_registry_exist(path):
    try:
        split = path.split('\\', 1)
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
        items = set()
        for i in xrange(0, winreg.QueryInfoKey(key)[1]):
            items.add(winreg.EnumValue(key, i)[0])
        return value in items
    except:
        return False


if __name__ == '__main__':
    print(does_file_or_folder_exist('c:\\users\\%USERNAME%\\appdata\\local\\IconCache.db'))
