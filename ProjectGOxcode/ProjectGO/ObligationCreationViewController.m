//
//  ObligationCreationViewController.m
//  ProjectGO
//
//  Created by Kyle Brown on 2014-03-10.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import "ObligationCreationViewController.h"
#import "constants.h"

@interface ObligationCreationViewController ()

@end

@implementation ObligationCreationViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*) convertDateTimes:(NSString*) theDate temp:(NSString*) theTime{
    //Convert all this stuff into the properly formatted time style for our project.
    return [NSString stringWithFormat:@"%@ /%@", theDate, theTime];
}

- (IBAction)addObligationButton:(id)sender {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_ADDRESS, OBLIGATION_SUB_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"POST"];
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    if (error == nil){
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    }
    else{
        
    }
    
}
@end
