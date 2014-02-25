#!/bin/bash

sqlite3 GoDB.db "insert into users values(1, 'UserName')";
sqlite3 GoDB.db "insert into users values(2, 'UserName2')";
sqlite3 GoDB.db "insert into users values(3, 'UserName3')";

echo "Success creating dummyusers (This just prints but currently doesnt actually error check)"
