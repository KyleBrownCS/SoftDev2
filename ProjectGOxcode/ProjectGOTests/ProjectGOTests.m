//
//  ProjectGoTests.m
//  ProjectGoTests
//
//  Created by Ben Catalan on 2/28/2014.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoadAllObligationsViewController.h"
#import "FindObligationViewController.h"
#import "ObligationCreationViewController.h"
#import "OCMock/OCMock.h"

@interface ProjectGoTests : XCTestCase

@end

@implementation ProjectGoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*- (void)test_findObligationViewControllerValid
{
    NSString * const TEST_UID = @"1";
    NSString * const TEST_OBID = @"1";
    NSString * const TEST_NAME = @"Obligation Name";
    NSString * const TEST_DESCRIPTION = @"Test Description";
    NSString * const TEST_STIME = @"2013-10-01 12:45:30.081";
    NSString * const TEST_ETIME = @"2014-10-01 10:45:30.081";
    NSString * const TEST_CATEGORY = @"3";
    NSString * const TEST_PRIORITY = @"2";
    NSString * const TEST_STATUS = @"0";
    
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              TEST_UID, @"userid",
                              TEST_OBID, @"obligationid",
                              TEST_NAME, @"name",
                              TEST_DESCRIPTION, @"description",
                              TEST_STIME, @"starttime",
                              TEST_ETIME, @"endtime",
                              TEST_PRIORITY, @"priority",
                              TEST_CATEGORY, @"category",
                              TEST_STATUS, @"status",
                              nil];
    
    //id <UITextFieldDelegate> delegate = [FindObligationViewController.name delegate];
    
    NSString* temp = [FindObligationViewController.name getText];
    
    
    FindObligationViewController *findViewCtrler = [[FindObligationViewController alloc] init];
    [findViewCtrler handleSearch:(NSDictionary*)jsonDict];
    
    NSString* temp  = findViewCtrler getName;
    
    XCTAssertEqualObjects(TEST_DESCRIPTION, temp , @"");

}*/

- (void)test_LoadAllObligationsViewController
{
    NSError *error;
    NSDictionary *jsonDict;
    NSMutableArray *array;
    NSData *jsonData;
    id jsonObjects;
    NSMutableArray *myobj;
    NSDictionary *tempDict;
    
    //loading a complete object for test1
    error = nil;
    jsonDict = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"1", @"userid",
                             @"1", @"obligationid",
                             @"name", @"name",
                             @"desc", @"description",
                             @"start", @"starttime",
                             @"end", @"endtime",
                             @"cat", @"category",
                             @"priority", @"priority",
                             @"status", @"status",
                             nil];
    
    array = [[NSMutableArray alloc] init];
    [array addObject:jsonDict];
    
    jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    
    jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonData options:NSJSONReadingMutableContainers error:nil];
    
    //test1 with complete data
    myobj = [LoadAllObligationsViewController fillObj:jsonObjects];
    tempDict = [myobj objectAtIndex:0];
    NSMutableString *test1;
    test1 = [NSMutableString stringWithFormat:@"%@", [tempDict objectForKeyedSubscript:@"name"]];

    
    //test2 with no data
    myobj = [LoadAllObligationsViewController fillObj:nil];
    NSUInteger zero = 0;
    NSUInteger test2 = [myobj count];
    
    
    //loading incomplete data for test3
    jsonDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"1", @"userid",
                              nil];
    
    array = [[NSMutableArray alloc] init];
    [array addObject:jsonDict];
    
    jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    
    jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonData options:NSJSONReadingMutableContainers error:nil];
    
    //test3 with incomplete data
    myobj = [LoadAllObligationsViewController fillObj:jsonObjects];
    tempDict = [myobj objectAtIndex:0];
    NSString *test3 = [NSMutableString stringWithFormat:@"%@", [tempDict objectForKeyedSubscript:@"name"]];
    
    //assertions
    XCTAssertEqualObjects(test1, @"name", @"");
    XCTAssertEqual(test2, zero);
    XCTAssertEqualObjects(test3, @"(null)", @"");
}

