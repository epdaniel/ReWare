from cnc.iocs.operation.create_operation import CreateOpertaion
from cnc.iocs.operation.delete_operation import DeleteOpertaion
from cnc.iocs.operation.modify_operation import ModifyOpertaion


class LateralMovment():
    def __init__(self, value, operation):
        super().__init__('Lateral Movement', value, operation)

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
