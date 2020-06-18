from cnc.iocs.abstract_ioc import AbstractIOCs
from cnc.iocs.operation.create_operation import CreateOpertaion
from cnc.iocs.operation.delete_operation import DeleteOpertaion
from cnc.iocs.operation.modify_operation import ModifyOpertaion


class NetIOCs(AbstractIOCs):
    def __init__(self, value, operation):
        super().__init__('process', value, operation)

    """
    returns 3pule of (pre, in, post) code sections, if no code action is required, None will be returned in appropriate location
    """
    def get_code_create(self, operation: CreateOpertaion):
        pre_code = None
        in_code = None
        post_code = None
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
