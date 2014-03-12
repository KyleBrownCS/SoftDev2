//
//  LoadAllObligationsViewController.h
//  ProjectGO
//
//  Created by Kyle Brown on 2014-03-10.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadAllObligationsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableList;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;
@property (weak, nonatomic) IBOutlet UITableView *mainView;

@end
