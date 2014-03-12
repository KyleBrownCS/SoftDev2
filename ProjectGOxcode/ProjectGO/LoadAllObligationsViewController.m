//
//  LoadAllObligationsViewController.m
//  ProjectGO
//
//  Created by Kyle Brown on 2014-03-10.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import "LoadAllObligationsViewController.h"

@interface LoadAllObligationsViewController ()


@end

NSArray *headings;

@implementation LoadAllObligationsViewController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //create a cell
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.textLabel.text = [headings objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return headings.count;
}

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
    //mainView is the table view that we can add stuff too

    
    [super viewDidLoad];
    [_loadingSpinner startAnimating];
    
    NSString *serverAddress = @"http://54.201.135.92/obligations";
    NSString *url = [NSString stringWithFormat:@"%@", serverAddress];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                    cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error == nil)
    {
        //parse all the json and import into the tableview.
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        //NSArray *titles = [[json objectForKey:@"name"]objectAtIndex:0];
        
        headings = [json valueForKeyPath:@"name"];
        
        [_mainView reloadData];
    }
    
    else
    {
        //Handle the error case.
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
