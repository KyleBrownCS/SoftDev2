//
//  FindObligationViewController.m
//  ProjectGO
//
//  Created by Kyle Brown on 2014-03-13.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import "FindObligationViewController.h"

@interface FindObligationViewController ()

@end

@implementation FindObligationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)searchByID:(id)sender {
    
    NSDictionary* json = [self getObligationsByID:_idField.text];
    
    int failed = 0;
    if ([[json valueForKeyPath:@"error"] intValue] > 0) {
        failed = [[json objectForKey:@"error" ] integerValue];
    }
    
    if (failed) {
        _name.text = @"Match not found!";
        _desription.text = @"Please review your ID you searched for.";
        _startdate.text = @"";
        _enddate.text = @"";
        _priority.text = @"";
        _status.text = @"";
        _category.text = @"";
    }
    else {
        _name.text = [json objectForKey:@"name"];
        _desription.text = [json objectForKey:@"description"];
        _startdate.text = [json objectForKey:@"starttime"];
        _enddate.text = [json objectForKey:@"endtime"];
        _priority.text = [[json objectForKey:@"priority"] stringValue];
        _status.text = [[json objectForKey:@"status"] stringValue];
        _category.text = [[json objectForKey:@"category"] stringValue];
    }
}

- (NSDictionary*)getObligationsByID:(NSString*)obid{
    
    NSString *url = [NSString stringWithFormat:@"%@%@/%@", SERVER_ADDRESS, OBLIGATION_SUB_URL, _idField.text];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error != nil)
    {
        json = [[NSDictionary alloc] initWithObjectsAndKeys:@"1", @"error", nil];
    }
    
    return json;
}

@end
