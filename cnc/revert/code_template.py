import csv
import getpass
import glob
import logging
import os
import os.path
import socket
import stat
import subprocess
import sys
import time
import uuid
import winreg
from csv import reader
from datetime import datetime, timedelta
from pathlib import Path
from shutil import rmtree, copyfile, copytree


def temp():
    str(stat)
    str(subprocess)
    str(time)
    str(winreg)
    str(rmtree)
    str(copyfile)
    str(copytree)
    str(timedelta)
    str(getpass)
    str(uuid)

logger = logging.getLogger('MalLog')
logger.setLevel(logging.INFO)
handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.DEBUG)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)

csvLogFile = 'C:\\Users\\Public\\ReWare Agent\\logs\\%MALWARE%_%ACTION%.csv'
Path("C:\\Users\\Public\\ReWare Agent\\logs\\").mkdir(parents=True, exist_ok=True)
hostname = socket.gethostname()
IPAddr = socket.gethostbyname(hostname)


def logcsv(row):
    if not os.path.exists(csvLogFile):
        with open(csvLogFile, 'w') as csvfile:
            filewriter = csv.writer(csvfile, delimiter=',')
            test = csv.DictWriter(csvfile, fieldnames=['HostName', 'DateTime', 'IOCType', 'IOCPath', 'OperationType',
                                                       'OpResult', 'Info'])
            test.writeheader()
        csvfile.close()
    with open(csvLogFile, 'a') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(row)
    csvfile.close()


def gettime():
    k = datetime.now()
    return k


class CsvLine():
    def __init__(self, row):
        self.host = row[0]
        self.date_time = row[1]
        self.ioc_type = row[2]
        self.ioc_value = row[3].replace('/', '\\')
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


class CsvParser():
    def __init__(self, path):
        res = {}
        with open(path, 'r') as f:
            csvreader = reader(f)
            for row in csvreader:
                if not row:
                    continue
                cur_row = CsvLine(row)
                res[cur_row.get_ioc_value()] = cur_row
        logger.info(f'parsed {len(res.keys())} lines form csvlog')
        self.iocs = res

    def get_ioc_line_by_value(self, ioc_value):
        new_val = ioc_value.replace('/', '\\')
        if new_val in self.iocs.keys():
            return self.iocs[new_val]
        new_val = ioc_value.replace('\\\\', '\\')
        if new_val in self.iocs.keys():
            return self.iocs[new_val]
        logger.info(f"failed to ioc with val {str(new_val)}")
        return None

    def get_all_maching_ioc_lines_by_value(self, ioc_value):
        res = []
        new_val = ioc_value.replace('/', '\\')
        for i in self.iocs.keys():
            if new_val in i:
                res.append(self.iocs[i])
        new_val = ioc_value.replace('\\\\', '\\')
        for i in self.iocs.keys():
            if new_val in i:
                res.append(self.iocs[i])
        return res

    def get_keys(self):
        return [i.ioc_value for i in self.iocs]


if __name__ == '__main__':
    CSV_PATH = 'C:/csvlog'
    csv_fp = glob.glob(CSV_PATH + '/*.csv')
    try:
        csv_fp = csv_fp[0]
        parser = CsvParser(csv_fp)
    except:
        logger.info("No csv found")
    logger.info("started actions")
