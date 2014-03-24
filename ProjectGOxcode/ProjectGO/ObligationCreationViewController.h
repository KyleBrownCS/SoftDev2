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
@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDate;
@property (weak, nonatomic) IBOutlet UITextField *description;
@property (weak, nonatomic) IBOutlet UITextField *priority;
@property (weak, nonatomic) IBOutlet UITextField *status;
@property (weak, nonatomic) IBOutlet UITextField *category;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *statusSymb;

@property (weak, nonatomic) IBOutlet UITextView *errorBox;

- (IBAction)addObligationButton:(id)sender;
- (NSString*) convertDateTimes:(NSString*) theDate temp:(NSString*) theTime;
+ (void) setupAddObligation:(NSString*) nameFieldText :(NSString*) descriptionFieldText :(NSString*) priorityFieldText :(NSString*) statusFieldText :(NSString*) categoryFieldText;
+ (NSString*)addObligation: (NSString*)postData;


@end
