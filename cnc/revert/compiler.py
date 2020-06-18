import os
from zipfile import ZipFile

from cnc.exceptions.failed_to_compile_exception import FailedToCompileException


class Compiler():
    def __init__(self, iocs, mal_id):
        self._iocs = iocs
        self._mal_id = mal_id

    def compile_to_exe(self, folder_path, file_name):
        file_re = file_name.split('\\')[-1].split('.')[0] + '.exe'
        compiled_path = f'{folder_path}assets\\{file_re}'
        query = f"pyinstaller -F {file_name} --distpath {folder_path}assets"
        res = os.system(query)
        if res != 0:
            raise FailedToCompileException(f'Failed compiling in folder {folder_path}, and file name {file_name}')
        return compiled_path

    def merge_to_zip(self, pre_path, in_path, post_path, malware_path, conf_path, output):
        os.chdir(output + '\\assets')
        with ZipFile(output + 'assets.zip', 'w') as myzip:
            myzip.write('conf.txt')
            myzip.write('pre.exe')
            myzip.write('post.exe')
            myzip.write('in.exe')
            myzip.write('malware.exe')

    def encapsulate_line(self, line, ioc, op):
        p_line = line.replace("\n", "\n\t")
        # p_line = p_line.replace('\\\\', '\\')
        s = f'try:\n' \
            f'\t{p_line}\n' \
            f'\trow=[str(IPAddr),gettime(),"{ioc._ioc_type}", r"{ioc._ioc_value}", "{ioc._operation}","Success"]\n' \
            f'\tlogcsv(row)\n' \
            f'except Exception as e:\n' \
            f'\trow=[str(IPAddr),gettime(),"{ioc._ioc_type}", r"{ioc._ioc_value}", "{ioc._operation}","Failed", str(e)]\n' \
            f'\tlogcsv(row)\n' \
            f''
        return s

    def get_code_as_string(self):
        __location__ = os.path.realpath(
            os.path.join(os.getcwd(), os.path.dirname(__file__)))
        with open(os.path.join(__location__, 'code_template.py'), 'r') as f:
            csv_handler_tex = f.readlines()
        # csv_handler_tex = inspect.getsourcelines(csv_handler_template)[0]
        csv_handler_tex = ''.join(csv_handler_tex)
        pre_code = csv_handler_tex.replace('%MALWARE%', str(self._mal_id))
        pre_code = pre_code.replace('%ACTION%', 'pre')
        in_code = csv_handler_tex.replace('%MALWARE%', str(self._mal_id))
        in_code = in_code.replace('%ACTION%', 'IN')
        post_code = csv_handler_tex.replace('%MALWARE%', str(self._mal_id))
        post_code = post_code.replace('%ACTION%', 'POST')

        for ioc in self._iocs:
            op = ioc.get_op()
            res = op.accept(ioc)
            c_pre, c_in, c_post = res
            if c_pre is not None:
                pre_code += self.encapsulate_line(c_pre, ioc, op) + '\n'
            if c_in is not None:
                in_code += self.encapsulate_line(c_in, ioc, op) + '\n'
            if c_post is not None:
                post_code += self.encapsulate_line(c_post, ioc, op) + '\n'
        post_code += 'import os.path' + '\n'
        post_code += 'try:' + '\n'
        post_code += ' \tos.remove(os.getenv(\'APPDATA\') + r"\\TempBackUpDB.txt")' + '\n'
        post_code += 'except:' + '\n'
        post_code += '\tpass' + '\n'
        return (pre_code, in_code, post_code)
