//
//  WFCFiveDayForecastBinder.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/20/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCBinderFiveDayForecast.h"
#import "WFCModelFiveDayForecast.h"
#import "WFCModelCurrentConditions.h"
#import "WFCModelSingleDayForecast.h"

/**
 *      Key constants for the data elements in the JSON response
 */
static NSString *kWFCBinderFiveDayForecastQueryKey = @"query";
static NSString *kWFCBinderFiveDayForecastCloudCoverKey = @"cloudcover";
static NSString *kWFCBinderFiveDayForecastHumidityKey = @"humidity";
static NSString *kWFCBinderFiveDayForecastObservationTimeKey = @"observation_time";
static NSString *kWFCBinderFiveDayForecastPrecipMMKey = @"precipMM";
static NSString *kWFCBinderFiveDayForecastTempCKey = @"temp_C";
static NSString *kWFCBinderFiveDayForecastTempFKey = @"temp_F";
static NSString *kWFCBinderFiveDayForecastPressureKey = @"pressure";
static NSString *kWFCBinderFiveDayForecastVisibilityKey = @"visibility";
static NSString *kWFCBinderFiveDayForecastWeatherCodeKey = @"weatherCode";
static NSString *kWFCBinderFiveDayForecastWeatherDescKey = @"weatherDesc";
static NSString *kWFCBinderFiveDayForecastWeatherIconUrlKey = @"weatherIconUrl";
static NSString *kWFCBinderFiveDayForecastWinfDir16PointKey = @"winddir16Point";
static NSString *kWFCBinderFiveDayForecastWinDirDegreeKey = @"winddirDegree";
static NSString *kWFCBinderFiveDayForecastWindSpeedKmphKey = @"windspeedKmph";
static NSString *kWFCBinderFiveDayForecastWindSpeedMphKey = @"windspeedMiles";
static NSString *kWFCBinderFiveDayForecastDateKey = @"date";
static NSString *kWFCBinderFiveDayForecastTempMaxCKey = @"tempMaxC";
static NSString *kWFCBinderFiveDayForecastTempMaXFKey = @"tempMaxF";
static NSString *kWFCBinderFiveDayForecastTempMinCKey = @"tempMinC";
static NSString *kWFCBinderFiveDayForecastTempMinFKey = @"tempMinF";
static NSString *kWFCBinderFiveDayForecastWindDirectionKey = @"winddirection";

/**
 *      NSArray index constants for the weird JSON format that include
 *      unnessary arrays in the response.
 */
static NSInteger kWFCBinderFiveDayForecastCurrentConditionsIndex = 0;
static NSInteger kWFCBinderFiveDayForecastWeatherIconIndex = 0;
static NSInteger kWFCBinderFiveDayForecastWeatherDescriptionIndex = 0;
static NSInteger kWFCBinderFiveDayForecastWeatherRequestInfoIndex = 0;

@interface WFCBinderFiveDayForecast ()

/**
 * @brief
 *      Creates the concrete model object for the 5 day forecast.
 *
 * @param jsonDictonary
 *      The NSDictionary representing the entire response data form the server
 * @return
 *      Concrete instance of WFCModelFiveDayForecast
 */
- (WFCModelFiveDayForecast *) modelFromJsonDictionary:(NSDictionary *)jsonDictionary;

@end

@implementation WFCBinderFiveDayForecast

/**
 * @brief
 *      Concretate implementation for the binder. Binds the response data
 *      for five day forecast available at http://api.worldweatheronline.com/free/v1/weather.ashx
 *
 * @param responseJsonData
 *      The response data returned from server
 * @param parseError
 *      Pointer to an NSError instance to report any possible errors during parsing
 * @return
 *      Concrete instance of WFCFiveDayForecastModel
 */
