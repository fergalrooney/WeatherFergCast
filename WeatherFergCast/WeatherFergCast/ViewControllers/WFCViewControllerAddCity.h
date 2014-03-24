//
//  WFCViewControllerAddCity.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFCDelegateSetCityName.h"
#import "WFCForecastObserver.h"

@interface WFCViewControllerAddCity : UIViewController <UISearchBarDelegate, WFCForecastObserver>

@end
