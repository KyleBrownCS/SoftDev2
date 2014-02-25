from flask import Flask
import sqlite3
app = Flask(__name__)

@app.route('/')
def hello_world():
        conn = sqlite3.connect('/var/www/softeng2/GoDB.db')
        stuff = ""
        c = conn.cursor()
        for row in c.execute("select * from users"):
                stuff = stuff + str(row) + "<br>"
        stuff = stuff + "<br>"
        return ("Hello worldddddddddd! :)!<br>This is group 7s Soft Eng landing space" + "<br>This is raw data pulled from our db:<br>" + stuff)

if __name__ == "__main__":
        app.run(debug=True, host='0.0.0.0', port=int('80'))
