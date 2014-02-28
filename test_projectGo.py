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
		#Edge case low
		jsonData = json.loads(projectGo.get_obligation(1))
		self.assertEqual(jsonData['obligationid'],1)
		#Edge case high
		jsonData = json.loads(projectGo.get_obligation(5))
		self.assertEqual(jsonData['obligationid'],5)
		#Typical case
		jsonData = json.loads(projectGo.get_obligation(3))
		self.assertEqual(jsonData['obligationid'],3)
		#Checking other fields
		jsonData = json.loads(projectGo.get_obligation(1))
		self.assertEqual(jsonData['userid'],1)
		jsonData = json.loads(projectGo.get_obligation(1))
		self.assertEqual(jsonData['name'],"Dude name")
		jsonData = json.loads(projectGo.get_obligation(1))
		self.assertEqual(jsonData['starttime'],"2014-01-01 00:00:00.000")
		jsonData = json.loads(projectGo.get_obligation(1))
		self.assertEqual(jsonData['priority'],1)

	#test of direct method for get_obligation with entry that doesn't exist
	def test_go_get_obligation_not_exists(self):
		#Extreme case
		jsonData = json.loads(projectGo.get_obligation(9999999))
		self.assertEqual(jsonData['error'],1)
		#Boundry case low
		jsonData = json.loads(projectGo.get_obligation(0))
		self.assertEqual(jsonData['error'],1)
		#Boundry case high
		jsonData = json.loads(projectGo.get_obligation(6))
		self.assertEqual(jsonData['error'],1)
		
	def test_go_get_obligation_bad_key(self):
		#Invalid case string
		jsonData = json.loads(projectGo.get_obligation("this is supposed to be an int"))
		self.assertEqual(jsonData['error'],1)
		#Invalid case float
		jsonData = json.loads(projectGo.get_obligation(1.0))
		self.assertEqual(jsonData['error'],1)
		#Invalid case char
		jsonData = json.loads(projectGo.get_obligation('a'))
		self.assertEqual(jsonData['error'],1)

	#test of GET method for get_obligation
	def test_get_obligation(self):
		#Edge case low
		result = self.app.get('/obligations/1')
		self.assertEquals(result.status, '200 OK')
		#Edge case high
		result = self.app.get('/obligations/5')
		self.assertEquals(result.status, '200 OK')
		#Typical case
		result = self.app.get('/obligations/3')
		self.assertEquals(result.status, '200 OK')

	
	#test of GET method for get_all_obligations
	def test_get_all_obligations(self):
		result = self.app.get('/obligations')
		self.assertEquals(result.status, '200 OK')
	
if __name__ == '__main__':
    unittest.main()