import unittest
import sqlite3
import projectGo
from flask import request, jsonify
import json

class Test(unittest.TestCase):

	#simple set up for self.app to mean something...
	def setUp(self):
		self.app = projectGo.app.test_client()

	#test of POST method for create_obligation
	def test_go_create_obligation(self):
		result = self.app.post('/obligations')
		jsonData = json.loads(result.data)
		resultMessage = jsonData['result']
		self.assertEqual("Flask returned this message", resultMessage)
		self.assertEqual(result.status, '200 OK')
        
	#test of direct method for get_obligation
	def test_go_get_obligation_exists(self):
		result = projectGo.get_obligation(1)
		jsonData = json.loads(result)
		self.assertEqual(jsonData['obligationid'],1)

	#test of direct method for get_obligation with entry that doesn't exist
	def test_go_get_obligation_not_exists(self):
		result = projectGo.get_obligation(9999999)
		jsonData = json.loads(result)
		self.assertEqual(jsonData['error'],1)
		
	def test_go_get_obligation_bad_key(self):
		result = projectGo.get_obligation("this is supposed to be an int")
		jsonData = json.loads(result)
		self.assertEqual(jsonData['error'],1)

	#test of GET method for get_obligation
	def test_get_obligation(self):
		result = self.app.get('/obligations/1')
		self.assertEquals(result.status, '200 OK')
	
	#test of GET method for get_all_obligations
	def test_get_all_obligations(self):
		result = self.app.get('/obligations')
		self.assertEquals(result.status, '200 OK')
	
if __name__ == '__main__':
    unittest.main()