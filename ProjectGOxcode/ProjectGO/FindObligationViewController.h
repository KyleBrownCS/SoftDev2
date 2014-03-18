//
//  FindObligationViewController.h
//  ProjectGO
//
//  Created by Kyle Brown on 2014-03-13.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "constants.h"

@interface FindObligationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *desription;
@property (weak, nonatomic) IBOutlet UITextField *startdate;
@property (weak, nonatomic) IBOutlet UITextField *enddate;
@property (weak, nonatomic) IBOutlet UITextField *priority;
@property (weak, nonatomic) IBOutlet UITextField *status;
@property (weak, nonatomic) IBOutlet UITextField *category;
@property (weak, nonatomic) IBOutlet UITextField *idField;

@end
