//
//  LoadAllObligationsViewController.h
//  ProjectGO
//
//  Created by Kyle Brown on 2014-03-10.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "constants.h"

@interface LoadAllObligationsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableList;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;

@end
