SoftDev2
========

Software Development 2 Group 7 Project

To connect to our group project, connect to http://54.213.113.207/

To run this you will require the following...

 - Python 2.6.X or higher (not including Python 3.X.X).

 - Flask 0.10 on your machine which you can install by running `pip install Flask` on your command line. More details on installation can be found at http://flask.pocoo.org/docs/installation/#installation.

 - You will need a directory at the following location where you can download and install the following to. Navigate to and create the following directory if it doesnt already exist. Also install Git.
	- `yum install git`
 	- `cd /var/www`
	- `git clone https://github.com/KyleBrownCS/SoftDev2.git`
	This will pull the repo into the SoftDev2 directory (subfolder of the current directory). Navigate into it by
	- `cd SoftEng2`

 - Sqlite3 which is the database that we are using. You can install this by doing the following.
 	`wget http://www.sqlite.org/2014/sqlite-autoconf-3080300.tar.gz`
 	`tar -xvf sqlite-autoconf-3080300.tar.gz`
	`cd sqlite-autoconf-3080300`
	`./configure`
	`make`
	`make install`
	`make clean`
	
	You will also need to create a databse and fill (currently) some dummy values into it. Do the following steps and make sure that `dbcreator.sh` and `dummyusers.sh` are inside the `/var/www/SoftDev2` directory.
	- `cd /var/www/SoftDev2`
	- `bash dbcreator.sh`
	- `bash dummyusers.sh`

 - mod_wsgi and Apache2
 	You will now need apache2 which you can get from the following.
 	 - `yum -y install httpd httpd-devel`

 	Now, overwrite the following file with "httpd.conf" on this repo.
 	Repalce "/etc/httpd/conf/httpd.conf" with the httpd.conf found on this repo using the following command.
 	- `mv httpd.conf /etc/httpd/conf/`

 	Use `/etc/init.d/httpd restart` to make sure this service is successfully turned on with the latest settings.

 	Also required are a new user called "user1" and a group called "group1".
 	You can create these by
 	 - `useradd user1`
 	 - `groupadd group1`

 	Now to get mod_wsgi:
     - `wget https://modwsgi.googlecode.com/files/mod_wsgi-3.4.tar.gz`
 	 - `tar -xvf mod_wsgi-3.4.tar.gz`
 	 - `cd mod_wsgi-3.4`
 	 - `./configure`
 	 - `make install clean distclean`


Running locally though Python/Flask
===================================
To view this application on your local machine, run `python helloworld.py` on the file with Flask installed, then direct your browser to http://127.0.0.1:5000/ or your aws instance. Press `CTRL + C` to quit the local copy.


Running a Proper WebServer
==========================
To have this project running constantly as a daemon, you will need to turn on httpd by the following command.
- `/etc/init.d/httpd start`

Now, if you connect to http://127.0.0.1:5000/ you can connect to our project, regardless if someone has an instance running on the server itself.

Trello, our project traccking application can be found at https://trello.com/b/zVzNjZvz/project-go with proper credentials and login. Invite only.

Using the current vim standard
==============================
To use the vim standard for this application, please copy the `.vimrc` file into your home directory. It will ensure that all tabs are 4 spaces, and present a stronly visable red backgrounded line to signify that you have passed the 80 character cap for the line width. It also defaults your line numbers to on as well as other things which you may view in the file.
