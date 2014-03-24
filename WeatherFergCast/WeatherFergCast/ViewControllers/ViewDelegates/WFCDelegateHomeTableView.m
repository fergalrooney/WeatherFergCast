//
//  WFCDelegateHomeTableView.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCDelegateHomeTableView.h"

@implementation WFCDelegateHomeTableView

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WFCHomeTableHeaderView" owner:nil options:nil] objectAtIndex:0];
}

@end
