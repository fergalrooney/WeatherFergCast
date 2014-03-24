//
//  WFCModelAccessFiveDayForecast.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFCForecastObserver.h"

@class WFCModelFiveDayForecast;

@interface WFCModelAccessFiveDayForecast : NSObject

@property (nonatomic, strong, readonly) WFCModelFiveDayForecast *fiveDayForecast;

+ (WFCModelAccessFiveDayForecast *) sharedInstance;

- (void) getFivedayForcastForCity:(NSString *)city;

- (void) registerObserver:(id<WFCForecastObserver>)forecastObserver;

- (void) removeAsObserver:(id<WFCForecastObserver>)forecastObserver;

@end
