//
//  CalendarViewController.m
//  ProjectGO
//
//  Created by Ben Catalan on 3/17/2014.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarController.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

@synthesize calendarController;
@synthesize viewCalendar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    calendarController = [[CalendarController alloc] init];
    
    [super.view addSubview:calendarController.view];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
