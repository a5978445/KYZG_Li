//
//  QuesAnsTableViewCell.m
//  iosapp
//
//  Created by Graphic-one on 16/5/27.
//  Copyright © 2016年 oschina. All rights reserved.
//

#import "QuesAnsTableViewCell.h"
#import "Utils.h"
#import "OSCQuestion.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface QuesAnsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pageViewNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation QuesAnsTableViewCell

#pragma mark - 解固方法

- (void)awakeFromNib {
    [super awakeFromNib];

    _iconImageView.layer.masksToBounds = true;
    _iconImageView.layer.cornerRadius = 45 * 0.5;
//    _iconImageView.layer.shouldRasterize = true;
//    _iconImageView.layer.rasterizationScale = _iconImageView.layer.contentsScale;
    
    _authorLabel.preferredMaxLayoutWidth = 150;
    self.contentView.backgroundColor = [UIColor newCellColor];
}



#pragma mark - setting VM
-(void)setViewModel:(OSCQuestion *)viewModel{
    _viewModel = viewModel;
    
    _titleLabel.textColor = [UIColor newTitleColor];
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:viewModel.authorPortrait]];
    _titleLabel.text = viewModel.title;
    _descLabel.text = viewModel.body;
    _authorLabel.text = viewModel.author;
    
    _pageViewNumLabel.text = [NSString stringWithFormat:@"%ld",(long)viewModel.viewCount];
    _commentLabel.text = [NSString stringWithFormat:@"%ld",(long)viewModel.commentCount];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate* date = [formatter dateFromString:viewModel.pubDate];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[Utils attributedTimeString:date]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor newAssistTextColor] range:NSMakeRange(0, attributedString.length)];
    [_timeLabel setAttributedText:attributedString];
}

@end