- (WFCModelDataAccessBase *) modelForWeatherData:(NSData *)responseJsonData
                                parseError:(NSError **)parseError
{
    WFCModelFiveDayForecast *model = nil;
    NSError *jsonSerializationError = nil;
    
    if (!responseJsonData) { // Nil data from server response
        
        *parseError = [NSError errorWithDomain:kWFCWeatherDataBinderErrorDomain
                                         code:kWFCWeatherDataBinderErrorTypeNilArgumentError
                                     userInfo:nil];
    } else {
        NSDictionary *jsonResponseDictionary = [NSJSONSerialization JSONObjectWithData:responseJsonData
                                                                               options:NSJSONReadingAllowFragments
                                                                                 error:&jsonSerializationError];
        if (jsonSerializationError) {
            *parseError = [NSError errorWithDomain:kWFCWeatherDataBinderErrorDomain
                                             code:kWFCWeatherDataBinderErrorTypeParsingError
                                         userInfo:nil];
        } else {
            model = [self modelFromJsonDictionary:jsonResponseDictionary];
        }
    }
    return model;
}

/**
 * @brief
 *      Creates the concrete model object for the 5 day forecast.
 *
 * @param jsonDictonary
 *      The NSDictionary representing the entire response data form the server
 * @return
 *      Concrete instance of WFCModelFiveDayForecast
 */
