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
}


- (void)viewDidLoad {
    [super viewDidLoad];
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

@end
