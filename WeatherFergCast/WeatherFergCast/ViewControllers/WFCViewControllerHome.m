//
//  WFCViewControllerHome.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCViewControllerHome.h"
#import "WFCNavigationManager.h"
#import "WFCModelFiveDayForecast.h"
#import "WFCModelAccessFiveDayForecast.h"
#import "WFCModelCurrentConditions.h"
#import "WFCDataSourceHomeTableView.h"
#import "WFCDelegateHomeTableView.h"
#import "WFCPersistanceCityNameManager.h"

@interface WFCViewControllerHome ()

@property (weak, nonatomic) IBOutlet UILabel *currentConditionsDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentConditionsTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *fiveDayForecastTableView;
@property (strong, nonatomic) WFCDataSourceHomeTableView *dataSourceHomeViewTable;
@property (strong, nonatomic) WFCDelegateHomeTableView *delegateHomeViewTable;
- (IBAction)tempUnitChanged:(id)sender;
@end

@implementation WFCViewControllerHome

@synthesize currentConditionsDescriptionLabel = currentConditionsDescriptionLabel_;
@synthesize currentConditionsTemperatureLabel = currentConditionsTemperatureLabel_;
@synthesize cityNameLabel = cityNameLabel_;
@synthesize fiveDayForecastTableView = fiveDayForecastTableView_;
@synthesize dataSourceHomeViewTable = dataSourceHomeViewTable_;
@synthesize delegateHomeViewTable = delegateHomeViewTable_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/**
 * @brief
 *      This view controller will always observe the five day forecast
 *      model access shared object
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [WFCNavigationManager sharedNavManager].homeViewController = self;
    
    self.dataSourceHomeViewTable = [WFCDataSourceHomeTableView new];
    self.delegateHomeViewTable = [WFCDelegateHomeTableView new];
    fiveDayForecastTableView_.dataSource = dataSourceHomeViewTable_;
    fiveDayForecastTableView_.delegate = delegateHomeViewTable_;
    fiveDayForecastTableView_.backgroundColor = [UIColor blackColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.layer.shadowOpacity = 0.5f;
    self.navigationController.navigationBar.layer.shadowColor = [UIColor grayColor].CGColor;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 1);
    self.navigationController.navigationBar.layer.shadowRadius = 3;
    self.navigationController.navigationBar.layer.masksToBounds = NO;
    
    [[WFCModelAccessFiveDayForecast sharedInstance] registerObserver:self];
    
    NSString *selectedCity = [[WFCPersistanceCityNameManager sharedCityNameManager] selectedCity];
    if (selectedCity && [selectedCity length] > 0) {
        [[WFCModelAccessFiveDayForecast sharedInstance] getFivedayForcastForCity:selectedCity];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddCityModalSegue"]) {
        [WFCNavigationManager sharedNavManager].addCityViewController = segue.destinationViewController;
    }
}

#pragma mark - WFCForecastObserver Protocol Implementation

- (void) forecastUpdated
{
    WFCModelFiveDayForecast *forecast = [WFCModelAccessFiveDayForecast sharedInstance].fiveDayForecast;
    cityNameLabel_.text = forecast.responseCityName;
    currentConditionsDescriptionLabel_.text = forecast.currentConditions.weatherDescription;
    
    kWFCTemperatureUnit tempUnit = [WFCNavigationManager sharedNavManager].tempUnit;
    if (tempUnit == kWFCTemperatureUnitC) {
        currentConditionsTemperatureLabel_.text = forecast.currentConditions.tempC;
    } else {
        currentConditionsTemperatureLabel_.text = forecast.currentConditions.tempF;
    }
    
    fiveDayForecastTableView_.hidden = NO;
    [fiveDayForecastTableView_ reloadData];
}

- (IBAction)tempUnitChanged:(id)sender
{
    NSInteger selectedIndex = [(UISegmentedControl *)sender selectedSegmentIndex];
    [WFCNavigationManager sharedNavManager].tempUnit = selectedIndex;
    [self forecastUpdated];
}

@end
