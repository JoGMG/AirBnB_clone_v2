#!/usr/bin/python3
""" Module for testing file storage"""
import os
import unittest
from datetime import datetime

from models import storage
from models.user import User


@unittest.skipIf(
    os.getenv('HBNB_TYPE_STORAGE') != 'db', 'DBStorage test')
class TestDBStorage(unittest.TestCase):
    """ Class to test the database storage method """
    def test_new(self):
        """ New object is correctly added to database """

    def test_delete(self):
        """ Object is correctly deleted from database """

    def test_reload(self):
        """ Tests the reloading of the database session """

    def test_save(self):
        """ object is successfully saved to database """

    def test_storage_var_created(self):
        """ DBStorage object storage created """

    def test_new_and_save(self):
        '''testing  the new and save methods'''
