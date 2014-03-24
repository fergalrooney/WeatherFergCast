//
//  WFCPersistanceCityNameManager.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCPersistanceCityNameManager.h"
#import "WFCPersistanceCityNamesModel.h"

@interface WFCPersistanceCityNameManager ()
{
    WFCPersistanceCityNamesModel *cityNamesModel_;
}

/**
 * @brief
 *      Utility method to create our applications documents directory
 *      if needed
 */
- (void) createAppDocumentDirectoryIfNeeded;
- (void) createCityNamesModel;
@end

/**
 * @brief
 *      The archive filename used to persist the city names.
 */
static NSString *kWFCPersistanceCityNameManagerPersistentFileName = @"CityNames.archive";

@implementation WFCPersistanceCityNameManager

/**
 * @brief
 *      The shared instance of WFCPersistanceCityNameManager
 */
static WFCPersistanceCityNameManager *sharedInstance = nil;

#pragma mark - Allocation Overrides
/**
 * @brief
 *      Overriding to ensure true singleton access
 */
+ (instancetype) allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
        }
    });
    
    return sharedInstance;
}

#pragma mark - Initialization

/**
 * @brief
 *      Designated Initializer. Initializes the model array.
 *
 * @return
 *      New instance of WFCPersistanceCityNameManager
 */
- (instancetype) init
{
    self = [super init];
    if (!self) return nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self createAppDocumentDirectoryIfNeeded];
        [self createCityNamesModel];
    });
    
    return self;
}

#pragma mark - Public Method Implementation

/**
 * @brief
 *      Singleton Access to shared instance.
 *
 * @return
 *      Shared instance of WFCPersistanceCityNameManager
 */
+ (WFCPersistanceCityNameManager *) sharedCityNameManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WFCPersistanceCityNameManager alloc] init];
    });
    
    return sharedInstance;
}

/**
 * @brief
 *      Adds a city to the array of city names.
 *
 * @param cityName
 *      The city name the user is searching for.
 */
- (void) addCity:(NSString *)cityName
{
    [cityNamesModel_ insertCityName:cityName];
}

/**
 * @brief
 *      Removes a city from the array of city names at the specified index.
 *
 * @param index
 *      The index of the city name in the array
 */
- (void) removeCityAtIndex:(NSInteger)index
{
    [cityNamesModel_ removeCityNameAtIndex:index];
}

/**
 * @brief
 *      Returns an array of city names currently residing in the model
 *
 * @return
 *      Array of city names.
 */
- (NSArray *) cityNames
{
    return [cityNamesModel_ cityNames];
}

- (void) setSelectedCity:(NSString *)selectedCity
{
    [cityNamesModel_ setSelectedCity:selectedCity];
}

- (NSString *) selectedCity
{
    return cityNamesModel_.selectedCity;
}
- (void) removeAllCities
{
    [cityNamesModel_ removeAllCities];
}

- (void) persistCityNames
{
    [NSKeyedArchiver archiveRootObject:cityNamesModel_ toFile:filePathForArchive(kWFCPersistanceCityNameManagerPersistentFileName)];
}

#pragma mark - Private Method implementation

- (void) createCityNamesModel
{
    cityNamesModel_ = [NSKeyedUnarchiver unarchiveObjectWithFile:filePathForArchive(kWFCPersistanceCityNameManagerPersistentFileName)];
    
    if (!cityNamesModel_) {
        cityNamesModel_ = [WFCPersistanceCityNamesModel new];
    }
}
/**
 * @brief
 *      Utility method to create our applications documents directory
 *      if needed
 */
- (void) createAppDocumentDirectoryIfNeeded
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = YES;
    BOOL directoryExists = [fileManager fileExistsAtPath:documentsPathForApplication() isDirectory:&isDirectory];
    NSError *error = nil;
    
    if (!directoryExists) {
        [fileManager createDirectoryAtPath:documentsPathForApplication() withIntermediateDirectories:NO attributes:nil error:&error];
    }
}

@end
