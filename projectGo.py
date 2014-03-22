from flask import Flask, render_template, request, jsonify
import sqlite3
import json
import re
import logging

from applicationInfo import ApplicationInfo

logging.basicConfig(filename='/var/www/SoftDev2/projectGo.log', level=logging.DEBUG)

app = Flask(__name__)
applicationInfo = ApplicationInfo()

row_pos_obligationid = 0
row_pos_userid = 1
row_pos_name = 2
row_pos_description = 3
row_pos_starttime = 4
row_pos_endtime = 5
row_pos_priority = 6
row_pos_status = 7
row_pos_category = 8


def get_db():
    db_connection = sqlite3.connect(applicationInfo.database_filepath)
    db_cursor = db_connection.cursor()
    return db_connection, db_cursor

@app.route('/')
def index():
    return render_template("index.html")

@app.route('/addobligation')
def add_obligation_page():
    return render_template("addobligation.html")

@app.route('/obligations', methods = ['GET'])
def get_all_obligations():
    db_connection, db_cursor = get_db() 
    response = ""

    data = []
    for row in db_cursor.execute("select * from " + applicationInfo.OBLIGATION_TABLE_NAME):
        obligation_entry = {
        'obligationid' : row[row_pos_obligationid], #obligationid
            'userid'       : row[row_pos_userid], #userid
            'name'         : row[row_pos_name], #name
            'description'  : row[row_pos_description], #description
            'starttime'    : row[row_pos_starttime], #starttime
            'endtime'      : row[row_pos_endtime], #endtime
            'priority'     : row[row_pos_priority], #priority
            'status'       : row[row_pos_status], #status
            'category'     : row[row_pos_category]} #category
        
        data.append(obligation_entry)
    response = json.dumps(data)
    return response

@app.route('/schedule')
def sched():
    return render_template("Schedule.html")

@app.route('/obligationlist')
def obligationlist():
    return render_template("ObligationList.html")

@app.route('/obligations/<startTime>', methods = ['GET'])
def get_obligations_by_date(startTime):
    db_connection, db_cursor = get_db() 
    response = ""
    response_code = None
    data = []
    count = 0;
    for row in db_cursor.execute("select * from " + applicationInfo.OBLIGATION_TABLE_NAME):
        start_time = row[row_pos_starttime]
        time_split = start_time.split(" ", 1)
        start_time = time_split[0]
        start_time.replace("'", "")
        if start_time == startTime:
            obligation_entry = {'obligationid' : row[row_pos_obligationid], #obligationid
                'userid'       : row[row_pos_userid], #userid
                'name'         : row[row_pos_name], #name
                'description'  : row[row_pos_description], #description
                'starttime'    : row[row_pos_starttime], #starttime
                'endtime'      : row[row_pos_endtime], #endtime
                'priority'     : row[row_pos_priority], #priority
                'status'       : row[row_pos_status], #status
                'category'     : row[row_pos_category]} #category
            data.append(obligation_entry)
            response = json.dumps(data)
            count = count + 1
    if 0 == count:
        response_code = 404
    else:
        response_code = 200

    return response, response_code

@app.route('/obligations/<int:obligation_id>', methods = ['GET'])
def get_obligation(obligation_id):
    logging.debug('Attempting to GET obligation ' + str(obligation_id))

    row = "";

    #execute query and get all rows that match (since obligation_id is unique there will be 0 or 1
    db_connection, db_cursor = get_db()
    my_query = "select * from " + applicationInfo.OBLIGATION_TABLE_NAME + " where " + applicationInfo.OBLIGATION_ID_NAME + " = " + str(obligation_id)
    row = db_cursor.execute(my_query).fetchall()

    if (len(row) > 0):
        row = row[0]
        data = {
            'obligationid' : row[row_pos_obligationid], #obligationid
            'userid'       : row[row_pos_userid], #userid
            'name'         : row[row_pos_name], #name
            'description'  : row[row_pos_description], #description
            'starttime'    : row[row_pos_starttime], #starttime
            'endtime'      : row[row_pos_endtime], #endtime
            'priority'     : row[row_pos_priority], #priority
            'status'       : row[row_pos_status], #status
            'category'     : row[row_pos_category]} #category
        data = json.dumps(data)
        logging.debug('Obligation ' + str(obligation_id) + ' was found')
    else:
        logging.debug('Obligation ' + str(obligation_id) + ' could not be found')
        data = jsonify({'error': 1})
    
    return data

