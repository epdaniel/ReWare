from iocs.constants import COMPLETED
from iocs.csv_reader.csv_parser import CsvParser


class Commons():
    def __init__(self, exp_id):
        self.exp_id = exp_id
        csv_path = f'c:\\csvlog\\{exp_id}.csv'
        self.csv = CsvParser(csv_path)

    def did_succeed(self, ioc_value):
        ioc_line = self.csv.get_ioc_line_by_value(ioc_value)
        return ioc_line.get_result() == COMPLETED
