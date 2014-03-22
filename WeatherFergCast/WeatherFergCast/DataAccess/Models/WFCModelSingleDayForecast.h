//
//  WFCModelSingleDayForecast.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/21/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCModelWeatherForecast.h"

/**
 * @interface WFCModelSingleDayForecast
 * @brief 
 *      Model object for a single day weather forecast
 */
@interface WFCModelSingleDayForecast : WFCModelWeatherForecast

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *tempMaxC;
@property (nonatomic, copy) NSString *tempMaxF;
@property (nonatomic, copy) NSString *tempMinC;
@property (nonatomic, copy) NSString *tempMinF;
@property (nonatomic, copy) NSString *windDirection;

@end
