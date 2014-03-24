//
//  WFCDelegateSetCityName.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFCCommand.h"

@class WFCCommandCitySelected;

@protocol WFCDelegateSetCityName <NSObject>

@required

- (NSString *) cityNameSelected;

@end
