//
//  WFCDelegateAddCityTable.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCDelegateAddCityTable.h"
#import "WFCPersistanceCityNameManager.h"
#import "WFCCommandInvokeForecastRequest.h"
#import "WFCNavigationManager.h"
#import "WFCModelAccessFiveDayForecast.h"
#import "WFCModelFiveDayForecast.h"

@interface WFCDelegateAddCityTable ()
{
    WFCPersistanceCityNameManager *cityNameManager_;
    WFCCommandInvokeForecastRequest *citySelectedCommand_;
}

@property (nonatomic, strong) IBOutlet WFCCommand *invokeRequestCommand;

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
    [cityNameManager_ setSelectedCity:selectedCityName];
    
    if (![currentCityName isEqualToString:selectedCityName]) {
        [self.invokeRequestCommand execute];
    }
    
    [[WFCNavigationManager sharedNavManager] popToHomeViewController];
}


@end
