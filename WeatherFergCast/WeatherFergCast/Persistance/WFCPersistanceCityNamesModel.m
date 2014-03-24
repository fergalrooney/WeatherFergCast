//
//  WFCPersistanceCityNamesModel.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCPersistanceCityNamesModel.h"

static NSString * kWFCPersistanceCityNamesModelArrayKey = @"kWFCPersistanceCityNamesModelArrayKey";
static NSString * kWFCPersistanceCityNamesModelSelectedCityKey = @"kWFCPersistanceCityNamesModelSelectedCityKey";

@interface WFCPersistanceCityNamesModel ()
{
    NSMutableArray *cityNames_;
}

@end

@implementation WFCPersistanceCityNamesModel

@synthesize selectedCity = selectedCity_;

- (instancetype) init
{
    return [self initWithCoder:nil];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) return nil;
    
    cityNames_ = [aDecoder decodeObjectForKey:kWFCPersistanceCityNamesModelArrayKey];
    selectedCity_ = [aDecoder decodeObjectForKey:kWFCPersistanceCityNamesModelSelectedCityKey];
    if (!cityNames_) {
        cityNames_ = [[NSMutableArray alloc] initWithCapacity:0];
        selectedCity_ = nil;
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:cityNames_ forKey:kWFCPersistanceCityNamesModelArrayKey];
    [aCoder encodeObject:selectedCity_ forKey:kWFCPersistanceCityNamesModelSelectedCityKey];
}

/**
 * @brief
 *      Adds a city to the array of city names.
 *
 * @param cityName
 *      The city name the user is searching for.
 */
- (void) insertCityName:(NSString *)cityName
{
    if (![cityNames_ containsObject:cityName] && [cityName length] > 0) {
        [cityNames_ addObject:cityName];
    }
}

/**
 * @brief
 *      Removes a city from the array of city names at the specified index.
 *
 * @param index
 *      The index of the city name in the array
 */
- (void) removeCityNameAtIndex:(NSInteger)index
{
    if (index < [cityNames_ count]) {
        [cityNames_ removeObjectAtIndex:index];
    }
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
    return [cityNames_ copy];
}

- (void) removeAllCities
{
    [cityNames_ removeAllObjects];
}

@end
