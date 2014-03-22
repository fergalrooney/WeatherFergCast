//
//  WFCNetworkAccessTests.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WFCNetworkAccess.h"

@interface WFCNetworkAccessTests : XCTestCase

@end

@implementation WFCNetworkAccessTests

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

- (void)testClassIsAbstract
{
    WFCNetworkAccess *networkAccess = [WFCNetworkAccess new];
    XCTAssertThrows([networkAccess dispatchRequest:nil binderBlock:nil responseBlock:nil],
                    @"Abstract method should trow an exception");
}

@end
