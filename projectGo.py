from flask import Flask, render_template
import sqlite3

from applicationInfo import ApplicationInfo

app = Flask(__name__)
applicationInfo = ApplicationInfo()

def get_db():
    db_connection = sqlite3.connect(applicationInfo.database_filepath)
    db_cursor = db_connection.cursor()
    return db_cursor


@app.route('/')
def index():
    return render_template("index.html")

@app.route('/obligations', methods = ['GET'])
def get_all_obligations():
    db_cursor = get_db() 

    response = ""
    for row in db_cursor.execute("select * from " + ApplicationInfo.OBLIGATION_TABLE_NAME):
        response = response + str(row) + ",\r\n"

    #return ("<H1>Place Holder</H1>\r\n<H3>GET /obligations</H3>\r\n\r\n<p>This method will return all obligations for a user</p>")
    return response

@app.route('/schedule')
def sched():
    return render_template("Schedule.html")

@app.route('/obligations/<int:obligation_id>', methods = ['GET'])
def get_obligation(obligation_id):
    db_cursor = get_db()

    response = ""
    for row in db_cursor.execute("select * from " + ApplicationInfo.OBLIGATION_TABLE_NAME + " where " + ApplicationInfo.OBLIGATION_ID_NAME + " = " + str(obligation_id)):
        response = response + str(row) + "\r\n"

    #return ("<H1>Place Holder</H1>\r\n<H3>GET /obligations/:id</H3>\r\n\r\n<p>This method will return a specific obligation for a user</p>")
    return response

@app.route('/obligations', methods = ['POST'])
def create_obligation():
    return ("<H1>Place Holder</H1>\r\n<H3>POST /obligations</H3>\r\n\r\n<p>This method will create a new obligation for the user</p>")

@app.route('/obligations/<int:obligation_id>', methods = ['PATCH'])
def modify_obligation(obligation_id):
    return ("<H1>Place Holder</H1>\r\n<H3>PATCH /obligations/:id</H3>\r\n\r\n<p>This method will modify/update an obligation for the user</p>")

@app.route('/obligations/<int:obligation_id>', methods = ['DELETE'])
def delete_obligation(obligation_id):
    return ("<H1>Place Holder</H1>\r\n<H3>DELETE /obligations/:id</H3>\r\n\r\n<p>This method will delete an obligation for the user</p>")

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=int('5000'))
