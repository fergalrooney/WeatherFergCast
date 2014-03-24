//
//  MKNetworkEngine+WFCExtensions.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "MKNetworkEngine+WFCExtensions.h"

@implementation MKNetworkEngine (WFCExtensions)

+ (MKNetworkEngine *) engineForWorldWeatherOnline
{
    MKNetworkEngine *worldWeatherOnlineEngine = [[MKNetworkEngine alloc] initWithHostName:@"api.worldweatheronline.com" customHeaderFields:nil];
    
    return worldWeatherOnlineEngine;
}

+ (MKNetworkEngine *) engineForWorldWeatherOnlineCDN
{
    MKNetworkEngine *worldWeatherOnlineEngine = [[MKNetworkEngine alloc] initWithHostName:@"cdn.worldweatheronline.net" customHeaderFields:nil];
    
    return worldWeatherOnlineEngine;
}

@end
