//
//  WFCPersistanceCityNamesModel.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFCPersistanceCityNamesModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString *selectedCity;

- (void) insertCityName:(NSString *)cityName;
- (void) removeCityNameAtIndex:(NSInteger)index;
- (NSArray *) cityNames;
- (void) removeAllCities;

@end
