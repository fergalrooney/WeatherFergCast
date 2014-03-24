//
//  WFCCoordinatingController.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCNavigationManager.h"

@interface WFCNavigationManager ()

@end

@implementation WFCNavigationManager

@synthesize homeViewController = homeViewController_;
@synthesize addCityViewController = addCityViewController_;

static WFCNavigationManager *sharedInstance = nil;

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

+ (WFCNavigationManager *) sharedNavManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WFCNavigationManager alloc] init];
    });
    
    return sharedInstance;
}

- (void) popToHomeViewController
{
    [homeViewController_ dismissViewControllerAnimated:YES completion:nil];
    self.addCityViewController = nil;
}

@end
