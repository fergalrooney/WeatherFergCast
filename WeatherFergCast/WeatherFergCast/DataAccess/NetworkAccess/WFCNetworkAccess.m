//
//  WFCNetworkAccess.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCNetworkAccess.h"

@implementation WFCNetworkAccess

/**
 * @brief
 *      Dispatch a request to the server with the given request object. Abstract
 *      and only intended to be subclassed.
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
    NSAssert(NO, @"Abstract method, only intended to be subclassed");
    return NO;
}

@end
