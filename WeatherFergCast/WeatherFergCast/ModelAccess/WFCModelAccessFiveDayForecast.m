//
//  WFCModelAccessFiveDayForecast.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCModelAccessFiveDayForecast.h"
#import "WFCNetworkAccessForecast.h"
#import "MKNetworkEngine+WFCExtensions.h"
#import "WFCPersistanceCityNameManager.h"
#import "WFCModelFiveDayForecast.h"

@interface WFCModelAccessFiveDayForecast ()
{
    NSMutableArray *forecastObservers_;
}

@property (nonatomic, strong) WFCNetworkAccessForecast *networkAccessForecast;

- (void) notifyObservers;

@end

@implementation WFCModelAccessFiveDayForecast

@synthesize networkAccessForecast = networkAccessForecast_;
@synthesize fiveDayForecast = fiveDayForecast_;

SINGELTON_SETUP(WFCModelAccessFiveDayForecast)

- (instancetype) init
{
    self = [super init];
    if (!self) return nil;
    
    forecastObservers_ = [[NSMutableArray alloc] initWithCapacity:0];
    self.networkAccessForecast = [[WFCNetworkAccessForecast alloc]
                                    initWithMKNetworkEngine:[MKNetworkEngine engineForWorldWeatherOnline]];
    
    return self;
}

- (void) getFivedayForcastForCity:(NSString *)city
{
    __weak typeof (self) weakSelf = self;
    kWFCNetworkAccessForecastResponseBlock responseBlock = ^(WFCModelFiveDayForecast *model, NSError *error) {
        if (!error) {
            [[WFCPersistanceCityNameManager sharedCityNameManager] addCity:model.responseCityName];
            fiveDayForecast_ = model;
            [weakSelf notifyObservers];
        }
    };
    
    [networkAccessForecast_ requestFiveDayForecastForCityName:city
                                                responseBlock:responseBlock];
}

- (void) registerObserver:(id<WFCForecastObserver>)forecastObserver
{
    if (![forecastObservers_ containsObject:forecastObserver]) {
        [forecastObservers_ addObject:forecastObserver];
    }
}

- (void) removeAsObserver:(id<WFCForecastObserver>)forecastObserver
{
    if ([forecastObservers_ containsObject:forecastObserver]) {
        [forecastObservers_ removeObject:forecastObserver];
    }
}

- (void) notifyObservers
{
    for (id<WFCForecastObserver> observer in forecastObservers_) {
        [observer forecastUpdated];
    }
}
@end
