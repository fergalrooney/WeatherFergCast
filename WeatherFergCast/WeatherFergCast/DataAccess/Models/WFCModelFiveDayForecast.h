//
//  WFCModelFiveDayForecast.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/20/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCModelDataAccessBase.h"

@class WFCModelCurrentConditions;
/**
 * @interfave WFCModelFiveDayForecast
 * @brief
 *      Concreate Model Object for the 5 day forecast information. It represents both 
 *      a current conditions model as well as an array of weather objects for the 
 *      actual five day forcast
 */
@interface WFCModelFiveDayForecast : WFCModelDataAccessBase

@property (nonatomic, copy) NSString *responseCityName;
/**
 * @property currentConditions
 * @brief
 *      The current conditions forecast model.
 */
@property (nonatomic, strong) WFCModelCurrentConditions *currentConditions;
/**
 * @property fiveDayForecastArray
 * @brief
 *      Five day forecast array. Holds instance of WFCModelSingleDayForecast
 */
@property (nonatomic, copy) NSArray *fiveDayForecastArray;

@end
