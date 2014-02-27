import unittest
import sqlite3
import projectGo

class Test(unittest.TestCase):

    def test_one(self):
        result = projectGo.createTestValue1()
        self.assertEqual(1, result)

    def test_two(self):
        result = projectGo.createTestValuea()
        self.assertEqual('a', result)

if __name__ == '__main__':
    unittest.main()