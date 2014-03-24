//
//  MKNetworkEngine+WFCExtensions.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "MKNetworkEngine.h"

@interface MKNetworkEngine (WFCExtensions)

+ (MKNetworkEngine *) engineForWorldWeatherOnline;

+ (MKNetworkEngine *) engineForWorldWeatherOnlineCDN;

@end
