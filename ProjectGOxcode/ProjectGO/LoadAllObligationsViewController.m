//
//  LoadAllObligationsViewController.m
//  ProjectGO
//
//  Created by Kyle Brown on 2014-03-10.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import "LoadAllObligationsViewController.h"
#import "DetailedObligationViewController.h"

@interface LoadAllObligationsViewController ()

@end

NSMutableArray *myobj;
NSDictionary *myDict;

NSString *name;
NSString *description;
NSString *obligationid;
NSString *status;
NSString *endtime;
NSString *starttime;
NSString *category;
NSString *priority;
NSString *userid;

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
    detail = [NSMutableString stringWithFormat:@"Description: %@ ",
              [tmpDict objectForKey:description]];
    
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
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_loadingSpinner startAnimating];
    name = @"name";
    description = @"description";
    obligationid = @"obligationid";
    starttime = @"starttime";
    endtime = @"endtime";
    userid  = @"userid";
    category = @"category";
    priority =@"priortity";
    status = @"status";
    
    
    myobj = [[NSMutableArray alloc] init];
    
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", SERVER_ADDRESS, OBLIGATION_SUB_URL]]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
   
    
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
        
        NSLog(@"priv: %@",pri_data);
        NSLog(@"stat: %@",stat_data);
        NSLog(@"obid: %@",obid_data);
        NSLog(@"name: %@",name_data);
        NSLog(@"start: %@",stat_data);
        NSLog(@"end: %@",endtime_data);
        NSLog(@"userid: %@",userid_data);
        NSLog(@"cat: %@",cat_data);
        NSLog(@"desc: %@",description_data);
        
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
        
        [myobj addObject:myDict];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        NSIndexPath *indexPath = [self.tableList indexPathForSelectedRow];
        DetailedObligationViewController *destViewController = segue.destinationViewController;
        destViewController.object = [myobj objectAtIndex:indexPath.row];
        NSLog(@"alldata: %@", [myobj objectAtIndex:indexPath.row]);
    }
}

@end
























