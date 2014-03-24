//
//  WFCCommandCitySelected.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCCommandCitySelected.h"
#import "WFCViewControllerHome.h"
#import "WFCNavigationManager.h"

@implementation WFCCommandCitySelected

@synthesize delegate = delegate_;

- (void) execute
{
    NSString *cityName = [delegate_ cityNameSelected];
    WFCViewControllerHome *homeViewController = [WFCNavigationManager sharedNavManager].homeViewController;
}

@end