- (WFCModelFiveDayForecast *) modelFromJsonDictionary:(NSDictionary *)jsonDictionary
{
    WFCModelFiveDayForecast *model = [WFCModelFiveDayForecast new];;
    WFCModelCurrentConditions *currentConditionsModel = [WFCModelCurrentConditions new];
    
    NSArray *currentConditionsArray = [jsonDictionary valueForKeyPath:@"data.current_condition"];
    NSArray *requestInfoArray = [jsonDictionary valueForKeyPath:@"data.request"];
    
    if (requestInfoArray && [requestInfoArray count] > kWFCBinderFiveDayForecastWeatherRequestInfoIndex) {
        NSDictionary *requestInfoDict = requestInfoArray[kWFCBinderFiveDayForecastWeatherRequestInfoIndex];
        model.responseCityName = requestInfoDict[kWFCBinderFiveDayForecastQueryKey];
    }
    /*
     * Current Conditions is suprisingly an array, but always only one object. Need to check
     * if object is an array before we can proceed
     */
    BOOL proceedToParseCurrentConditions =
        [currentConditionsArray isKindOfClass:[NSArray class]] && [currentConditionsArray count] == 1;
    
    if (proceedToParseCurrentConditions) {
        
        NSDictionary *currentConditions = currentConditionsArray[kWFCBinderFiveDayForecastCurrentConditionsIndex];
        
        currentConditionsModel.cloudCover = currentConditions[kWFCBinderFiveDayForecastCloudCoverKey];
        currentConditionsModel.humidity = currentConditions[kWFCBinderFiveDayForecastHumidityKey];
        currentConditionsModel.observationTime = currentConditions[kWFCBinderFiveDayForecastObservationTimeKey];
        currentConditionsModel.precipMM = currentConditions[kWFCBinderFiveDayForecastPrecipMMKey];
        currentConditionsModel.pressure = currentConditions[kWFCBinderFiveDayForecastPressureKey];
        currentConditionsModel.tempC = currentConditions[kWFCBinderFiveDayForecastTempCKey];
        currentConditionsModel.tempF = currentConditions[kWFCBinderFiveDayForecastTempFKey];
        currentConditionsModel.visibility = currentConditions[kWFCBinderFiveDayForecastVisibilityKey];
        currentConditionsModel.weatherCode = currentConditions[kWFCBinderFiveDayForecastWeatherCodeKey];
        /*
         * Again array checking here for weird json format
         */
        NSArray *weatherDesc = currentConditions[kWFCBinderFiveDayForecastWeatherDescKey];
        currentConditionsModel.weatherDescription =
            [weatherDesc count] > kWFCBinderFiveDayForecastWeatherDescriptionIndex ? weatherDesc[kWFCBinderFiveDayForecastWeatherDescriptionIndex][@"value"] : nil;
        /*
         * Again array checking here for weird json format
         */
        NSArray *weatherIconUrl = currentConditions[kWFCBinderFiveDayForecastWeatherIconUrlKey];
        currentConditionsModel.weatherIconUrl =
            [weatherIconUrl count] > kWFCBinderFiveDayForecastWeatherIconIndex ?  weatherIconUrl[kWFCBinderFiveDayForecastWeatherIconIndex][@"value"] : nil;
        
        currentConditionsModel.windDir16Point = currentConditions[kWFCBinderFiveDayForecastWinfDir16PointKey];
        currentConditionsModel.windDirDegree = currentConditions[kWFCBinderFiveDayForecastWinDirDegreeKey];
        currentConditionsModel.windSpeedKilometersPerHour = currentConditions[kWFCBinderFiveDayForecastWindSpeedKmphKey];
        currentConditionsModel.windSpeedMilesPerHour = currentConditions[kWFCBinderFiveDayForecastWindSpeedMphKey];
        
        model.currentConditions = currentConditionsModel;
    }
    
    NSArray *fiveDayForecastArray = [jsonDictionary valueForKeyPath:@"data.weather"];
    
    /*
     * Only proceed if the weather object is an array and has more than zero items
     */
    BOOL proceedToParseFiveDay =
        [fiveDayForecastArray isKindOfClass:[NSArray class]] && [fiveDayForecastArray count] > 0;
    
    if (proceedToParseFiveDay) {
        
        __block NSMutableArray *fiveDayForecast = [NSMutableArray arrayWithCapacity:5];
        __block WFCModelSingleDayForecast *singleDayForecast = nil;
        
        [fiveDayForecastArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                obj = (NSDictionary *)obj;
                singleDayForecast = [WFCModelSingleDayForecast new];
                singleDayForecast.date = obj[kWFCBinderFiveDayForecastDateKey];
                singleDayForecast.precipMM = obj[kWFCBinderFiveDayForecastPrecipMMKey];
                singleDayForecast.tempMaxC = obj[kWFCBinderFiveDayForecastTempMaxCKey];
                singleDayForecast.tempMaxF = obj[kWFCBinderFiveDayForecastTempMaXFKey];
                singleDayForecast.tempMinC = obj[kWFCBinderFiveDayForecastTempMinCKey];
                singleDayForecast.tempMinF = obj[kWFCBinderFiveDayForecastTempMinFKey];
                singleDayForecast.weatherCode = obj[kWFCBinderFiveDayForecastWeatherCodeKey];
                /*
                 * Again array checking here for weird json format
                 */
                NSArray *weatherDesc = obj[kWFCBinderFiveDayForecastWeatherDescKey];
                singleDayForecast.weatherDescription =
                    [weatherDesc count] > kWFCBinderFiveDayForecastWeatherDescriptionIndex ? weatherDesc[kWFCBinderFiveDayForecastWeatherDescriptionIndex][@"value"] : nil;
                /*
                 * Again array checking here for weird json format
                 */
                NSArray *weatherIconUrl = obj[kWFCBinderFiveDayForecastWeatherIconUrlKey];
                singleDayForecast.weatherIconUrl =
                    [weatherIconUrl count] > kWFCBinderFiveDayForecastWeatherIconIndex ? weatherIconUrl[kWFCBinderFiveDayForecastWeatherIconIndex][@"value"] : nil;
                
                singleDayForecast.windDir16Point = obj[kWFCBinderFiveDayForecastWinfDir16PointKey];
                singleDayForecast.windDirDegree = obj[kWFCBinderFiveDayForecastWinDirDegreeKey];
                singleDayForecast.windSpeedKilometersPerHour = obj[kWFCBinderFiveDayForecastWindSpeedKmphKey];
                singleDayForecast.windSpeedMilesPerHour = obj[kWFCBinderFiveDayForecastWindSpeedMphKey];
                singleDayForecast.windDirection = obj[kWFCBinderFiveDayForecastWindDirectionKey];
                
                [fiveDayForecast addObject:singleDayForecast];
            }
        }];
        
        if (!model) {
            model = [WFCModelFiveDayForecast new];
        }
        model.fiveDayForecastArray = fiveDayForecast;
    }
    return model;
}

@end
