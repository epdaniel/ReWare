from cnc.iocs.abstract_ioc import AbstractIOCs
from cnc.iocs.operation.abstact_operation import AbstractOperation


class ModifyOpertaion(AbstractOperation):
    def accept(self, visitor: AbstractIOCs):
        return visitor.get_code_modify(self)

    def __str__(self):
        return 'Modify'

    def __repr__(self):
        return str(self)
