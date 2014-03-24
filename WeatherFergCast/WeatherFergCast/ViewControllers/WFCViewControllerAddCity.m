//
//  WFCViewControllerAddCity.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/22/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCViewControllerAddCity.h"
#import "WFCDataSourceAddCityTable.h"
#import "WFCPersistanceCityNameManager.h"
#import "WFCDelegateAddCityTable.h"
#import "WFCNetworkAccessForecast.h"
#import "WFCModelFiveDayForecast.h"
#import "MKNetworkEngine+WFCExtensions.h"
#import "WFCModelAccessFiveDayForecast.h"

@interface WFCViewControllerAddCity ()

@property (weak, nonatomic) IBOutlet UITableView *cityNameTableView;
@property (strong, nonatomic) WFCDataSourceAddCityTable *addCityTableDataSource;
@property (weak, nonatomic) IBOutlet UIButton *addCityEditButton;
@property (strong, nonatomic) WFCDelegateAddCityTable *addCityTableDelegate;
@property (strong, nonatomic) WFCNetworkAccessForecast *networkAccessForecast;

- (IBAction)setTableEditable:(id)sender;

@end

@implementation WFCViewControllerAddCity

@synthesize cityNameTableView = cityNameTableView_;
@synthesize addCityTableDataSource = addCityTableDataSource_;
@synthesize addCityTableDelegate = addCityTableDataDelegate_;
@synthesize addCityEditButton = addCityEditButton_;
@synthesize networkAccessForecast = networkAccessForecast_;

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.addCityTableDataSource = [WFCDataSourceAddCityTable new];
    self.addCityTableDelegate = [WFCDelegateAddCityTable new];
    cityNameTableView_.dataSource = addCityTableDataSource_;
    cityNameTableView_.delegate = addCityTableDataDelegate_;
    cityNameTableView_.backgroundColor = [UIColor blackColor];
    
    [addCityEditButton_ setTitle:@"Edit" forState:UIControlStateNormal];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[WFCModelAccessFiveDayForecast sharedInstance] registerObserver:self];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[WFCModelAccessFiveDayForecast sharedInstance] removeAsObserver:self];
}

#pragma mark - UISearchBarDelegate Protocol Implementation

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    
    NSString *cityName = searchBar.text;
    [[WFCModelAccessFiveDayForecast sharedInstance] getFivedayForcastForCity:cityName];
    
}

#pragma mark - UIButton (Edit Button) Callbacks

- (IBAction)setTableEditable:(id)sender
{
    [addCityEditButton_ setTitle:@"Done" forState:UIControlStateNormal];
    [addCityEditButton_ addTarget:self action:@selector(endEditing:) forControlEvents:UIControlEventTouchUpInside];
    [cityNameTableView_ setEditing:YES animated:YES];
    
}

- (void) endEditing:(id)sender
{
    [cityNameTableView_ setEditing:NO animated:YES];
    [addCityEditButton_ setTitle:@"Edit" forState:UIControlStateNormal];
    [addCityEditButton_ addTarget:self action:@selector(setTableEditable:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - WFCForecastObserver Protocol Implementation

- (void) forecastUpdated
{
    WFCModelFiveDayForecast *forecast = [WFCModelAccessFiveDayForecast sharedInstance].fiveDayForecast;
    
    [[WFCPersistanceCityNameManager sharedCityNameManager] addCity:forecast.responseCityName];
    [cityNameTableView_ reloadData];
}

@end
