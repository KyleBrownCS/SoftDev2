//
//  DetailedObligationViewController.h
//  ProjectGO
//
//  Created by Kyle Brown on 2014-03-12.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedObligationViewController : UIViewController

@property (nonatomic, strong) NSDictionary *object;

@property (strong, nonatomic) IBOutlet UIView *name;
@property (strong, nonatomic) IBOutlet UIView *description;
@property (strong, nonatomic) IBOutlet UIView *starttime;
@property (strong, nonatomic) IBOutlet UIView *endtime;
@property (strong, nonatomic) IBOutlet UIView *priority;
@property (strong, nonatomic) IBOutlet UIView *category;
@property (strong, nonatomic) IBOutlet UIView *status;


@end
