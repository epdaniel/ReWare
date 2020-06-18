from cnc.iocs.abstract_ioc import AbstractIOCs
from cnc.iocs.operation.abstact_operation import AbstractOperation


class DeleteOpertaion(AbstractOperation):
    def accept(self, visitor: AbstractIOCs):
        return visitor.get_code_delete(self)

    def __str__(self):
        return 'Delete'

    def __repr__(self):
        return str(self)
