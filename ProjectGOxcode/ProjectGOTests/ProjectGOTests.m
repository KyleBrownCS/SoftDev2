//
//  ProjectGoTests.m
//  ProjectGoTests
//
//  Created by Ben Catalan on 2/28/2014.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoadAllObligationsViewController.h"
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

- (void)test_LoadAllObligationsViewController_fillObj
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

@end
