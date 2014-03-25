import unittest
import sqlite3
import projectGo
from flask import request, jsonify
import json
import tempfile
import shutil

class Test(unittest.TestCase):

    #simple set up for self.app to mean something...
    def setUp(self):
        self.app = projectGo.app.test_client()

        #setup the test DB file
        self.temp_folder_path = tempfile.mkdtemp()
        self.temp_db_filepath = self.temp_folder_path + 'unit_test_db.db'
        test_db_file = open(self.temp_db_filepath, 'a')
        test_db_file.close()
        self.db_connection = sqlite3.connect(self.temp_db_filepath)
        self.db_cursor = self.db_connection.cursor()

        #create the test DB tables
        self.db_cursor.execute('create table users(userid integer primary key not null, userName varchar(15))')
        self.db_cursor.execute('create table userinfo(userid int primary key not null, name varchar(50), address varchar(50), birthday text, foreign key(userid) references users(userid))')
        self.db_cursor.execute('create table obligation(obligationid integer primary key not null, userid int not null, name varchar(30), description varchar(200), starttime text, endtime text, priority int, status int, category int, foreign key(userid) references users(userid))')

        #populate the test DB tables
        self.db_cursor.execute("insert into users values(1, 'UserName')")
        self.db_cursor.execute("insert into users values(2, 'UserName2')")
        self.db_cursor.execute("insert into users values(3, 'UserName3')")
        self.db_cursor.execute("insert into obligation values(1, 1, 'Dude name', 'This is a long description', '2014-01-01 00:00:00.000', '2014-01-01 01:00:00.000', 1, 1, 1)")
        self.db_cursor.execute("insert into obligation values(2, 2, 'Dude name2', 'This is another long description', '2014-01-01 00:00:00.000', '2014-01-01 01:00:00.000', 1, 1, 1)")
        self.db_cursor.execute("insert into obligation values(3, 1, 'Dude name', 'shorter description', '2014-01-01 00:00:00.000', '2014-01-01 01:00:00.000', 1, 1, 1)")
        self.db_cursor.execute("insert into obligation values(4, 3, 'Test', 'Longggggggggggggggggggggggggg description', '2014-01-01 00:00:00.000', '2014-01-01 01:00:00.000', 1, 2, 3)")
        self.db_cursor.execute("insert into obligation values(5, 4, 'Test2', '', '2014-01-05 00:00:00.000', '2014-01-10 01:00:00.000', 1, 4, 9)")
        self.db_cursor.execute("insert into obligation values(6, 4, 'Obg1', '', '2014-03-04 00:00:00.000', '2014-01-10 01:00:00.000', 1, 2, 9)")
        self.db_cursor.execute("insert into obligation values(7, 4, 'Obg2', '', '2014-03-05 00:00:00.000', '2014-01-10 01:00:00.000', 1, 4, 9)")
        self.db_connection.commit()

        #re-route projectGo to use the test DB
        projectGo.applicationInfo.database_filepath = self.temp_db_filepath
        projectGo.applicationInfo.OBLIGATION_TABLE_NAME = 'obligation'
        projectGo.applicationInfo.OBLIGATION_ID_NAME = 'obligationid' 


    def tearDown(self):
        #remove the test DB
        shutil.rmtree(self.temp_folder_path)

    #test of POST method without sending data for create_obligation
    def test_create_obligation_no_data(self):
        result = self.app.post('/obligations')
        self.assertEqual(result.status_code, 400)

    #test of POST method creating an obligation with working data
    def test_create_obligation_working_data(self):
        data_to_send = {
            'userid': 1,
            'name': 'flask-test',
            'description': 'flask-test-description',
            'starttime': '2014-03-05 00:00:00.000',
            'endtime': '2014-03-05 00:00:00.000',
            'priority': 1,
            'status': 1,
            'category': 1
        }

        result = self.app.post('/obligations', data=data_to_send)
        self.assertEqual(result.status_code, 200)
        jsonData = json.loads(result.data)
        self.assertTrue('obligation_id' in jsonData)

        test_id = jsonData['obligation_id']
        my_query = "select * from obligation where obligationid =" + str(test_id)
        row = self.db_cursor.execute(my_query).fetchall()

        self.assertTrue(len(row) > 0)
        if (len(row) > 0):
            row = row[0]
            self.assertEquals(row[2], 'flask-test')

    #test of direct method for get_obligation with entry that doesn't exist
    def test_go_get_obligation_not_exists(self):
        #Test case 1
        jsonData = json.loads(self.app.get('/obligations/9999999').data)
        self.assertEqual(jsonData['error'],1)
        #Test case 2
        jsonData = json.loads(self.app.get('/obligations/0').data)
        self.assertEqual(jsonData['error'],1)
		
    #test of GET method for get_obligation
    def test_get_obligation(self):
        #Test case 1
        result = self.app.get('/obligations/1')
        self.assertEquals(result.status, '200 OK')
        jsonData = json.loads(result.data)
        self.assertEqual(jsonData['obligationid'], 1)
        self.assertEqual(jsonData['userid'],1)
        self.assertEqual(jsonData['name'],"Dude name")
        self.assertEqual(jsonData['starttime'],"2014-01-01 00:00:00.000")
        self.assertEqual(jsonData['endtime'],"2014-01-01 01:00:00.000")
        self.assertEqual(jsonData['priority'],1)

        #Test case 2
        result = self.app.get('/obligations/2')
        self.assertEquals(result.status, '200 OK')
        jsonData = json.loads(result.data)
        self.assertEqual(jsonData['obligationid'], 2)
        self.assertEqual(jsonData['userid'], 2)
        self.assertEqual(jsonData['name'],"Dude name2")
        self.assertEqual(jsonData['starttime'],"2014-01-01 00:00:00.000")
        self.assertEqual(jsonData['endtime'],"2014-01-01 01:00:00.000")
        self.assertEqual(jsonData['priority'],1)

    #test of GET method for get_all_obligations
    def test_get_all_obligations(self):
        result = self.app.get('/obligations')
        self.assertEquals(result.status, '200 OK')
        jsonData = json.loads(result.data)
        self.assertTrue(len(jsonData) > 0)
        entry1 = jsonData[0]
        self.assertTrue('obligationid' in entry1)

    #Test of GET method for obligations on a given day
    def test_get_date_obligations(self):
        result = self.app.get('/obligations/2014-01-01')
        self.assertEquals(result.status, '200 OK')
        result = self.app.get('/obligations/2019-01-01')
        self.assertEquals(result.status, '404 NOT FOUND')

    #test of DELETE method for delete_obligation
    def test_delete_obligation(self):
        #typical delete case of existing obligation
        result = self.app.delete('/obligations/1')
        self.assertEquals(result.status, '200 OK')
        #delete case for non existing obligation
        result = self.app.delete('/obligations/1')
        self.assertEquals(result.status, '404 NOT FOUND')
        #delete case for invalid obligation
        result = self.app.delete('/obligations/abcdefg')
        self.assertEquals(result.status, '405 METHOD NOT ALLOWED')

	
if __name__ == '__main__':
    unittest.main()
