//
//  WeatherDataBinder.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/20/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCBinder.h"
#import "WFCBinderFiveDayForecast.h"

@implementation WFCBinder

/**
 * @brief
 *      Simple Factory method to return the concrete binder instance for the
 *      feature being requested.
 *
 * @param feature
 *      The feature currently being requested
 * @return
 *      The Concreate instance of WFCWeatherDataBinder
 */
+ (WFCBinder *) binderForFeature:(kWFCWeatherFeatures)feature
{
    WFCBinder *binder = nil;
    switch (feature) {
        case kWFCWeatherFeatureFiveDayForecast:
            binder = [WFCBinderFiveDayForecast new];
            break;
        default:
            break;
    }
    return binder;
}

/**
 * @brief
 *      Interface to bind the response data for  forecast available at
 *      http://api.worldweatheronline.com/free/v1/weather.ashx
 *
 * @param responseJsonData
 *      The response data returned from server
 * @param parseError
 *      Pointer to an NSError instance to report any possible errors during parsing
 * @return
 *      Concrete instance of WFCBaseDataModel
 */
- (WFCModelDataAccessBase *) modelForWeatherData:(NSData *)responseJsonData
                                parseError:(NSError **)parseError
{
    NSAssert(NO, @"Abstract Method, only intended to be subclassesd");
    
    // Release build will return a generic parser error if abstract class is used.
    *parseError = [NSError errorWithDomain:kWFCWeatherDataBinderErrorDomain
                                     code:kWFCWeatherDataBinderErrorTypeParsingError
                                 userInfo:nil];
    return nil;
}

@end
