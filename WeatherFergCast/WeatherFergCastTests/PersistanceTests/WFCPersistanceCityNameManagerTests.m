//
//  WFCPersistanceCityNameManagerTests.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WFCPersistanceCityNameManager.h"

@interface WFCPersistanceCityNameManager (UnitTests)

- (void) createCityNamesModel;

@end

@interface WFCPersistanceCityNameManagerTests : XCTestCase

@end

@implementation WFCPersistanceCityNameManagerTests

- (void)setUp
{
    [super setUp];
    [[WFCPersistanceCityNameManager sharedCityNameManager] removeAllCities];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSingletonAccess
{
    WFCPersistanceCityNameManager *cityNameManager = [WFCPersistanceCityNameManager sharedCityNameManager];
    XCTAssertNotNil(cityNameManager, @"Instance should not be nil");
    
    WFCPersistanceCityNameManager *anotherManager = [WFCPersistanceCityNameManager new];
    XCTAssertEqualObjects(cityNameManager, anotherManager, @"Both references should equal to ensure true singleton access");
}

- (void) testInitialization
{
    WFCPersistanceCityNameManager *cityNameManager = [WFCPersistanceCityNameManager sharedCityNameManager];
    
    NSArray *cityNames = [cityNameManager cityNames];
    
    XCTAssertNotNil(cityNames, @"City names array should not be nil");
    XCTAssertEqual([cityNames count], 0, @"There should be zero city names in the model.");
}

- (void) testAddCityName
{
    WFCPersistanceCityNameManager *cityNameManager = [WFCPersistanceCityNameManager sharedCityNameManager];
    
    [cityNameManager addCity:@"Dublin"];
    XCTAssert([[cityNameManager cityNames] count] == 1, @"There should be zero city names in the model.");
    
    XCTAssertEqualObjects([[cityNameManager cityNames] objectAtIndex:0], @"Dublin", @"First Object should be Dublin");
}

- (void) testAddCityNameDuplicate
{
    WFCPersistanceCityNameManager *cityNameManager = [WFCPersistanceCityNameManager sharedCityNameManager];
    
    [cityNameManager addCity:@"Dublin"];
    XCTAssert([[cityNameManager cityNames] count] == 1, @"There should be zero city names in the model.");
    
    XCTAssertEqualObjects([[cityNameManager cityNames] objectAtIndex:0], @"Dublin", @"First Object should be Dublin");
    
    [cityNameManager addCity:@"Dublin"];
    XCTAssert([[cityNameManager cityNames] count] == 1, @"There should be 1 city name in the model because Dublin alreasy exists");
}

- (void) testRemoveObjectAtIndex
{
    WFCPersistanceCityNameManager *cityNameManager = [WFCPersistanceCityNameManager sharedCityNameManager];
    
    [cityNameManager addCity:@"Dublin"];
    XCTAssert([[cityNameManager cityNames] count] == 1, @"There should be zero city names in the model.");
    XCTAssertEqualObjects([[cityNameManager cityNames] objectAtIndex:0], @"Dublin", @"First Object should be Dublin");
    
    [cityNameManager removeCityAtIndex:0];
    XCTAssert([[cityNameManager cityNames] count] == 0, @"There should be 0 city names in the model because Dublin alreasy exists");
}

- (void) testRemoveObjectAtIndexInvalidIndex
{
    WFCPersistanceCityNameManager *cityNameManager = [WFCPersistanceCityNameManager sharedCityNameManager];
    
    [cityNameManager removeCityAtIndex:0];
    XCTAssert([[cityNameManager cityNames] count] == 0, @"There should be 0 city names in the model because Dublin alreasy exists");
}

- (void) testPersistObject
{
    WFCPersistanceCityNameManager *cityNameManager = [WFCPersistanceCityNameManager sharedCityNameManager];
    
    [cityNameManager addCity:@"Dublin"];
    [cityNameManager persistCityNames];
    [cityNameManager removeAllCities];
    /**
     * Call private method just to just to test persistant functionality
     */
    [cityNameManager createCityNamesModel];
    
    NSArray *cityNames = [cityNameManager cityNames];
    XCTAssertNotNil(cityNames, @"City Names should not be nil.");
    XCTAssertEqual([cityNames count], 1, @"City names count should equal 1");
    XCTAssertEqualObjects(cityNames[0], @"Dublin", @"First object in array should equal Dublin");
    
}

@end
