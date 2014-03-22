//
//  WFCModelWeatherForecast.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/21/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @interface WFCModelWeatherForecast
 * @brief
 *      Base model object for weather information. This model is shared between
 *      current conditions and a sindle day weather forecast.
 */
@interface WFCModelWeatherForecast : NSObject

@property (nonatomic, copy) NSString *precipMM;
@property (nonatomic, copy) NSString *weatherCode;
@property (nonatomic, copy) NSString *weatherDescription;
@property (nonatomic, copy) NSString *weatherIconUrl;
@property (nonatomic, copy) NSString *windDir16Point;
@property (nonatomic, copy) NSString *windDirDegree;
@property (nonatomic, copy) NSString *windSpeedKilometersPerHour;
@property (nonatomic, copy) NSString *windSpeedMilesPerHour;

@end
