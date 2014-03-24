//
//  WFCDelegateAddCityTable.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCDelegateAddCityTable.h"
#import "WFCPersistanceCityNameManager.h"
#import "WFCCommandCitySelected.h"
#import "WFCNavigationManager.h"
#import "WFCModelAccessFiveDayForecast.h"
#import "WFCModelFiveDayForecast.h"

@interface WFCDelegateAddCityTable ()
{
    WFCPersistanceCityNameManager *cityNameManager_;
    WFCCommandCitySelected *citySelectedCommand_;
}
@end

@implementation WFCDelegateAddCityTable

- (instancetype) init
{
    self = [super init];
    if (!self) return nil;
    
    cityNameManager_ = [WFCPersistanceCityNameManager sharedCityNameManager];

    return self;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *currentCityName = [WFCModelAccessFiveDayForecast sharedInstance].fiveDayForecast.responseCityName;
    NSString *selectedCityName = [cityNameManager_ cityNames][indexPath.row];
    if (![currentCityName isEqualToString:selectedCityName]) {
        [[WFCModelAccessFiveDayForecast sharedInstance] getFivedayForcastForCity:selectedCityName];
    }
    
    [cityNameManager_ setSelectedCity:selectedCityName];
    
    [[WFCNavigationManager sharedNavManager] popToHomeViewController];
}


@end
