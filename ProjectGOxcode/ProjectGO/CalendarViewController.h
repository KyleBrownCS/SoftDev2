//
//  CalendarViewController.h
//  ProjectGO
//
//  Created by Ben Catalan on 3/17/2014.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarController.h"

@interface CalendarViewController : UIViewController {
    
    CalendarController *calendarController;
}

@property (nonatomic, retain) CalendarController *calendarController;
@property (strong, nonatomic) IBOutlet UIView *viewCalendar;


@end
