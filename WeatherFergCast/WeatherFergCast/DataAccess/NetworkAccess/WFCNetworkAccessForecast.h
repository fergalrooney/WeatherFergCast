//
//  WFCNetworkAccessForecast.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCNetworkAccessMKNetwork.h"

@class WFCModelFiveDayForecast;

typedef void (^kWFCNetworkAccessForecastResponseBlock)(WFCModelFiveDayForecast *, NSError *);

@interface WFCNetworkAccessForecast : WFCNetworkAccessMKNetwork

/**
 * @brief
 *      Begins the request for the five day forecast for the city
 *      in context.
 *
 * @param cityName
 *      The city name to get the five day forecast for.
 * @param responseBlock
 *      The response block upon completion of the request
 */
- (BOOL) requestFiveDayForecastForCityName:(NSString *)cityName
                             responseBlock:(kWFCNetworkAccessForecastResponseBlock)responseBlock;

@end
