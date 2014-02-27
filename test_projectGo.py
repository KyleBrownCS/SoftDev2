import unittest
import sqlite3
import projectGo
from flask import request, jsonify
from mock import patch
import json

class Test(unittest.TestCase):

	def setUp(self):
		self.app = projectGo.app.test_client()
			
	def test_dummy_data(self):
		result = projectGo.get_all_obligations()
		#self.assertEqual("(649, 649, u'Test649', u'Testing six four nine', u'noon', u'sixpm', 12, 1, 3),\r\n", result)

	def test_dummy_data2(self):
		result = projectGo.get_obligation(649)
		#self.assertEqual("(649, 649, u'Test649', u'Testing six four nine', u'noon', u'sixpm', 12, 1, 3)\r\n", result)

	def test_go_create_obligation(self):
		result = self.app.post('/obligations')
		jsonData = json.loads(result.data)
		resultMessage = jsonData['result']
		self.assertEqual("Flask returned this message", resultMessage)
		self.assertEqual(result.status, '200 OK')
        
	def test_go_get_obligation(self):
		print "hi"
	
	def test_go_get_all_obligations(self):
		result = self.app.get('/obligations')
		self.assertEquals(result.status, '200 OK')
	
if __name__ == '__main__':
    unittest.main()