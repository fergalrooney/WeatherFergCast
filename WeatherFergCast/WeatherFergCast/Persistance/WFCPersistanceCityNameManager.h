//
//  WFCPersistanceCityNameManager.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFCCityNameDelegate.h"
/**
 * @interface WFCPersistanceCityNameManager
 * @brief
 *      Singleton class to manage the lifetime of the city names
 *      the user wants to keep track of.
 */
@interface WFCPersistanceCityNameManager : NSObject <WFCCityNameDelegate>

/**
 * @brief
 *      Singleton Access to shared instance.
 *
 * @return
 *      Shared instance of WFCPersistanceCityNameManager
 */
+ (WFCPersistanceCityNameManager *) sharedCityNameManager;

/**
 * @brief
 *      Adds a city to the array of city names.
 *
 * @param cityName
 *      The city name the user is searching for.
 */
- (void) addCity:(NSString *)cityName;

/**
 * @brief
 *      Removes a city from the array of city names at the specified index.
 *
 * @param index
 *      The index of the city name in the array
 */
- (void) removeCityAtIndex:(NSInteger)index;

/**
 * @brief
 *      Returns an array of city names currently residing in the model
 *
 * @return
 *      Array of city names.
 */
- (NSArray *) cityNames;

- (void) setSelectedCity:(NSString *)selectedCity;

- (NSString *) selectedCity;

- (void) removeAllCities;

/**
 * @brief
 *      Persists the city names to the file system for future use.
 */
- (void) persistCityNames;

@end
