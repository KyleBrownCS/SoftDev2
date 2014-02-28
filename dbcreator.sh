#!/bin/bash
mkdir databases
chmod 777 databases
chown user1 databases
DB=./databases/GoDB.db
sqlite3 $DB "create table users(userid integer primary key not null, userName varchar(15));"
sqlite3 $DB "create table userinfo(userid int primary key not null, name varchar(50), address varchar(50), birthday text, foreign key(userid) references users(userid));"
sqlite3 $DB "create table obligation(obligationid integer primary key not null, userid int not null, name varchar(30), description varchar(200), starttime text, endtime text, priority int, status int, category int, foreign key(userid) references users(userid));"
sqlite3 $DB "create table subObligation(sobligationid integer primary key not null, obligationid not null, name varchar(15), description varchar(200), starttime text, endtime text, priority int, status int, foreign key(obligationid) references obligation(obligationid));"
sqlite3 $DB "create table reminder(reminderid integer primary key not null, obligationid int not null, remindertime text, description varchar(200), foreign key(obligationid) references obligation(obligationid));"
sqlite3 $DB "create table alarm(alarmid integer primary key not null, obligationid int not null, alarmtime text, soundType int, foreign key(obligationid) references obligation(obligationid));"
sqlite3 $DB "create table contactlist(userid int primary key not null, userlist text, foreign key(userid) references users(userid));"

echo "Attempted creating $DB file (doesn't actually check yet, just asserts this script has finished)"