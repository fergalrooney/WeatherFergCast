//
//  WFCTableViewCellFiveDayForecast.h
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFCTableViewCellFiveDayForecast : UITableViewCell

- (void) setWeatherDescription:(NSString *)description;
- (void) setTempLow:(NSString *)tempLow;
- (void) setTempHigh:(NSString *)tempHigh;
- (void) updateImageViewWithImageAtUrl:(NSString *)url;

@end
