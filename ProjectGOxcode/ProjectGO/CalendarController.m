//
//  CalendarController.m
//  ProjectGO
//
//  Created by Ben Catalan on 3/14/2014.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import "CalendarController.h"
#import "ProjectGOAppDelegate.h"

@implementation CalendarController

@synthesize calendar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		calendar = 	[[TKCalendarMonthView alloc] init];
		calendar.delegate = self;
		calendar.dataSource = self;
    }
    return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	// Costruct the view because we aren't using a
	int statusBarHeight = 20;
	CGRect applicationFrame = (CGRect)[[UIScreen mainScreen] applicationFrame];
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, statusBarHeight, applicationFrame.size.width, applicationFrame.size.height)];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.view.backgroundColor = [UIColor grayColor];
    
    calendar.frame = CGRectMake(0, 0, calendar.frame.size.width, calendar.frame.size.height);
    
    //calendar.transform = CGAffineTransformMakeScale(2.0, 2.0);
    
	[self.view addSubview:calendar];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods

- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
	NSLog(@"calendarMonthView didSelectDate");
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
	NSLog(@"calendarMonthView monthDidChange");
}

#pragma mark -
#pragma mark TKCalendarMonthViewDataSource methods

- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {
	NSLog(@"calendarMonthView marksFromDate toDate");
	NSLog(@"Make sure to update 'data' variable to pull from CoreData, website, User Defaults, or some other source.");
	// When testing initially you will have to update the dates in this array so they are visible at the
	// time frame you are testing the code.
	NSArray *data = [NSArray arrayWithObjects:
					 @"2014-01-02 00:00:00 +0000", @"2014-01-09 00:00:00 +0000", @"2014-01-22 00:00:00 +0000",
					 @"2014-01-10 00:00:00 +0000", @"2014-01-11 00:00:00 +0000", @"2014-01-12 00:00:00 +0000",
					 @"2014-01-15 00:00:00 +0000", @"2014-01-28 00:00:00 +0000", @"2014-01-04 00:00:00 +0000",
					 @"2014-01-16 00:00:00 +0000", @"2014-01-18 00:00:00 +0000", @"2014-01-19 00:00:00 +0000",
					 @"2014-01-23 00:00:00 +0000", @"2014-01-24 00:00:00 +0000", @"2014-01-25 00:00:00 +0000",
					 @"2014-02-01 00:00:00 +0000", @"2014-03-01 00:00:00 +0000", @"2014-04-01 00:00:00 +0000",
					 @"2014-05-01 00:00:00 +0000", @"2014-06-01 00:00:00 +0000", @"2014-07-01 00:00:00 +0000",
					 @"2014-08-01 00:00:00 +0000", @"2014-09-01 00:00:00 +0000", @"2014-10-01 00:00:00 +0000",
					 @"2014-11-01 00:00:00 +0000", @"2014-12-01 00:00:00 +0000", nil];
	
    
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
	
	return [NSArray arrayWithArray:marks];
}

#pragma mark -
#pragma mark Rotation

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Disabled rotation for this example
	return NO;
}

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
}


@end
