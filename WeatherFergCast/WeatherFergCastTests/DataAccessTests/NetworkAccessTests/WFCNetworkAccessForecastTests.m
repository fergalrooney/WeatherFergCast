//
//  WFCNetworkAccessForecastTests.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "WFCNetworkAccessForecast.h"
#import "WeatherFergCastTestsHelper.h"
#import "WFCModelFiveDayForecast.h"
#import "WFCBinder.h"

@interface WFCNetworkAccessForecastTests : XCTestCase

@end

@implementation WFCNetworkAccessForecastTests

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

- (void)testGetFiveDayForecastSuccess
{
    id engineMock = mockForMkNetworkEngine();
    WFCNetworkAccessForecast *networkAccessForecast = [[WFCNetworkAccessForecast alloc] initWithMKNetworkEngine:engineMock];
    
    id networkOperationMock = mockForMKNetworkOperation(YES, @"SampleWeatherDubln");
    
    /*
     * Return our mocked operation from the engine
     */
    [[[engineMock expect] andReturn:networkOperationMock] operationWithPath:OCMOCK_ANY
                                                                       params:OCMOCK_ANY
                                                                   httpMethod:OCMOCK_ANY];
    
    [[engineMock expect] enqueueOperation:networkOperationMock];
    
    kWFCNetworkAccessForecastResponseBlock responseBlock = ^(WFCModelFiveDayForecast *model, NSError *error){
        XCTAssertNotNil(model, @"Concrete Model should not be nil");
        XCTAssertNotNil(model.currentConditions, @"Current Conditions should not be nil");
        XCTAssertNotNil(model.fiveDayForecastArray, @"Current Conditions should not be nil");
        
        XCTAssert([model.fiveDayForecastArray count] == 5, @"There should be 5 objects for 5 day forecast");
        
    };
    
    [networkAccessForecast requestFiveDayForecastForCityName:@"Dublin"
                                               responseBlock:responseBlock];
    
    [engineMock verify];
}

- (void) testGetFiveDayForecastNetworkError
{
    id engineMock = mockForMkNetworkEngine();
    WFCNetworkAccessForecast *networkAccessForecast = [[WFCNetworkAccessForecast alloc] initWithMKNetworkEngine:engineMock];
    
    /*
     * Invoke the error block by specifiy NO to the helper method
     */
    id networkOperationMock = mockForMKNetworkOperation(NO, @"SampleWeatherDubln");
    
    /*
     * Return our mocked operation from the engine
     */
    [[[engineMock expect] andReturn:networkOperationMock] operationWithPath:OCMOCK_ANY
                                                                     params:OCMOCK_ANY
                                                                 httpMethod:OCMOCK_ANY];
    
    [[engineMock expect] enqueueOperation:networkOperationMock];
    
    kWFCNetworkAccessForecastResponseBlock responseBlock = ^(WFCModelFiveDayForecast *model, NSError *error){
        XCTAssertNil(model, @"Concrete Model should be nil when error occurs");
        XCTAssertNotNil(error, @"Error object should not be nil when network error occur");
    };
    
    [networkAccessForecast requestFiveDayForecastForCityName:@"Dublin"
                                               responseBlock:responseBlock];
    
    [engineMock verify];
}

- (void) testGetFiveDayForecastBinderError
{
    id engineMock = mockForMkNetworkEngine();
    WFCNetworkAccessForecast *networkAccessForecast = [[WFCNetworkAccessForecast alloc] initWithMKNetworkEngine:engineMock];
    
    /*
     * Invoke the error block by specifiy NO to the helper method
     */
    id networkOperationMock = mockForMKNetworkOperation(YES, @"SampleBadJson");
    
    /*
     * Return our mocked operation from the engine
     */
    [[[engineMock expect] andReturn:networkOperationMock] operationWithPath:OCMOCK_ANY
                                                                     params:OCMOCK_ANY
                                                                 httpMethod:OCMOCK_ANY];
    
    [[engineMock expect] enqueueOperation:networkOperationMock];
    
    kWFCNetworkAccessForecastResponseBlock responseBlock = ^(WFCModelFiveDayForecast *model, NSError *error){
        XCTAssertNil(model, @"Concrete Model should be nil when error occurs");
        XCTAssertNotNil(error, @"Error object should not be nil when network error occur");
        XCTAssertEqual(error.code, kWFCWeatherDataBinderErrorTypeParsingError, @"Error code should equal parsing error");
    };
    
    [networkAccessForecast requestFiveDayForecastForCityName:@"Dublin"
                                               responseBlock:responseBlock];
    
    [engineMock verify];
}

@end
