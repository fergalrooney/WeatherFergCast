//
//  WFCCoordinatingController.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFCViewControllerHome.h"
#import "WFCViewControllerAddCity.h"

@interface WFCNavigationManager : NSObject

@property (nonatomic, assign) kWFCTemperatureUnit tempUnit;
@property (nonatomic, strong) WFCViewControllerHome *homeViewController;
@property (nonatomic, strong) WFCViewControllerAddCity *addCityViewController;

+ (WFCNavigationManager *) sharedNavManager;

- (void) popToHomeViewController;

@end
