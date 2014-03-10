//
//  ObligationCreationViewController.m
//  ProjectGO
//
//  Created by Kyle Brown on 2014-03-10.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import "ObligationCreationViewController.h"

@interface ObligationCreationViewController ()

@end

@implementation ObligationCreationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*) convertDateTimes:(NSString*) theDate temp:(NSString*) theTime{
    //Convert all this stuff into the properly formatted time style for our project.
    return [NSString stringWithFormat:@"%@ /%@", theDate, theTime];
}


- (IBAction)sendInObligation:(id)sender {
    
    sqlite3_stmt    *statement;
    NSString* startDetails;
    NSString* endDetails;
    
    const char *dbpath = [_databasePath UTF8String];
    [_statusSymb startAnimating];    
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        startDetails = [self convertDateTimes:_startDate.text temp: _startTime.text];
        endDetails = [self convertDateTimes:_endDate.text temp: _endTime.text];
        
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO CONTACTS (name, description, starttime,endtime,priority,status,category) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\",  \"%@\", \"%@\")",
                               _name.text, _description.text, startDetails, endDetails, _priority.text,_status.text, _category.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            _name.text = @"";
            _description.text = @"";
            _startTime.text = @"";
            _endTime.text = @"";
            _priority.text = @"";
            _status.text = @"";
            _category.text = @"";
            
            
        } else {
            //Failure
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
        [_statusSymb stopAnimating];
    }
}

@end
