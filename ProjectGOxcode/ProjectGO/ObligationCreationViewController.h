//
//  ObligationCreationViewController.h
//  ProjectGO
//
//  Created by Kyle Brown on 2014-03-10.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ObligationCreationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *description;
@property (weak, nonatomic) IBOutlet UITextField *startDate;
@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;
@property (weak, nonatomic) IBOutlet UITextField *priority;
@property (weak, nonatomic) IBOutlet UITextField *status;
@property (weak, nonatomic) IBOutlet UITextField *category;
@property (weak, nonatomic) IBOutlet UITextField *endDate;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *statusSymb;

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

@end
