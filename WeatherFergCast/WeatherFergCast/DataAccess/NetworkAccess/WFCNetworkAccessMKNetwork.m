//
//  WFCNetworkAccessMKNetwork.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCNetworkAccessMKNetwork.h"
#import "WFCNetworkAccessRequest.h"

@implementation WFCNetworkAccessMKNetwork

@synthesize mkNetworkEngine = mkNetworkEngine_;
@synthesize mknetworkOperation = mknetworkOperation_;

/**
 * @brief
 *      Forwards initialization to the designated initializer.
 *
 * @return
 *      New instance of WFCNetworkAccessMKNetwork
 */
- (instancetype) init
{
    return [self initWithMKNetworkEngine:nil];
}

/**
 * @brief
 *      Designated Iniitializer. Initializes the network access object with
 *      an instance of the engine.
 *
 * @param engine
 *      An instance of MKNetworkEngine
 * @return
 *      New instance of WFCNetworkAccessMKNetwork
 */
- (instancetype) initWithMKNetworkEngine:(MKNetworkEngine *)engine
{
    self = [super init];
    if (!self) return nil;
    
    mkNetworkEngine_ = engine;
    
    return self;
}

/**
 * @brief
 *      Concrete implementation of the dispatch request method. Encapsulates
 *      the usage of MKNetworkKit
 *
 * @param request
 *      The WFCNetworkAccessRequest object containing the required parameters for
 *      service execution
 * @param binderBlock
 *      The binder block to call upon successful response from the server
 * @param responseBlock
 *      The response block to call with the concrete model object.
 */
- (BOOL) dispatchRequest:(WFCNetworkAccessRequest *)request
             binderBlock:(kWFCNetworkAccessManagerBinderBlock)binderBlock
           responseBlock:(kWFCBackendManagerResponseBlock)responseBlock
{
    if (request == nil || binderBlock == nil ||
        responseBlock == nil || mkNetworkEngine_ == nil) {
        return NO;
    }
    
    mknetworkOperation_ = [mkNetworkEngine_ operationWithPath:request.restfulServicePath
                                                       params:request.requestParams
                                                   httpMethod:request.requestMethod];
    
    [mknetworkOperation_ addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSError *binderError = nil;
        WFCModelDataAccessBase *model = binderBlock([completedOperation responseData], &binderError);
        responseBlock(model, binderError);
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        responseBlock(nil, error);
        
    }];
    
    [mkNetworkEngine_ enqueueOperation:mknetworkOperation_];
    
    return YES;
}

@end
