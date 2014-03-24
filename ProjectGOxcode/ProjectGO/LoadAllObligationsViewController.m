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

NSMutableArray *myobj;
NSDictionary *myDict;

NSString *name = @"name";
NSString *description = @"description";
NSString *obligationid = @"obligationid";
NSString *status = @"status";
NSString *endtime = @"endtime";
NSString *starttime = @"starttime";
NSString *category = @"category";
NSString *priority = @"priority";
NSString *userid = @"userid";

@implementation LoadAllObligationsViewController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Item";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:
              UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    NSDictionary *tmpDict = [myobj objectAtIndex:indexPath.row];
    
    NSMutableString *text;
    text = [NSMutableString stringWithFormat:@"%@", [tmpDict objectForKeyedSubscript:name]];
    
    NSMutableString *detail;
    detail = [NSMutableString stringWithFormat:@"(%@) \"%@\"", [tmpDict objectForKey:obligationid], [tmpDict objectForKey:description]];
    
    cell.textLabel.text = text;
    cell.detailTextLabel.text= detail;
    cell.imageView.frame = CGRectMake(0, 0, 80, 70);
    
    [_loadingSpinner stopAnimating];            //This might be in the wrong location. We can look into proper placement in the near future.
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return myobj.count;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_loadingSpinner startAnimating];
    myobj = [LoadAllObligationsViewController loadAllObligations];
}

+ (NSMutableArray*)loadAllObligations
{
    id jsonObjects = [LoadAllObligationsViewController getObligations];
    NSMutableArray *thisObj = [LoadAllObligationsViewController fillObj: jsonObjects];
    return thisObj;
}

+ (id)getObligations
{
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", SERVER_ADDRESS, OBLIGATION_SUB_URL]]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
    return jsonObjects;
}

+ (NSMutableArray*)fillObj:(id)jsonObjects
{
    NSMutableArray *thisObj = [[NSMutableArray alloc] init];
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *pri_data = [dataDict objectForKey:@"priority"];
        NSString *stat_data = [dataDict objectForKey:@"status"];
        NSString *obid_data = [dataDict objectForKey:@"obligationid"];
        NSString *name_data = [dataDict objectForKey:@"name"];
        NSString *starttime_data = [dataDict objectForKey:@"starttime"];
        NSString *endtime_data = [dataDict objectForKey:@"endtime"];
        NSString *userid_data = [dataDict objectForKey:@"userid"];
        NSString *cat_data = [dataDict objectForKey:@"category"];
        NSString *description_data = [dataDict objectForKey:@"description"];
        
        myDict = [NSDictionary dictionaryWithObjectsAndKeys:
                  userid_data, userid,
                  obid_data, obligationid,
                  name_data, name,
                  description_data, description,
                  starttime_data, starttime,
                  endtime_data, endtime,
                  pri_data, priority,
                  cat_data, category,
                  stat_data, status, nil];
        
        [thisObj addObject:myDict];
    }
    return thisObj;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
























