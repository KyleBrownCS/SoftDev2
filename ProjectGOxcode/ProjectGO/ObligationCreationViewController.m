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
    
    NSString *nameFieldText = _name.text;
    NSString *descriptionFieldText = _description.text;
    NSString *priorityFieldText = _priority.text;
    NSString *statusFieldText = _status.text;
    NSString *categoryFieldText = _category.text;
    
    //convert the numeric fields to numbers
    NSInteger priorityFieldInt = [priorityFieldText integerValue];
    NSInteger statusFieldInt = [statusFieldText integerValue];
    NSInteger categoryFieldInt = [categoryFieldText integerValue];
    
    NSString *postDataString = [NSString stringWithFormat:@"userid=1&name=%@&description=%@&starttime=2014-01-01 00:00:00.000&endtime=2014-01-01 00:00:00.000&priority=%d&status=%d&category=%d", nameFieldText, descriptionFieldText, priorityFieldInt, statusFieldInt, categoryFieldInt];
    
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[postDataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    if (error == nil){
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        //check if the request failed on the server
        error = [json objectForKey:@"error" ];
        if(error != nil) {
            //success
        }
        else {
            //error occured server side
        }
    }
    
}
@end
