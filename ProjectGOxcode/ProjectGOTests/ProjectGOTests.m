//
//  ProjectGoTests.m
//  ProjectGoTests
//
//  Created by Ben Catalan on 2/28/2014.
//  Copyright (c) 2014 com.ProjectGO. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoadAllObligationsViewController.h"
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

//- (void)testExample
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}

- (void)test1
{
    NSError *error = nil;
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
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonData options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray *myobj = [LoadAllObligationsViewController fillObj:jsonObjects];
    
    NSDictionary *tmpDict = [myobj objectAtIndex:0];
    NSMutableString *text;
    text = [NSMutableString stringWithFormat:@"%@", [tmpDict objectForKeyedSubscript:@"name"]];

    XCTAssertEqualObjects(text, @"name", @"");
    
}

@end
