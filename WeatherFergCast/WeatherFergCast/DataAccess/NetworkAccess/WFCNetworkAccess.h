//
//  WFCNetworkAccess.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WFCModelDataAccessBase;
@class WFCNetworkAccessRequest;

/**
 * @brief
 *      Base block type for all consumers to register a a binder block to parse the
 *      response data from the server.
 */
typedef WFCModelDataAccessBase * (^kWFCNetworkAccessManagerBinderBlock)(NSData *, NSError **);
/**
 * @brief
 *      Base block type for all consumers to register a block to listen for a response.
 */
typedef void (^kWFCBackendManagerResponseBlock)(WFCModelDataAccessBase *, NSError *);

/**
 * @interface WFCNetworkAccess
 * @brief
 *      Abstract superclass intended to be subclassed by any concrete implementation
 *      of the network access layer. This gives us the flexibility to change to any
 *      third party APIs / NSURLSession that comes with iOS7 depending on needs.
 */
@interface WFCNetworkAccess : NSObject

/**
 * @brief
 *      Dispatch a request to the server with the given request object. Abstract
 *      and only intended to be subclassed.
 *
 * @param request
 *      The NSURLRequest object containing the required query
 */
- (BOOL) dispatchRequest:(WFCNetworkAccessRequest *)request
             binderBlock:(kWFCNetworkAccessManagerBinderBlock)binderBlock
           responseBlock:(kWFCBackendManagerResponseBlock)responseBlock;

@end
