from csv import reader

from cnc.iocs.csv_reader.csv_line import CsvLine


class CsvParser():
    class CsvLine():
        def __init__(self, row):
            self.host = row[0]
            self.date_time = row[1]
            self.ioc_type = row[2]
            self.ioc_value = row[3]
            self.operation = row[4]
            self.result = row[5]

        def get_host(self):
            return self.host

        def get_date_time(self):
            return self.date_time

        def get_ioc_type(self):
            return self.ioc_type

        def get_ioc_value(self):
            return self.ioc_value

        def get_operation(self):
            return self.operation

        def get_result(self):
            return self.result

    def __init__(self, path):
        res = {}
        with open(path, 'r') as f:
            csvreader = reader(f)
            for row in csvreader:
                if not row:
                    continue
                cur_row = CsvLine(row)
                res[cur_row.get_ioc_value()] = cur_row
        self.iocs = res

    def get_ioc_line_by_value(self, ioc_value):
        if ioc_value in self.iocs.keys():
            return self.iocs[ioc_value]
        return None

    def get_keys(self):
        return self.iocs.keys()
