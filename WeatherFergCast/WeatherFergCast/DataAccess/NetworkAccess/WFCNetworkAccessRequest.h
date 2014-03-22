//
//  WFCNetworkAccessRequest.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @interface WFCNetworkAccessRequest
 * @brief 
 *      Simple object to define the request parameters
 */
@interface WFCNetworkAccessRequest : NSObject

/**
 * @property restfulServicePath
 * @brief
 *      The path of the service without the host appended.
 */
@property (nonatomic, copy) NSString *restfulServicePath;
/**
 * @property requestParams
 * @brief
 *      The request parameters if any, nil of none.
 */
@property (nonatomic, copy) NSDictionary *requestParams;
/**
 * @property requestType
 * @brief
 *      The request method for the network request
 */
@property (nonatomic, copy) NSString *requestMethod;
@end
