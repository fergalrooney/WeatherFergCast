//
//  WFCBinder.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/20/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WFCModelDataAccessBase;

typedef NS_ENUM(NSInteger, kWFCWeatherBinderErrorTypes) {
    kWFCWeatherDataBinderErrorTypeNilArgumentError,
    kWFCWeatherDataBinderErrorTypeParsingError,
};

static NSString * kWFCWeatherDataBinderErrorDomain = @"com.fergalrooney.WeatherFergCast.BinderErrorDomain";

/**
 * @interface WFCBinder
 * @brief
 *      Abstract class dedicated to binding various server responses from the weather
 *      services APIs.
 */
@interface WFCBinder : NSObject

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
+ (WFCBinder *) binderForFeature:(kWFCWeatherFeatures)feature;

/**
 * @brief
 *      Binds the response data for the 5 day weather forecast available at
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
                                parseError:(NSError **)parseError;

@end
