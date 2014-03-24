//
//  WFCDataSourceHomeTableView.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCDataSourceHomeTableView.h"
#import "WFCModelAccessFiveDayForecast.h"
#import "WFCModelFiveDayForecast.h"
#import "WFCTableViewCellFiveDayForecast.h"
#import "WFCModelSingleDayForecast.h"
#import "WFCNavigationManager.h"

@interface WFCDataSourceHomeTableView ()
{
    WFCModelAccessFiveDayForecast *modelAccessFiveDayForecast_;
}

@end

@implementation WFCDataSourceHomeTableView

- (instancetype) init
{
    self = [super init];
    if (!self) return nil;
    
    modelAccessFiveDayForecast_ = [WFCModelAccessFiveDayForecast sharedInstance];
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [modelAccessFiveDayForecast_.fiveDayForecast.fiveDayForecastArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellReuseIdentifier = @"FiveDayForecastCell";
    WFCTableViewCellFiveDayForecast *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
    
    WFCModelSingleDayForecast *singleDayForecast = modelAccessFiveDayForecast_.fiveDayForecast.fiveDayForecastArray[indexPath.row];
    
    kWFCTemperatureUnit tempUnit = [WFCNavigationManager sharedNavManager].tempUnit;
    if (tempUnit == kWFCTemperatureUnitC) {
        [cell setTempLow:singleDayForecast.tempMinC];
        [cell setTempHigh:singleDayForecast.tempMaxC];
    } else {
        [cell setTempLow:singleDayForecast.tempMinF];
        [cell setTempHigh:singleDayForecast.tempMaxF];
    }
    
    [cell setWeatherDescription:singleDayForecast.weatherDescription];
    [cell updateImageViewWithImageAtUrl:singleDayForecast.weatherIconUrl];
    
    return cell;
}
@end