@app.route('/obligations', methods = ['POST'])
def create_obligation():
    logging.debug('Attempting to create a new Obligation')

    db_connection, db_cursor = get_db()
    response = ""
    user_id = request.form['userid']
    name = request.form['name']
    description = request.form['description']
    start_time = request.form['starttime']
    end_time = request.form['endtime']
    priority = request.form['priority']
    status = request.form['status']
    category = request.form['category']

    try:
        db_cursor.execute("insert into " + applicationInfo.OBLIGATION_TABLE_NAME + " (obligationid, userid, name, description, starttime, endtime, priority, status, category) values (?, ?, ?, ?, ?, ?, ?, ?, ?)", (None, user_id, name, description, start_time, end_time, priority, status, category))
        result = db_cursor.execute("select last_insert_rowid() FROM " + applicationInfo.OBLIGATION_TABLE_NAME).fetchall()
        if (len(result) > 0):
            result = result[0]
        obligation_id = result[0]
        db_connection.commit() 
        response = jsonify({'obligation_id': obligation_id, 'result': "successfully added:" + name})
        
        logging.debug('Creation of obligation ' + str(obligation_id) + ' was a success')
    except Exception, e:
        logging.error('Obligation could not be created. Error message: ' + str(e))

        response = jsonify({'error': str(e)})

    return response



@app.route('/obligations/<int:obligation_id>', methods = ['POST'])
def modify_obligation(obligation_id):
    logging.debug('attempting to edit obligation: ' + str(obligation_id))
    logging.debug('incoming update data: ' + str(request.form))
    db_connection, db_cursor = get_db()
    response = ""
    response_code = None
    try:
        my_query = "select * from " + applicationInfo.OBLIGATION_TABLE_NAME + " where " + applicationInfo.OBLIGATION_ID_NAME + "=" + str(obligation_id)
        row = db_cursor.execute(my_query).fetchall()

        if (len(row) > 0):
            row = row[0]
            keys = request.form.keys()

            if 'userid' in keys:
                user_id = request.form['userid']
            else:
                user_id = row[row_pos_userid]
            if 'name' in keys:
                name = request.form['name']
            else:
                name = row[row_pos_name]
            if 'description' in keys:
                description = request.form['description']
            else:
                description = row[row_pos_description]
            if 'starttime' in keys:
                start_time = request.form['starttime']
            else:
                start_time = row[row_pos_starttime]
            if 'endtime' in keys:
                end_time = request.form['endtime']
            else:
                end_time = row[row_pos_endtime]
            if 'priority' in keys:
                priority = request.form['priority']
            else:
                priority = row[row_pos_priority]
            if 'status' in keys:
                status = request.form['status']
            else:
                status = row[row_pos_status]
            if 'category' in keys:
                category = request.form['category']
            else:
                category = row[row_pos_category]

            db_cursor.execute("update " + applicationInfo.OBLIGATION_TABLE_NAME + " set userid=?, name=?, description=?, starttime=?, endtime=?, priority=?, status=?, category=? where obligationid = ?", (user_id, name, description, start_time, end_time, priority, status, category, obligation_id))

            db_connection.commit()
            response_code = 200
            logging.debug('Obligation was updated and commited to the db')
        else:
            logging.debug('Obligation ' + str(obligation_id) + '  could not be found or does not exist')
            response = jsonify({'error': '404 - No such obligation id'})
            response_code = 404
    except Exception, e:
        response = jsonify({'error': str(e)})
        response_code = 500
        logging.error('An error occured while trying to update obligation ' + str(obligation_id) + '. error message: ' + str(e))
    
    return response, response_code

@app.route('/obligations/<int:obligation_id>', methods = ['DELETE'])
def delete_obligation(obligation_id):
    logging.debug('Attempting to DELETE obligation ' + str(obligation_id))

    db_connection, db_cursor = get_db()
    response = ""
    response_code = None

    try:
        if (isinstance(obligation_id,(int,long))):
            my_query = "select * from " + applicationInfo.OBLIGATION_TABLE_NAME + " where " + applicationInfo.OBLIGATION_ID_NAME + "=" + str(obligation_id)
            row = db_cursor.execute(my_query).fetchall()
            if (len(row) > 0):
                db_cursor.execute("delete from " + applicationInfo.OBLIGATION_TABLE_NAME + " where " + applicationInfo.OBLIGATION_ID_NAME + "=" + str(obligation_id))
                db_connection.commit()
                response = jsonify({'success': 'OK successfully deleted'})
                response_code = 200
            else:
                response = jsonify({'error': 'No such obligation id'})
                response_code = 404
        else:
            response = jsonify({'error': 'Bad Request - Info not properly provided'})
            response_code = 400
    except Exception, e:
        logging.error('Could not delete obligation ' + str(obligation_id) + '. Error message: ' + str(e))

        response = jsonify({'error': str(e)})
        response_code = 500

    return response, response_code

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=int('5000'))
