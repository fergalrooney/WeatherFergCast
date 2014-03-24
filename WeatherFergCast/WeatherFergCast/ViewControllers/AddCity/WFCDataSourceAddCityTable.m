//
//  WFCDataSourceAddCityTable.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCDataSourceAddCityTable.h"
#import "WFCPersistanceCityNameManager.h"

@interface WFCDataSourceAddCityTable ()
{
    WFCPersistanceCityNameManager *cityNameManager_;
}

@end

@implementation WFCDataSourceAddCityTable

- (instancetype) init
{
    self = [super init];
    if (!self) return nil;
    
    cityNameManager_ = [WFCPersistanceCityNameManager sharedCityNameManager];
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[cityNameManager_ cityNames] count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"CityNameCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor blackColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        backgroundView.backgroundColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = backgroundView;
    }
    cell.textLabel.text = [cityNameManager_ cityNames][indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [cityNameManager_ removeCityAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

@end
