//
//  WFCCommandCitySelected.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCCommandInvokeForecastRequest.h"
#import "WFCModelAccessFiveDayForecast.h"
#import "WFCPersistanceCityNameManager.h"

@implementation WFCCommandInvokeForecastRequest

- (void) execute
{
    NSString *cityName = [self.delegate selectedCity];
    [[WFCModelAccessFiveDayForecast sharedInstance] getFivedayForcastForCity:cityName];
}

@end
