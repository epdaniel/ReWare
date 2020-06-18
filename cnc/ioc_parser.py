import csv

from cnc.exceptions.bad_ioc_type_exception import BadIOCTypeException
from cnc.iocs.file_ioc import FileIOCs
from cnc.iocs.lateral_movment_ioc import LateralMovment
from cnc.iocs.mutex_ioc import MutexIOCs
from cnc.iocs.net_ioc import NetIOCs
from cnc.iocs.operation.create_operation import CreateOpertaion
from cnc.iocs.operation.delete_operation import DeleteOpertaion
from cnc.iocs.operation.modify_operation import ModifyOpertaion
from cnc.iocs.process_ioc import ProcessIOCs
from cnc.iocs.registry_ioc import RegistryIOCs
from cnc.iocs.task_ioc import TaskIOCs

IOCS_DB = {'File': FileIOCs, 'Folder': FileIOCs, 'Process': ProcessIOCs, 'Registry': RegistryIOCs, 'network': NetIOCs,
           'DNS': NetIOCs, 'Port': NetIOCs, 'Lateral Movement': LateralMovment, 'Mutex': MutexIOCs, 'Task': TaskIOCs}
OPERATIONS_DB = {'Created': CreateOpertaion, 'Deleted': DeleteOpertaion, 'Modified': ModifyOpertaion,
                 'Updated': ModifyOpertaion}


class IocParser:
    """
    init parser with path to csv file
    """

    def _get_class_by_type(self, ioc_type):
        ioc = None
        if ioc_type not in IOCS_DB.keys():
            raise BadIOCTypeException(f"Bad type {ioc_type}")
        return IOCS_DB[ioc_type]

    def _get_operation(self, op):
        if op not in OPERATIONS_DB.keys():
            return None
        return OPERATIONS_DB[op]

    def __init__(self, path):
        self._iocs = []
        with open(path, 'r') as file:
            reader = csv.DictReader(file)
            for row in reader:
                # ['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType',
                #  'OpResult']
                host_name = row['HostName']
                date_time = row['DateTime']
                ioc_type = row['IOCType']
                ioc_path = row['IOCPath']
                operation_type = row['OperationType']
                result = row['OpResult']
                try:
                    if ioc_type == 'Lateral Movement':
                        continue
                    type_class = self._get_class_by_type(ioc_type)
                    op_class = self._get_operation(operation_type)
                except Exception as e:
                    raise e
                ioc = type_class(ioc_path, op_class())
                self._iocs.append(ioc)

    def get_parsed_results(self):
        return self._iocs
