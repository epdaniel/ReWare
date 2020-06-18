from cnc.iocs.abstract_ioc import AbstractIOCs
from cnc.iocs.operation.abstact_operation import AbstractOperation


class CreateOpertaion(AbstractOperation):
    def accept(self, visitor: AbstractIOCs):
        return visitor.get_code_create(self)

    def __str__(self):
        return 'Create'

    def __repr__(self):
        return str(self)
