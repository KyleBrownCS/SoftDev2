//
//  ProjectGOViewController.m
//  ProjectGo
//
//  Created by Ben Catalan on 2/28/2014.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import "ProjectGOViewController.h"
#import "constants.h"

static int calendarShadowOffset = (int)-20;

@implementation ProjectGOViewController

@synthesize calendar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		//calendar = 	[[TKCalendarMonthView alloc] init];
		//calendar.delegate = self;
		//calendar.dataSource = self;
    }
    return self;
}

- (void)loadView {
	// Costruct the view because we aren't using a
    [super loadView];
//	int statusBarHeight = 20;
//	CGRect applicationFrame = (CGRect)[[UIScreen mainScreen] applicationFrame];
//	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, statusBarHeight, applicationFrame.size.width, applicationFrame.size.height)];
//	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//	self.view.backgroundColor = [UIColor grayColor];
//	
//	// Add button to toggle calendar
//	UIButton *toggleButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 370, 220, 50)];
//	toggleButton.backgroundColor = [UIColor darkGrayColor];
//	toggleButton.titleLabel.font = [UIFont systemFontOfSize:12];
//	toggleButton.titleLabel.textColor = [UIColor whiteColor];
//	[toggleButton setTitle:@"Toggle Calendar" forState:UIControlStateNormal];
//	[toggleButton addTarget:self action:@selector(toggleCalendar) forControlEvents:UIControlEventTouchUpInside];
//	
//    
//    [self.view addSubview:toggleButton];
//	
//    
//	// Add Calendar to just off the top of the screen so it can later slide down
//	calendar.frame = CGRectMake(0, -calendar.frame.size.height+calendarShadowOffset, calendar.frame.size.width, calendar.frame.size.height);
//	// Ensure this is the last "addSubview" because the calendar must be the top most view layer
//    // Custom initialization.
//    calendar = 	[[TKCalendarMonthView alloc] init];
//    calendar.delegate = self;
//    calendar.dataSource = self;
//    
//	[self.view addSubview:calendar];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *docsDir;
//    NSArray *dirPaths;
//    
//    // Get the documents directory
//    dirPaths = NSSearchPathForDirectoriesInDomains(
//                                                   NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    docsDir = dirPaths[0];
//    
//    // Build the path to the database file
//    _databasePath = [[NSString alloc]
//                     initWithString: [docsDir stringByAppendingPathComponent:
//                                      @"GoDB.db"]];
//    
//    NSFileManager *filemgr = [NSFileManager defaultManager];
//    
//    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
//    {
//        const char *dbpath = [_databasePath UTF8String];
//        
//        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
//        {
//            char *errMsg;
//            const char *sql_stmt =
//            "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, DESCRIPTION TEXT, STARTTIME TEXT, ENDTIME TEXT, PRIORITY TEXT, STATUS TEXT, CATEGORY TEXT)";
//            
//            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
//            {
//                _status.text = @"Failed to create table";
//            }
//            sqlite3_close(_contactDB);
//        } else {
//            _status.text = @"Failed to open/create database";
//        }
//    }
}

- (void)toggleCalendar {
	// If calendar is off the screen, show it, else hide it (both with animations)
	if (calendar.frame.origin.y == -calendar.frame.size.height+calendarShadowOffset) {
		// Show
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.75];
		calendar.frame = CGRectMake(0, 0, calendar.frame.size.width, calendar.frame.size.height);
		[UIView commitAnimations];
	} else {
		// Hide
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.75];
		calendar.frame = CGRectMake(0, -calendar.frame.size.height+calendarShadowOffset, calendar.frame.size.width, calendar.frame.size.height);
		[UIView commitAnimations];
	}
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
	NSLog(@"calendarMonthView didSelectDate");
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
	NSLog(@"calendarMonthView monthDidChange");
}


- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {
	NSLog(@"calendarMonthView marksFromDate toDate");
	NSLog(@"Make sure to update 'data' variable to pull from CoreData, website, User Defaults, or some other source.");
	// When testing initially you will have to update the dates in this array so they are visible at the
	// time frame you are testing the code.
	NSArray *data = [NSArray arrayWithObjects:
					 @"2011-01-01 00:00:00 +0000", @"2011-01-09 00:00:00 +0000", @"2011-01-22 00:00:00 +0000",
					 @"2011-01-10 00:00:00 +0000", @"2011-01-11 00:00:00 +0000", @"2011-01-12 00:00:00 +0000",
					 @"2011-01-15 00:00:00 +0000", @"2011-01-28 00:00:00 +0000", @"2011-01-04 00:00:00 +0000",
					 @"2011-01-16 00:00:00 +0000", @"2011-01-18 00:00:00 +0000", @"2011-01-19 00:00:00 +0000",
					 @"2011-01-23 00:00:00 +0000", @"2011-01-24 00:00:00 +0000", @"2011-01-25 00:00:00 +0000",
					 @"2011-02-01 00:00:00 +0000", @"2011-03-01 00:00:00 +0000", @"2011-04-01 00:00:00 +0000",
					 @"2011-05-01 00:00:00 +0000", @"2011-06-01 00:00:00 +0000", @"2011-07-01 00:00:00 +0000",
					 @"2011-08-01 00:00:00 +0000", @"2011-09-01 00:00:00 +0000", @"2011-10-01 00:00:00 +0000",
					 @"2011-11-01 00:00:00 +0000", @"2011-12-01 00:00:00 +0000", nil];
	
    
	// Initialise empty marks array, this will be populated with TRUE/FALSE in order for each day a marker should be placed on.
	NSMutableArray *marks = [NSMutableArray array];
	
	// Initialise calendar to current type and set the timezone to never have daylight saving
	NSCalendar *cal = [NSCalendar currentCalendar];
	[cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	
	// Construct DateComponents based on startDate so the iterating date can be created.
	// Its massively important to do this assigning via the NSCalendar and NSDateComponents because of daylight saving has been removed
	// with the timezone that was set above. If you just used "startDate" directly (ie, NSDate *date = startDate;) as the first
	// iterating date then times would go up and down based on daylight savings.
	NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit |
                                              NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit)
                                    fromDate:startDate];
	NSDate *d = [cal dateFromComponents:comp];
	
	// Init offset components to increment days in the loop by one each time
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setDay:1];
	
    
	// for each date between start date and end date check if they exist in the data array
	while (YES) {
		// Is the date beyond the last date? If so, exit the loop.
		// NSOrderedDescending = the left value is greater than the right
		if ([d compare:lastDate] == NSOrderedDescending) {
			break;
		}
		
		// If the date is in the data array, add it to the marks array, else don't
		if ([data containsObject:[d description]]) {
			[marks addObject:[NSNumber numberWithBool:YES]];
		} else {
			[marks addObject:[NSNumber numberWithBool:NO]];
		}
		
		// Increment day using offset components (ie, 1 day in this instance)
		d = [cal dateByAddingComponents:offsetComponents toDate:d options:0];
	}
	
	//[offsetComponents release];
	
	return [NSArray arrayWithArray:marks];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Disabled rotation for this example
	return NO;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary*)getObligationWithID:(NSString*)obID {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS, OBLIGATION_SUB_URL, obID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error != nil)
    {
        json = [[NSDictionary alloc] initWithObjectsAndKeys:@"1", @"error", nil];
    }
    
    return json;
}

- (void) find:(id)sender
{
    
    NSDictionary* json = [self getObligationWithID:_obID.text];
    int failed = 0;
    if ([[json valueForKeyPath:@"error"] intValue] > 0) {
        failed = [[json objectForKey:@"error" ] integerValue];
    }
    
    if (failed) {
        _statuslbl.text = @"Match not found";
        _description.text = @"NOT FOUND";
        _startTime.text = @"";
        _endTime.text = @"";
        _priority.text = @"";
        _status.text = @"";
        _category.text = @"";
    }
    else {
        //NSLog(@"description is %@",[json objectForKey:@"description"]);
        //_statuslbl.text = [json objectForKey:@"userid"];
        _name.text = [json objectForKey:@"name"];
        _description.text = [json objectForKey:@"description"];
        _startTime.text = [json objectForKey:@"starttime"];
        _endTime.text = [json objectForKey:@"endtime"];
        _priority.text = [[json objectForKey:@"priority"] stringValue];
        _status.text = [[json objectForKey:@"status"] stringValue];
        _category.text = [[json objectForKey:@"category"] stringValue];
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
