//
//  WFCNetworkAccessForecast.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCNetworkAccessForecast.h"
#import "WFCNetworkAccessRequest.h"
#import "WFCBinderFiveDayForecast.h"
#import "WFCModelFiveDayForecast.h"

@implementation WFCNetworkAccessForecast

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
                             responseBlock:(kWFCNetworkAccessForecastResponseBlock)responseBlock
{
    
    WFCNetworkAccessRequest *request = [WFCNetworkAccessRequest new];
    request.restfulServicePath = @"free/v1/weather.ashx";
    request.requestParams = @{@"format" : @"json",
                              @"q" : cityName,
                              @"num_of_days" : @"5",
                              @"key" : @"akzyhnb67yf2fdjz2jjahwxz"};
    request.requestMethod = @"GET";
    
    kWFCNetworkAccessManagerBinderBlock binderBlock = ^WFCModelFiveDayForecast *(NSData *responseData, NSError **binderError){
        WFCBinderFiveDayForecast *binder = [WFCBinderFiveDayForecast new];
        WFCModelFiveDayForecast *model = (WFCModelFiveDayForecast *)[binder modelForWeatherData:responseData parseError:binderError];
        return model;
    };
    
    kWFCBackendManagerResponseBlock blockForSuper = ^(WFCModelDataAccessBase *backendDataModel, NSError *backendError){
        WFCModelFiveDayForecast *model = (WFCModelFiveDayForecast *)backendDataModel;
        responseBlock(model, backendError);
    };
    
    return [super dispatchRequest:request
                      binderBlock:binderBlock
                    responseBlock:blockForSuper];
}

@end
