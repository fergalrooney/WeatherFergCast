//
//  WFCModelCurrentConditions.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/21/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFCModelWeatherForecast.h"

/**
 * @interface WFCModelCurrentConditions
 * @brief
 *      Model object for the representation of the current conditions information
 *      received from the 5 day forcast service.
 */
@interface WFCModelCurrentConditions : WFCModelWeatherForecast

@property (nonatomic, copy) NSString *cloudCover;
@property (nonatomic, copy) NSString *humidity;
@property (nonatomic, copy) NSString *observationTime;
@property (nonatomic, copy) NSString *pressure;
@property (nonatomic, copy) NSString *tempC;
@property (nonatomic, copy) NSString *tempF;
@property (nonatomic, copy) NSString *visibility;

@end
