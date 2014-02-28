//
//  ProjectGOViewController.h
//  ProjectGo
//
//  Created by Ben Catalan on 2/28/2014.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ProjectGOViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *description;
@property (strong, nonatomic) IBOutlet UITextField *startTime;
@property (strong, nonatomic) IBOutlet UITextField *endTime;
@property (strong, nonatomic) IBOutlet UITextField *priority;
@property (strong, nonatomic) IBOutlet UITextField *status;
@property (strong, nonatomic) IBOutlet UITextField *category;
@property (strong, nonatomic) IBOutlet UILabel *statuslbl;

- (IBAction)saveData:(id)sender;
- (IBAction)find:(id)sender;

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

@end
