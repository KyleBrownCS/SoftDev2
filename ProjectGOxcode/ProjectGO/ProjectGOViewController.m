//
//  ProjectGOViewController.m
//  ProjectGo
//
//  Created by Ben Catalan on 2/28/2014.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import "ProjectGOViewController.h"

@interface ProjectGOViewController ()

@end

@implementation ProjectGOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"GoDB.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, DESCRIPTION TEXT, STARTTIME TEXT, ENDTIME TEXT, PRIORITY TEXT, STATUS TEXT, CATEGORY TEXT)";
            
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                _status.text = @"Failed to create table";
            }
            sqlite3_close(_contactDB);
        } else {
            _status.text = @"Failed to open/create database";
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) find:(id)sender
{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT description, starttime,endtime,priority,status,category FROM contacts WHERE name=\"%@\"",
                              _name.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *descriptionField = [[NSString alloc]
                                          initWithUTF8String:
                                          (const char *) sqlite3_column_text(
                                                                             statement, 0)];
                _description.text = descriptionField;
                
                NSString *starttimeField = [[NSString alloc]
                                        initWithUTF8String:(const char *)
                                        sqlite3_column_text(statement, 1)];
                
                
                
                _startTime.text = starttimeField;
                
                NSString *endtimeField = [[NSString alloc]
                                            initWithUTF8String:(const char *)
                                            sqlite3_column_text(statement, 2)];
                
                
                
                _endTime.text = endtimeField;
                
                NSString *priorityField = [[NSString alloc]
                                            initWithUTF8String:(const char *)
                                            sqlite3_column_text(statement, 3)];
                
                
                
                _priority.text = priorityField;
                
                NSString *statusField = [[NSString alloc]
                                            initWithUTF8String:(const char *)
                                            sqlite3_column_text(statement, 4)];
                
                
                
                _status.text = statusField;
                
                NSString *categoryField = [[NSString alloc]
                                         initWithUTF8String:(const char *)
                                         sqlite3_column_text(statement, 5)];
                
                _category.text = categoryField;
                
                _statuslbl.text = @"Match found";
            } else {
                _statuslbl.text = @"Match not found";
                _description.text = @"";
                _startTime.text = @"";
                _endTime.text = @"";
                _priority.text = @"";
                _status.text = @"";
                _category.text = @"";
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
}

- (void) saveData:(id)sender
{
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO CONTACTS (name, description, starttime,endtime,priority,status,category) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\",  \"%@\", \"%@\")",
                               _name.text, _description.text, _startTime.text,_endTime.text, _priority.text,_status.text, _category.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            _statuslbl.text = @"Obligation added";
            _name.text = @"";
            _description.text = @"";
            _startTime.text = @"";
             _endTime.text = @"";
             _priority.text = @"";
             _status.text = @"";
             _category.text = @"";
            
            
        } else {
            _statuslbl.text = @"Failed to add contact";
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
}

@end
