//
//  WFCCommandInvokeForecastRequest.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFCCommand.h"
#import "WFCCityNameDelegate.h"

@interface WFCCommandInvokeForecastRequest : WFCCommand

@property (nonatomic, weak) IBOutlet id<WFCCityNameDelegate> delegate;

- (void) execute;

@end
