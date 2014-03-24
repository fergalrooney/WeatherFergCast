//
//  WFCTableViewCellFiveDayForecast.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/23/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import "WFCTableViewCellFiveDayForecast.h"
#import "AsyncImageDownloader.h"
#import "UIImage+WFCExtensions.h"

@interface WFCTableViewCellFiveDayForecast ()

@property (nonatomic, weak) IBOutlet UIImageView *weatherIconImageView;
@property (nonatomic, weak) IBOutlet UILabel *weatherDescriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *tempHighLabel;
@property (nonatomic, weak) IBOutlet UILabel *tempLowLabel;
@property (nonatomic, strong) AsyncImageDownloader *imageDownloader;

@end

@implementation WFCTableViewCellFiveDayForecast

@synthesize weatherIconImageView = weatherIconImageView_;
@synthesize weatherDescriptionLabel = weatherDescriptionLabel_;
@synthesize tempHighLabel = tempHighLabel_;
@synthesize tempLowLabel = tempLowLabel_;
@synthesize imageDownloader = imageDownloader_;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    weatherIconImageView_.alpha = 0.0f;
}

- (void) prepareForReuse
{
    weatherIconImageView_.image = nil;
    weatherDescriptionLabel_.text = nil;
    tempLowLabel_.text = nil;
    tempHighLabel_.text = nil;
    imageDownloader_ = nil;
    weatherIconImageView_.alpha = 0.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setWeatherDescription:(NSString *)description
{
    weatherDescriptionLabel_.text = description;
}

- (void) setTempLow:(NSString *)tempLow
{
    tempLowLabel_.text = tempLow;
}

- (void) setTempHigh:(NSString *)tempHigh
{
    tempHighLabel_.text = tempHigh;
}

- (void) updateImageViewWithImageAtUrl:(NSString *)url
{
    self.imageDownloader = [[AsyncImageDownloader alloc] initWithMediaURL:url successBlock:^(UIImage *image) {
        weatherIconImageView_.image = [image blackAndWhiteColorImage];
        
        [UIView animateWithDuration:0.5f animations:^{
            weatherIconImageView_.alpha = 1.0f;
        }];
        
    } failBlock:^(NSError *error) {
        weatherIconImageView_.image = nil;
    }];
    
    [imageDownloader_ startDownload];
}

@end
