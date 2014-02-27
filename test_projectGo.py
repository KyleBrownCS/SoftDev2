import unittest
import sqlite3
import projectGo

class Test(unittest.TestCase):

    def test_dummy_data(self):
        result = projectGo.get_all_obligations()
        self.assertEqual("(649, 649, u'Test649', u'Testing six four nine', u'noon', u'sixpm', 12, 1, 3),\r\n", result)

    def test_dummy_data2(self):
        result = projectGo.get_obligation(649)
        self.assertEqual("(649, 649, u'Test649', u'Testing six four nine', u'noon', u'sixpm', 12, 1, 3)\r\n", result)

if __name__ == '__main__':
    unittest.main()