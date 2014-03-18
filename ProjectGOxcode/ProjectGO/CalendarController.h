//
//  CalendarController.h
//  ProjectGO
//
//  Created by Ben Catalan on 3/14/2014.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKCalendarMonthView.h"

@interface CalendarController : UIViewController <TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource> {
	TKCalendarMonthView *calendar;
}

@property (nonatomic, retain) TKCalendarMonthView *calendar;

@end