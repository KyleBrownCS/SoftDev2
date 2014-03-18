//
//  ProjectGOAppDelegate.h
//  ProjectGo
//
//  Created by Ben Catalan on 2/28/2014.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectGOViewController.h"
#import "CalendarViewController.h"

@interface ProjectGOAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ProjectGOViewController *projectGOViewController;
    CalendarViewController *calendarViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) ProjectGOViewController *projectGoViewController;
@property (nonatomic, retain) CalendarViewController
    *calendarController;

@end
