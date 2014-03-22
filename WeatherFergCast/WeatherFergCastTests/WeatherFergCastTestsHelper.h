//
//  WeatherFergCastTestsHelper.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "NSBundle+TestBundle.h"
#import <OCMock/OCMock.h>
#import "WFCNetworkAccess.h"

static NSData* responseDataForTestBundleFileName(NSString *fileName, NSString *type)
{
    NSString *filePath = [[NSBundle testBundle] pathForResource:fileName ofType:type];
    return [[NSData alloc] initWithContentsOfFile:filePath];
}

static id mockForMkNetworkEngine()
{
    MKNetworkEngine *realEngine = [MKNetworkEngine new];
    id engineMock = [OCMockObject partialMockForObject:realEngine];
    return engineMock;
}

static MKNKResponseBlock responseBlock = nil;
static MKNKResponseErrorBlock responseErrorBlock = nil;

static id mockForMKNetworkOperation(BOOL isSuccessBlock, NSString *sampleFileName)
{
    id mknetworkOperationMock = [OCMockObject mockForClass:[MKNetworkOperation class]];
    [[[mknetworkOperationMock expect] andReturn:responseDataForTestBundleFileName(sampleFileName,@"json")] responseData];
    
    void (^invocationBlock)(NSInvocation *);
    if(isSuccessBlock){
        invocationBlock = ^(NSInvocation *invocation){
            [invocation getArgument:&responseBlock atIndex:2];
            
            responseBlock(mknetworkOperationMock);
        };
    } else {
        invocationBlock = ^(NSInvocation *invocation){
            [invocation getArgument:&responseErrorBlock atIndex:3];
            
            NSError *error = [NSError errorWithDomain:@"TestErrorDomain" code:0 userInfo:nil];
            responseErrorBlock(nil, error);
        };
    }
    
    [[[mknetworkOperationMock expect] andDo:invocationBlock] addCompletionHandler:OCMOCK_ANY
                                                                     errorHandler:OCMOCK_ANY];
    
    return mknetworkOperationMock;
}
