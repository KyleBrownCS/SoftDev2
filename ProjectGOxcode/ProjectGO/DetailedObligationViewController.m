//
//  DetailedObligationViewController.m
//  ProjectGO
//
//  Created by Kyle Brown on 2014-03-12.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import "DetailedObligationViewController.h"

@interface DetailedObligationViewController ()

@end

@implementation DetailedObligationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*NSMutableString *text [NSMutableString stringWithFormat:@"%@%@", @"Name: ", [_object objectForKeyedSubscript:name]];
    
    NSMutableString *detail;
    detail = [NSMutableString stringWithFormat:@"Description: %@ ",
              [tmpDict objectForKey:description]];
    
    cell.textLabel.text = text;
    cell.detailTextLabel.text= detail;
    cell.imageView.frame = CGRectMake(0, 0, 80, 70);
    
    [_loadingSpinner stopAnimating];            //This might be in the wrong location. We can look into proper placement in the near future.
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
