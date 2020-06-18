from abc import abstractmethod


# from iocs.operation.create_operation import CreateOpertaion


class AbstractIOCs:
    """
    parse ioc form row of csv file
    """
    def __init__(self, type, value, operation):
        self._ioc_type = type
        self._ioc_value = value
        self._operation = operation

    @abstractmethod
    def get_code_create(self, Operation):
        pass

    @abstractmethod
    def get_code_delete(self, Operation):
        pass

    @abstractmethod
    def get_code_modify(self, Operation):
        pass

    def get_op(self):
        return self._operation

    """
    Override equality
    """

    def __eq__(self, obj):
        return self._ioc_type == obj._ioc_type and self._ioc_value == obj._ioc_value

    def __str__(self):
        return f'{self._ioc_type}:{self._ioc_value}'

    def __repr__(self):
        return self.__str__()

    def _remove_single_indent(self, line):
        return line[4:]

    def standartisize_code(self, lines, ioc_value):
        lines_without_sig = lines[1:]
        res = ""
        for line in lines_without_sig:
            # detented = textwrap.dedent(line)
            nl = line.replace('{ioc_val}', ioc_value)
            res += self._remove_single_indent(nl)
        return res
