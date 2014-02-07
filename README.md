SoftDev2
========

Software Development 2 Group 7 Project

To connect to our group project, connect to http://54.201.135.92.

To run this you will require the following...

 - Python 2.6.X or higher (not including Python 3.X.X).

 - Flask 0.10 on your machine which you can install by running `pip install Flask` on your command line. More details on installation can be found at http://flask.pocoo.org/.

 - You will need a directory at the following location where you can download and install the following to. Navigate to and create the following directory if it doesnt already exist.
 	 - `cd /var/www`
 	 - `mkdir softeng2`
 	 - `cd softeng2`

 - Sqlite3 which is the database that we are using. You can install this by doing the following.
 	`wget http://www.sqlite.org/2014/sqlite-autoconf-3080300.tar.gz`
 	`tar -xvf sqlite-autoconf-3070603.tar.gz`
	`cd sqlite-autoconf-3070603`
	`./configure`
	`make`
	`make install`
	`make clean`
	You will also require to create a table (for the current version) named 'temptable'. To do this, follow these settings.
	 - `cd /var/www/softeng2`
	 - `sqlite3 tempdb.db`
	 - `create table testtable(fname varchar(30), lname varchar(30), id interger)`
	 - `insert into testtable("MyFirstName", "MyLastName", 1);`
	 - `.exit`
	 Your sqldb is now created.

 - mod_wsgi and Apache2
 	To download these, do the following:
 	 - `wget https://modwsgi.googlecode.com/files/mod_wsgi-3.4.tar.gz`
 	 - `tar -xvf mod_wsgi-3.4.tar.gz`
 	 - `cd mod_wsgi-3.4`
 	 - `./configure`
 	 - `make install clean distclean`

 	You will now need apache2 which you can get from the following.
 	 - `yum -y install httpd httpd-devel`

 	You will now need to overwrite the following file with "httpd.conf" on this repo.
 	Repalce "/etc/httpd/conf/httpd.conf" with the httpd.conf found on this repo.
 	Use `/etc/init.d/httpd stop` to make sure this service is off


Running locally though Python/Flask
===================================
To view this application on your local machine, run `python helloworld.py` on the file with Flask installed, then direct your browser to "http://127.0.0.1:5000/" or your aws instance. Press `CTRL + C` to quit the local copy.


Running a Proper WebServer
==========================
To have this project running constantly as a daemon, you will need to turn on httpd by the following command.
- `/etc/init.d/httpd start`

Now, if you connect to "http://127.0.0.1:5000/" you can connect to our project, regardless if someone has an instance running on the server itself.

Trello, our project traccking application can be found at https://trello.com/b/zVzNjZvz/project-go with proper credentials and login. Invite only.

