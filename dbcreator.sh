#!/bin/bash

sqlite3 GoDB.db "create table users(userid int primary key not null, userName varchar(15));"
sqlite3 GoDB.db "create table userinfo(userid int primary key not null, name varchar(50), address varchar(50), birthday text);"
sqlite3 GoDB.db "create table obligation(obligationid int not null, userid int not null, name varchar(30), description varchar(200), starttime text, endtime text, priority int, status int, category int, primary key(userid, obligationid));"
sqlite3 GoDB.db "create table subObligation(sobligationid int not null, obligationid not null, name varchar(15), description varchar(200), starttime text, endtime text, priority int, status int, primary key(sobligationid, obligationid));"
sqlite3 GoDB.db "create table reminder(reminderid int not null, obligationid int not null, remindertime text, description varchar(200), primary key(reminderid, obligationid));"
sqlite3 GoDB.db "create table alarm(alarmid int not null, obligationid int not null, alarmtime text, soundType int, primary key(alarmid, obligationid));"
sqlite3 GoDB.db "create table contactlist(userid int primary key not null, userlist text);"

echo "Attempted creating GoDB.db file (doesn't actually check yet, just asserts this script has finished)"
