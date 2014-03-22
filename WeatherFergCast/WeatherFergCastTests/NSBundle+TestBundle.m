//
//  NSBundle+TestBundle.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "NSBundle+TestBundle.h"

@implementation NSBundle (TestBundle)

+ (NSBundle *) testBundle
{
    return [NSBundle bundleWithIdentifier:@"com.fergalrooney.WeatherFergCastTests"];
}

@end