-(void)test_LoadAllObligationsViewController_loadAllObligations
{
    //creating mock stub for the getObligations method (so we don't do a server request)
    id mockGet = [OCMockObject mockForClass:[LoadAllObligationsViewController class]];
    
    //creating data for the mockGet to return
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjectsAndKeys:
                @"userid1", @"userid",
                @"obligationid1", @"obligationid",
                @"name1", @"name",
                @"description1", @"description",
                @"starttime1", @"starttime",
                @"endtime1", @"endtime",
                @"category1", @"category",
                @"priority1", @"priority",
                @"status1", @"status",
                nil];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:jsonDict];
    
    //set the mockGet stub to return the array we just made
    [[[mockGet stub] andReturn:array] getObligations];
    
    //testing the loadAllObligations method (will use mockGet instead of the getObligations inside the loadAllObligations method)
    NSMutableArray *thisObj = [LoadAllObligationsViewController loadAllObligations];
    NSDictionary *tempDict = [thisObj objectAtIndex:0];
    
    NSString *testUserid       = [NSMutableString stringWithFormat:@"%@", [tempDict objectForKeyedSubscript:@"userid"]];
    NSString *testObligationid = [NSMutableString stringWithFormat:@"%@", [tempDict objectForKeyedSubscript:@"obligationid"]];
    NSString *testName         = [NSMutableString stringWithFormat:@"%@", [tempDict objectForKeyedSubscript:@"name"]];
    NSString *testDescription  = [NSMutableString stringWithFormat:@"%@", [tempDict objectForKeyedSubscript:@"description"]];
    NSString *testStart        = [NSMutableString stringWithFormat:@"%@", [tempDict objectForKeyedSubscript:@"starttime"]];
    NSString *testEnd          = [NSMutableString stringWithFormat:@"%@", [tempDict objectForKeyedSubscript:@"endtime"]];
    NSString *testCategory     = [NSMutableString stringWithFormat:@"%@", [tempDict objectForKeyedSubscript:@"category"]];
    NSString *testPriority     = [NSMutableString stringWithFormat:@"%@", [tempDict objectForKeyedSubscript:@"priority"]];
    NSString *testStatus       = [NSMutableString stringWithFormat:@"%@", [tempDict objectForKeyedSubscript:@"status"]];
    
    //asserting that everything was loaded correctly
    XCTAssertEqualObjects(testUserid, @"userid1", @"");
    XCTAssertEqualObjects(testObligationid, @"obligationid1", @"");
    XCTAssertEqualObjects(testName, @"name1", @"");
    XCTAssertEqualObjects(testDescription, @"description1", @"");
    XCTAssertEqualObjects(testStart, @"starttime1", @"");
    XCTAssertEqualObjects(testEnd, @"endtime1", @"");
    XCTAssertEqualObjects(testCategory, @"category1", @"");
    XCTAssertEqualObjects(testPriority, @"priority1", @"");
    XCTAssertEqualObjects(testStatus, @"status1", @"");
}

- (void) testValidObligationCreation
{
    id mockPost = [OCMockObject mockForClass:[ObligationCreationViewController class]];
    NSString *expectedString = @"userid=1&name=testname&description=testdesc&starttime=2014-07-27 5:30:0.000&endtime=2014-07-27 5:30:0.000&priority=1&status=1&category=1";
    [[mockPost expect] addObligation:expectedString];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyy hh:mm a"];
    NSDate *date = [formatter dateFromString:@"07/27/2014 5:30 AM"];
    
    [ObligationCreationViewController setupAddObligation :@"testname" :@"testdesc" :@"1" :@"1" :@"1" :date :date];
    [mockPost verify];
}

- (void) testObligationCreationNoName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyy hh:mm a"];
    NSDate *date = [formatter dateFromString:@"07/27/2014 5:30 AM"];
    
    NSString *result = [ObligationCreationViewController setupAddObligation :@"" :@"testdesc" :@"1" :@"1" :@"1" :date :date];
    
    XCTAssertEqualObjects(result, @"Name Missing.\n");
}

- (void) testObligationCreationNoPriority
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyy hh:mm a"];
    NSDate *date = [formatter dateFromString:@"07/27/2014 5:30 AM"];
    
    NSString *result = [ObligationCreationViewController setupAddObligation :@"testname" :@"testdesc" :@"" :@"1" :@"1" :date :date];
    
    XCTAssertEqualObjects(result, @"Priority Missing.\n");
}

- (void) testObligationCreationNoStatus
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyy hh:mm a"];
    NSDate *date = [formatter dateFromString:@"07/27/2014 5:30 AM"];
    
    NSString *result = [ObligationCreationViewController setupAddObligation :@"testname" :@"testdesc" :@"1" :@"" :@"1" :date :date];
    
    XCTAssertEqualObjects(result, @"Status Missing.\n");
}

- (void) testObligationCreationNoCategory
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyy hh:mm a"];
    NSDate *date = [formatter dateFromString:@"07/27/2014 5:30 AM"];
    
    NSString *result = [ObligationCreationViewController setupAddObligation :@"testname" :@"testdesc" :@"1" :@"1" :@"" :date :date];
    
    XCTAssertEqualObjects(result, @"Category Missing.\n");
}

@end
