//
//  WFCNetworkAccessMKNetwork.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "WFCNetworkAccessMKNetwork.h"
#import "MKNetworkKit.h"
#import "WFCNetworkAccessRequest.h"
#import "WeatherFergCastTestsHelper.h"
#import "WFCModelDataAccessBase.h"

@interface WFCNetworkAccessMKNetworkTests : XCTestCase
{
    MKNKResponseBlock responseBlock;
    MKNKResponseErrorBlock responseErrorBlock;
}

@end

@implementation WFCNetworkAccessMKNetworkTests

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

- (void)testInitialization
{
    id engineMock = [OCMockObject mockForClass:[MKNetworkEngine class]];
    
    WFCNetworkAccessMKNetwork *networkAccessMKNetwork = [[WFCNetworkAccessMKNetwork alloc] initWithMKNetworkEngine:engineMock];
    
    XCTAssertEqual(engineMock, networkAccessMKNetwork.mkNetworkEngine, @"The engine injected to network access layer should equal");
}

- (void) testDispatchRequestInvalidParams
{
    id engineMock = [OCMockObject mockForClass:[MKNetworkEngine class]];
    WFCNetworkAccessMKNetwork *networkAccessMKNetwork = [[WFCNetworkAccessMKNetwork alloc] initWithMKNetworkEngine:engineMock];
    
    BOOL result = [networkAccessMKNetwork dispatchRequest:nil binderBlock:^WFCModelDataAccessBase *(NSData *responseData, NSError **error) {
        return nil;
    } responseBlock:^(WFCModelDataAccessBase *backendDataModel, NSError *backendError) {
        return;
    }];
    
    XCTAssertFalse(result, @"Network access request should not proceed with out valid request param");
    
    WFCNetworkAccessRequest *request = [WFCNetworkAccessRequest new];
    result = [networkAccessMKNetwork dispatchRequest:request binderBlock:nil responseBlock:^(WFCModelDataAccessBase *backendDataModel, NSError *backendError) {
        return;
    }];
    
    XCTAssertFalse(result, @"Network access request should not proceed with out valid request param");
    
    result = [networkAccessMKNetwork dispatchRequest:request binderBlock:^WFCModelDataAccessBase *(NSData *responseData, NSError **error) {
        return nil;
    } responseBlock:nil];
    
    XCTAssertFalse(result, @"Network access request should not proceed with out valid request param");
}

/**
 * @brief
 *      Here we test the binder and response blocks for the dispatch request method
 *      to test if they are executed in the correct order. Highlevel test as this class
 *      is also intended to be subclassed to provide the correct binder block and request
 *      object
 */
- (void) testDispatchRequestValidParams
{
    id engineMock = mockForMkNetworkEngine();
    
    /*
     * Mock the operation and just execute the completion handlers directly.
     */
    id mknetworkOperationMock = mockForMKNetworkOperation(YES, @"SampleWeatherDubln");
    
    /*
     * Return our mocked operation from the engine
     */
    [[[engineMock expect] andReturn:mknetworkOperationMock] operationWithPath:OCMOCK_ANY
                                                                       params:OCMOCK_ANY
                                                                   httpMethod:OCMOCK_ANY];
    /**
     * Simply expect this method to be called.
     */
    [[engineMock expect] enqueueOperation:mknetworkOperationMock];
    
    WFCNetworkAccessMKNetwork *networkAccessMknetwork = [[WFCNetworkAccessMKNetwork alloc] initWithMKNetworkEngine:engineMock];
    
    /*
     * Test that the executing of our binder and response blocks at a high level/
     * WFCNetworkAccessMKNetwork subclasses should provide further tests for
     * actual binders
     */
    WFCNetworkAccessRequest *request = [WFCNetworkAccessRequest new];
    [networkAccessMknetwork dispatchRequest:request binderBlock:^WFCModelDataAccessBase *(NSData *responseData, NSError **error) {
        
        WFCModelDataAccessBase *model = [WFCModelDataAccessBase new];
        XCTAssertNotNil(responseData, @"Response Data should not equal nil");
        XCTAssertNil(*error, @"Error should equal nil");
        return model;
        
    } responseBlock:^(WFCModelDataAccessBase *backendDataModel, NSError *backendError) {
        XCTAssertNotNil(backendDataModel, @"We just returned an empty model object from the binder");
        XCTAssertNil(backendError, @"We just returned nil forom out test binder block.");
    }];
    
    
    [engineMock verify];
}

@end
