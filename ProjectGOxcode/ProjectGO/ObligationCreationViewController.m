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
    
    NSString *nameFieldText = _name.text;
    NSString *descriptionFieldText = _description.text;
    NSString *priorityFieldText = _priority.text;
    NSString *statusFieldText = _status.text;
    NSString *categoryFieldText = _category.text;
    
    //convert the numeric fields to numbers
    NSInteger priorityFieldInt = [priorityFieldText integerValue];
    NSInteger statusFieldInt = [statusFieldText integerValue];
    NSInteger categoryFieldInt = [categoryFieldText integerValue];
    
    if([nameFieldText length] == 0 || [priorityFieldText length] == 0 || [statusFieldText length] == 0 || [categoryFieldText length] ==0)
    {
        NSString* result = @"";
        
        if([nameFieldText length] == 0){
            result = [result stringByAppendingString:@"Name Missing.\n"];
        }
        
        if([priorityFieldText length] == 0)
        {
           result = [result stringByAppendingString:@"Priority Missing.\n"];
        }
        
        if([statusFieldText length] == 0)
        {
            result = [result stringByAppendingString:@"Status Missing.\n"];
        }
        
        if([categoryFieldText length] == 0)
        {
            result = [result stringByAppendingString:@"Category Missing.\n"];
        }
        _errorBox.text = result;
    }
    
    else
    {
        //The dates/times
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd H:m:s"];
        NSDate *startDate = _startDate.date;
        NSDate *endDate = _endDate.date;
        NSString *stringStartDate = [dateFormat stringFromDate:startDate];
        NSString *stringEndDate = [dateFormat stringFromDate:endDate];
        
        NSString *postString = [NSString stringWithFormat:@"userid=1&name=%@&description=%@&starttime=%@.000&endtime=%@.000&priority=%d&status=%d&category=%d", nameFieldText, descriptionFieldText,stringStartDate, stringEndDate, priorityFieldInt, statusFieldInt, categoryFieldInt];
        
        NSString *result = [self addObligation: postString];
        _errorBox.text = result;
    }
    
}

- (NSString*)addObligation: (NSString*)postData {
    NSString *ret = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_ADDRESS, OBLIGATION_SUB_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
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
            ret = @"COULD NOT ADD OBLIGATION";
        }
        else {
            ret = @"DATA SUCCESSFULLY ADDED";
        }
    }
    return ret;
}

- (IBAction)clearFields:(id)sender {
    _name.text = @"";
    _description.text  = @"";
    _priority.text = @"";
    _category.text = @"";
    _status.text = @"";
}
@end
