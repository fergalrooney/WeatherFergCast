//
//  WFCWeatherConstants.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/20/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#define SINGELTON_SETUP(className) \
static className *sharedInstance = nil; \
\
+ (instancetype) allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        if (sharedInstance == nil) { \
            sharedInstance = [super allocWithZone:zone]; \
        } \
    }); \
    \
    return sharedInstance; \
} \
\
+ (className *) sharedInstance \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        sharedInstance = [[className alloc] init]; \
    }); \
    \
    return sharedInstance; \
} \
/**
 * @brief
 *      Returns the applications root document directory
 */
static NSString* documentsPathForApplication()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *directotyPath = [documentsDirectory stringByAppendingPathComponent:@"/WeatherFergCast"];
    return directotyPath;
}

static NSString* filePathForArchive(NSString *fileName)
{
    NSString *directoryPath = documentsPathForApplication();
    NSString *filePath = [directoryPath stringByAppendingPathComponent:fileName];
    return filePath;
}

typedef NS_ENUM(NSInteger, kWFCWeatherFeatures) {
    kWFCWeatherFeatureFiveDayForecast
};

typedef NS_ENUM(NSInteger, kWFCTemperatureUnit){
    kWFCTemperatureUnitC,
    kWFCTemperatureUnitF
};