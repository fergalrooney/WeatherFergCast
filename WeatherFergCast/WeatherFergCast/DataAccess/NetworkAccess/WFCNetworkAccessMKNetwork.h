//
//  WFCNetworkAccessMKNetwork.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCNetworkAccess.h"
#import "MKNetworkKit.h"

@interface WFCNetworkAccessMKNetwork : WFCNetworkAccess

/**
 * @property mkNetworkEngine
 * @brief
 *      Readonly instance of mkNetwworkEngine.
 *
 */
@property (nonatomic, strong, readonly) MKNetworkEngine *mkNetworkEngine;

/**
 * @property mkNetworkOperation
 * @brief
 *      Readonly instance of the MKNetwork operation in progress.
 *
 */
@property (nonatomic, strong, readonly) MKNetworkOperation *mknetworkOperation;

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
- (instancetype) initWithMKNetworkEngine:(MKNetworkEngine *)engine;

@end
