import inspect

from cnc.iocs.abstract_ioc import AbstractIOCs
from cnc.iocs.operation.create_operation import CreateOpertaion
from cnc.iocs.operation.delete_operation import DeleteOpertaion
from cnc.iocs.operation.modify_operation import ModifyOpertaion
from cnc.revert.code_template import *


def file_create_post(self):
    path = r'{ioc_val}'.replace('\\', os.sep)
    orig_path = path
    if '%USERNAME%' in path:
        path = path.split('%USERNAME%')[0] + getpass.getuser() + path.split('%USERNAME%')[1]
    if 'system32' in path:
        try:
            os.stat(path.split('system32')[0] + 'SYSNATIVE' + path.split('system32')[1])
            path = path.split('system32')[0] + 'SYSNATIVE' + path.split('system32')[1]
        except Exception as e:
            try:
                os.stat(path.split('system32')[0] + 'Syswow64' + path.split('system32')[1])
                path = path.split('system32')[0] + 'Syswow64' + path.split('system32')[1]
            except:
                pass
    else:
        stats = os.stat(path)
    timestr = time.ctime(stats[stat.ST_MTIME])
    mtime = datetime.strptime(timestr, '%a %b  %d %H:%M:%S %Y')

    line = parser.get_ioc_line_by_value(orig_path)
    csvtime = datetime.strptime(line.get_date_time(), '%Y-%m-%d %H:%M:%S.%f')

    updated = False
    iocs = parser.get_all_maching_ioc_lines_by_value(orig_path)
    for i in iocs:
        if i.get_operation() == 'Updated':
            updated = True
            break

    if csvtime >= mtime or updated:
        try:
            os.remove(path)
            # logger.info(f'Deleted file {path} after Malware creation')
        except OSError:
            rmtree(path)
            # logger.info(f'Deleted folder {path} after Malware creation')


def file_delete_pre(self):
    path = r'{ioc_val}'.replace('\\', os.sep)
    if '%USERNAME%' in path:
        path = path.split('%USERNAME%')[0] + getpass.getuser() + path.split('%USERNAME%')[1]
    if 'system32' in path:
        try:
            os.stat(path.split('system32')[0] + 'SYSNATIVE' + path.split('system32')[1])
            path = path.split('system32')[0] + 'SYSNATIVE' + path.split('system32')[1]
        except Exception as e:
            try:
                os.stat(path.split('system32')[0] + 'Syswow64' + path.split('system32')[1])
                path = path.split('system32')[0] + 'Syswow64' + path.split('system32')[1]
            except:
                pass
    id = str(uuid.uuid4())
    db = os.getenv('APPDATA') + "\\TempBackUpDB.txt"
    bkpath = os.getenv('APPDATA') + "\\backupTemp" + id
    if os.path.exists(path):
        try:
            copyfile(path, bkpath)
            f = open(db, "a+")
            f.write(path + " " + id + "\n")
            f.close()
            # logger.info(f'Backup {path} before Malware deletion')
        except OSError:
            copytree(path, bkpath)
            f = open(db, "a+")
            f.write(path + " " + id + "\n")
            f.close()
            # logger.info(f'Backup {path} before Malware deletion')


def file_delete_post(self):
    path = r'{ioc_val}'.replace('\\', os.sep)
    if '%USERNAME%' in path:
        path = path.split('%USERNAME%')[0] + getpass.getuser() + path.split('%USERNAME%')[1]
    db = os.getenv('APPDATA') + "\\TempBackUpDB.txt"
    f = open(db, "r")
    content = f.readlines()
    for line in content:
        if line.split(' ')[0] == path:
            bkpath = os.getenv('APPDATA') + "\\backupTemp" + line.split(' ')[1].rstrip()
        if line.split(' ')[0] == path.split('system32')[0] + 'SYSNATIVE' + path.split('system32')[1]:
            bkpath = os.getenv('APPDATA') + "\\backupTemp" + line.split(' ')[1].rstrip()
            path = path.split('system32')[0] + 'SYSNATIVE' + path.split('system32')[1]
    f.close()

    if os.path.exists(bkpath):
        if not os.path.exists(path):
            try:
                copyfile(bkpath, path)
            except OSError:
                copytree(bkpath, path)
            # logger.info(f'Restore {path} after Malware deletion')
        try:
            os.remove(bkpath)
        except OSError:
            rmtree(bkpath)


