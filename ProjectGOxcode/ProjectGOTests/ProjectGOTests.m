//
//  ProjectGoTests.m
//  ProjectGoTests
//
//  Created by Ben Catalan on 2/28/2014.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoadAllObligationsViewController.h"
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

-(void)testGetAllObligations
{
    //id mockGet = [OCMockObject partialMockForObject:[LoadAllObligationsViewController getObligations]];
    id mockGet = [OCMockObject mockForClass:[LoadAllObligationsViewController class]];
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjectsAndKeys:
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
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:jsonDict];
    [[[mockGet stub] andReturn:array] getObligations];
    id thisObj = [LoadAllObligationsViewController getObligations];
    
    NSDictionary *tempDict = [thisObj objectAtIndex:0];
    NSString *test1 = [NSMutableString stringWithFormat:@"%@", [tempDict objectForKeyedSubscript:@"name"]];
    XCTAssertEqualObjects(test1, @"name", @"");
}

@end
