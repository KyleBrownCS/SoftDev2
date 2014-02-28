#!/bin/bash


sqlite3 ./databases/GoDB.db "insert into users values(1, 'UserName')";
sqlite3 ./databases/GoDB.db "insert into users values(2, 'UserName2')";
sqlite3 ./databases/GoDB.db "insert into users values(3, 'UserName3')";

sqlite3 ./databases/GoDB.db "insert into obligation values(1, 1, 'Dude name', 'This is a long description', '2014-01-01 00:00:00.000', '2014-01-01 01:00:00.000', 1, 1, 1)";
sqlite3 ./databases/GoDB.db "insert into obligation values(2, 2, 'Dude name2', 'This is another long description', '2014-01-01 00:00:00.000', '2014-01-01 01:00:00.000', 1, 1, 1)";
sqlite3 ./databases/GoDB.db "insert into obligation values(3, 1, 'Dude name', 'shorter description', '2014-01-01 00:00:00.000', '2014-01-01 01:00:00.000', 1, 1, 1)";
sqlite3 ./databases/GoDB.db "insert into obligation values(4, 3, 'Test', 'Longggggggggggggggggggggggggg description', '2014-01-01 00:00:00.000', '2014-01-01 01:00:00.000', 1, 2, 3)";
sqlite3 ./databases/GoDB.db "insert into obligation values(5, 4, 'Test2', '', '2014-01-05 00:00:00.000', '2014-01-10 01:00:00.000', 1, 4, 9)";

echo "Attempted to create dummyusers and a few obligations (This just prints but currently doesnt actually error check)"