def file_modify_pre(self):
    path = r'{ioc_val}'.replace('\\', os.sep)
    if '%USERNAME%' in path:
        path = path.split('%USERNAME%')[0] + getpass.getuser() + path.split('%USERNAME%')[1]
    if 'system32' in path:
        try:
            os.stat(path.split('system32')[0] + 'SYSNATIVE' + path.split('system32')[1])
            path = path.split('system32')[0] + 'SYSNATIVE' + path.split('system32')[1]
        except Exception as e:
            try:
                os.stat(path.split('system32')[0] + 'Syswow64' + path.split('system32')[1])
                path = path.split('system32')[0] + 'Syswow64' + path.split('system32')[1]
            except:
                pass
    id = str(uuid.uuid4())
    db = os.getenv('APPDATA') + "\\TempBackUpDB.txt"
    bkpath = os.getenv('APPDATA') + "\\backupTemp" + id
    if os.path.exists(path):
        try:
            copyfile(path, bkpath)
            f = open(db, "a+")
            f.write(path + " " + id + "\n")
            f.close()
            # logger.info(f'Backup {path} before Malware modification')
        except OSError:
            copytree(path, bkpath)
            f = open(db, "a+")
            f.write(path + " " + id + "\n")
            f.close()
            # logger.info(f'Backup {path} before Malware modification')


def file_modify_post(self):
    path = r'{ioc_val}'.replace('\\', os.sep)
    orig_path = path
    if '%USERNAME%' in path:
        path = path.split('%USERNAME%')[0] + getpass.getuser() + path.split('%USERNAME%')[1]
    db = os.getenv('APPDATA') + "\\TempBackUpDB.txt"
    try:
        f = open(db, "r")
        content = f.readlines()
        for line in content:
            if line.split(' ')[0] == path:
                bkpath = os.getenv('APPDATA') + "\\backupTemp" + line.split(' ')[1].rstrip()
        f.close()

        if 'system32' in path:
            try:
                os.stat(path.split('system32')[0] + 'SYSNATIVE' + path.split('system32')[1])
                path = path.split('system32')[0] + 'SYSNATIVE' + path.split('system32')[1]
            except Exception as e:
                try:
                    os.stat(path.split('system32')[0] + 'Syswow64' + path.split('system32')[1])
                    path = path.split('system32')[0] + 'Syswow64' + path.split('system32')[1]
                except:
                    pass
        else:
            stats = os.stat(path)
        timestr = time.ctime(stats[stat.ST_MTIME])
        mtime = datetime.strptime(timestr, '%a %b  %d %H:%M:%S %Y')

        line = parser.get_ioc_line_by_value(orig_path)
        csvtime = datetime.strptime(line.get_date_time(), '%Y-%m-%d %H:%M:%S.%f')
        if os.path.exists(bkpath):
            if os.path.exists(path):
                if csvtime >= mtime:
                    try:
                        os.remove(path)
                    except OSError:
                        rmtree(path)
                    try:
                        copyfile(bkpath, path)
                    except OSError:
                        copytree(bkpath, path)
                    raise Exception(f'restore {path} after Malware modification')
            try:
                os.remove(bkpath)
            except OSError:
                rmtree(bkpath)
    except Exception as e:
        # logger.error(str(e))
        try:
            if os.path.exists(bkpath):
                try:
                    os.remove(bkpath)
                except OSError:
                    rmtree(bkpath)
        except Exception as e:
            pass


class FileIOCs(AbstractIOCs):
    def __init__(self, value, operation):
        super().__init__('File', value, operation)

    """
    returns 3pule of pre, in, post) code sections, if no code action is required, None will be returned in appropriate location
    """

    def get_code_create(self, operation: CreateOpertaion):
        ioc_val = self._ioc_value
        pre_code = None
        in_code = None
        post_code = inspect.getsourcelines(file_create_post)[0]
        post_code = self.standartisize_code(post_code, ioc_val)
        return pre_code, in_code, post_code

    def get_code_delete(self, operation: DeleteOpertaion):
        ioc_val = self._ioc_value
        pre_code = inspect.getsourcelines(file_delete_pre)[0]
        pre_code = self.standartisize_code(pre_code, ioc_val)
        in_code = None
        post_code = inspect.getsourcelines(file_delete_post)[0]
        post_code = self.standartisize_code(post_code, ioc_val)
        return pre_code, in_code, post_code

    def get_code_modify(self, operation: ModifyOpertaion):
        ioc_val = self._ioc_value
        pre_code = inspect.getsourcelines(file_modify_pre)[0]
        pre_code = self.standartisize_code(pre_code, ioc_val)
        in_code = None
        post_code = inspect.getsourcelines(file_modify_post)[0]
        post_code = self.standartisize_code(post_code, ioc_val)
        return pre_code, in_code, post_code
