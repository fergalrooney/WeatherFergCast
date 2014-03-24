//
//  WFCForecastObserver.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WFCForecastObserver <NSObject>

- (void) forecastUpdated;

@end
