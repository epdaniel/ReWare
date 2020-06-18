from abc import ABC, abstractmethod

from cnc.iocs.abstract_ioc import AbstractIOCs


class AbstractOperation(ABC):
    @abstractmethod
    def accept(self, visitor: AbstractIOCs) -> str:
        return visitor.get_code_create()
