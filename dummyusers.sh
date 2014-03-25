#!/bin/bash


sqlite3 ./databases/GoDB.db "insert into users values(1, 'UserName')";
sqlite3 ./databases/GoDB.db "insert into users values(2, 'UserName2')";
sqlite3 ./databases/GoDB.db "insert into users values(3, 'UserName3')";

sqlite3 ./databases/GoDB.db "insert into obligation values(1, 1, 'Dinner Date', 'Dinner with my best friends!!!', '2014-01-01 00:00:00.000', '2014-01-01 01:00:00.000', 1, 1, 1)";
sqlite3 ./databases/GoDB.db "insert into obligation values(2, 2, 'movie night', 'Game of Thrones Episode 234', '2014-01-01 00:00:00.000', '2014-01-01 01:00:00.000', 1, 1, 1)";
sqlite3 ./databases/GoDB.db "insert into obligation values(3, 1, 'study date', 'Software Engineering test coming up...', '2014-01-01 00:00:00.000', '2014-01-01 01:00:00.000', 1, 1, 1)";
sqlite3 ./databases/GoDB.db "insert into obligation values(4, 3, 'Test', 'DB exam', '2014-01-01 00:00:00.000', '2014-01-01 01:00:00.000', 1, 2, 3)";
sqlite3 ./databases/GoDB.db "insert into obligation values(5, 4, 'exam', '', '2014-01-05 00:00:00.000', '2014-01-10 01:00:00.000', 1, 4, 9)";
sqlite3 ./databases/GoDB.db "insert into obligation values(6, 4, 'meeting', '', '2014-03-04 00:00:00.000', '2014-01-10 01:00:00.000', 1, 2, 9)";
sqlite3 ./databases/GoDB.db "insert into obligation values(7, 4, 'apple picking', '', '2014-03-05 00:00:00.000', '2014-01-10 01:00:00.000', 1, 4, 9)";

echo "Filled the database with fake data."
