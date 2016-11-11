//
//  OSCActivityTableViewCell.m
//  iosapp
//
//  Created by Graphic-one on 16/5/24.
//  Copyright © 2016年 oschina. All rights reserved.
//

#import "OSCActivityTableViewCell.h"
#import "Utils.h"
#import <SDWebImage/UIImageView+WebCache.h>

NSString* OSCActivityTableViewCell_IdentifierString = @"OSCActivityTableViewCellReuseIdenfitier";

@interface OSCActivityTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *activityStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityAreaLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumLabel;

@end

@implementation OSCActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _descLabel.textColor = [UIColor newTitleColor];
}

#pragma mark - seeting VM
-(void)setViewModel:(OSCActivities* )viewModel{
    _viewModel = viewModel;
    
    [_activityImageView sd_setImageWithURL:[NSURL URLWithString:viewModel.img]];
    _descLabel.text = viewModel.title;
    
 
    _activityStatusLabel.backgroundColor = [UIColor titleBarColor];
    _activityStatusLabel.text = [self getButtonTitleWithActivityStatus:viewModel.status];
    [self setLabelStatusWithActivityStatus:viewModel.status];
    
   

    _activityAreaLabel.backgroundColor = [UIColor titleBarColor];
    _activityAreaLabel.text = [self getAreaStringWithActivityType:viewModel.type];
    _timeLabel.text = [viewModel.startDate substringToIndex:16];
    _peopleNumLabel.text = [NSString stringWithFormat:@"%ld人参与", (long)viewModel.applyCount];
}

#pragma mark - private method
- (NSString *)getButtonTitleWithActivityStatus:(ActivityStatus)status {
    NSString *statusStr;
    switch (status) {
        case ActivityStatusEnd:
            statusStr = @"  活动结束  ";
            break;
        case ActivityStatusHaveInHand:
            statusStr = @"  正在报名  ";
            break;
        case ActivityStatusClose:
            statusStr = @"  报名截止  ";
            break;
    }
    return statusStr;
}

- (void)setLabelStatusWithActivityStatus:(ActivityStatus)status {
    
    switch (status) {
        case ActivityStatusEnd:
            [self setSelectedBorderWidth:NO];
            break;
        case ActivityStatusHaveInHand:
            [self setSelectedBorderWidth:YES];
            
            break;
        case ActivityStatusClose:
            [self setSelectedBorderWidth:NO];
            break;
    }
}

- (NSString *)getAreaStringWithActivityType:(ActivityType)type {
    NSString *areaStr;
    switch (type) {
        case ActivityTypeOSChinaMeeting:
            areaStr = @" 源创会 ";
            break;
        case ActivityTypeTechnical:
            areaStr = @" 技术交流 ";
            break;
        case ActivityTypeOther:
            areaStr = @" 其他 ";
            break;
        case ActivityTypeBelow:
            areaStr = @" 站外活动 ";
            break;
    }
    return areaStr;
}


- (void)setSelectedBorderWidth:(BOOL)isSelected {
    if (isSelected) {
        _activityStatusLabel.layer.borderWidth = 1.0;
        _activityStatusLabel.layer.borderColor = [UIColor newSectionButtonSelectedColor].CGColor;
        _activityStatusLabel.textColor = [UIColor newSectionButtonSelectedColor];
    } else {
        _activityStatusLabel.layer.borderWidth = 0;
        _activityStatusLabel.textColor = [UIColor colorWithHex:0x9d9d9d];
    }
}

@end
