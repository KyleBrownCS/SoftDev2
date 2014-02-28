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
	#def test_go_create_obligation(self):
		#result = self.app.post('/obligations')
		#jsonData = json.loads(result.data)
		#resultMessage = jsonData['result']
		#self.assertEqual("Flask returned this message", resultMessage)
		#self.assertEqual(result.status, '200 OK')
        
	#test of direct method for get_obligation
	def test_go_get_obligation_exists(self):
		#test case 1
		jsonData = json.loads(self.app.get('/obligations/1').data)
		self.assertEqual(jsonData['obligationid'],1)
		#test case 2
		jsonData = json.loads(self.app.get('/obligations/2').data)
                self.assertEqual(jsonData['obligationid'],2)
		#Checking other fields
		jsonData = json.loads(self.app.get('/obligations/1').data)
		self.assertEqual(jsonData['userid'],1)
		self.assertEqual(jsonData['name'],"Dude name")
		self.assertEqual(jsonData['starttime'],"2014-01-01 00:00:00.000")
		self.assertEqual(jsonData['priority'],1)

	#test of direct method for get_obligation with entry that doesn't exist
	def test_go_get_obligation_not_exists(self):
		#Extreme case
		jsonData = json.loads(self.app.get('/obligations/9999999').data)
		self.assertEqual(jsonData['error'],1)
		#Boundry case low
		jsonData = json.loads(self.app.get('/obligations/0').data)
		self.assertEqual(jsonData['error'],1)
		
	#def test_go_get_obligation_bad_key(self):
		#Invalid case string
		result = self.app.get("/obligations/this is supposed to be an int")
		self.assertEqual(result.status, '404 NOT FOUND')
		#Invalid case float
		result = self.app.get("/obligations/1.0")
                self.assertEqual(result.status, '404 NOT FOUND')	
		#Invalid case char
		result = self.app.get("/obligations/a")
                self.assertEqual(result.status, '404 NOT FOUND')

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
