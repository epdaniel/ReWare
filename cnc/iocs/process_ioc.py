import inspect

from cnc.iocs.abstract_ioc import AbstractIOCs
from cnc.iocs.operation.create_operation import CreateOpertaion
from cnc.iocs.operation.delete_operation import DeleteOpertaion
from cnc.iocs.operation.modify_operation import ModifyOpertaion


def process_create_post(self):
    name = '{ioc_val}'
    for proc in psutil.process_iter():
        if name + ".exe" == proc.name() or name == proc.name():
            proc.kill()


class ProcessIOCs(AbstractIOCs):
    def __init__(self, value, operation):
        super().__init__('process', value, operation)

    """
    returns 3pule of (pre, in, post) code sections, if no code action is required, None will be returned in appropriate location
    """
    def get_code_create(self, operation: CreateOpertaion):
        ioc_val = self._ioc_value
        pre_code = None
        in_code = None
        post_code = inspect.getsourcelines(process_create_post)[0]
        post_code = self.standartisize_code(post_code, ioc_val)
        return pre_code, in_code, post_code

    def get_code_delete(self, operation: DeleteOpertaion):
        pre_code = None
        in_code = None
        post_code = None
        return pre_code, in_code, post_code

    def get_code_modify(self, operation: ModifyOpertaion):
        pre_code = None
        in_code = None
        post_code = None
        return pre_code, in_code, post_code
