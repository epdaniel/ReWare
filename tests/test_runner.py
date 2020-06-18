import unittest
from threading import Thread

from cnc import cnc_main

"""
 To run test, run this file.
 To add more tests, create a new file with the name "test_(something)", test_exp for an example.
 python -m unittest discover
"""

if __name__ == '__main__':

    loader = unittest.TestLoader()
    start_dir = 'tests'
    suite = loader.discover(start_dir)

    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(suite)
