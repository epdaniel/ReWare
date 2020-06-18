import unittest

from cnc.exceptions.bad_ioc_type_exception import BadIOCTypeException
from cnc.ioc_parser import IocParser


class TestParseIocs(unittest.TestCase):
    def test_simple(self):
        csv= 'single_file_ioc.csv'
        ip = IocParser(csv)
        res = ip.get_parsed_results()
        self.assertEqual(len(res),1)
    def test_sad(self):
        csv = 'bad_type_ioc.csv'
        try:
            ip = IocParser(csv)
            res = ip.get_parsed_results()
            self.assertTrue(False)
        except BadIOCTypeException as e:
            self.assertTrue(True)
    def test_dyre(self):
        csv='DyreCSV.csv'
        ip = IocParser(csv)
        res = ip.get_parsed_results()
        self.assertEqual(len(res),13)
    def test_file_observable(self):
        pass
    def test_bad(self):
        pass