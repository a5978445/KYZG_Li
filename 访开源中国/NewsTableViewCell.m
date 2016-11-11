//
//  NewsCellTableViewCell.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/8.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "NewsTableViewCell.h"

@interface NewsTableViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *bodyLabel;
//@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *commentCount;
@end


@implementation NewsTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
        [self setLayout];
    }
    return self;
}

- (void)initSubviews {
    self.titleLabel = [UILabel new];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    
    self.bodyLabel = [UILabel new];
    self.bodyLabel.numberOfLines = 0;
    self.bodyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.bodyLabel.font = [UIFont systemFontOfSize:13];
    self.bodyLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.bodyLabel];
    
//    self.authorLabel = [UILabel new];
//    self.authorLabel.font = [UIFont systemFontOfSize:12];
//    self.authorLabel.textColor = [UIColor nameColor];
//    [self.contentView addSubview:self.authorLabel];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.timeLabel];
    
    self.commentCount = [UILabel new];
    self.commentCount.font = [UIFont systemFontOfSize:12];
    self.commentCount.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.commentCount];
}

- (void)setLayout {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.left.offset(8);
        make.right.offset(-8);
    }];
    
    [_bodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(8);
        make.left.offset(8);
        make.right.offset(-8);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bodyLabel.mas_bottom).offset(8);
        make.left.offset(8);
     //   make.width.offset(100);
    }];
    
    [_commentCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bodyLabel.mas_bottom).offset(8);
        make.right.offset(-8);
      //  make.bottom.offset(8);
     //   make.width.offset(100);
      //  make.height.offset(12);
    }];
    
    for (UIView *view in [self.contentView subviews]) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
}

- (void)setModel:(NewsTableViewCellModel *)model {
    _model = model;
    _commentCount.attributedText = model.attributedCommentCount;
    _titleLabel.attributedText = model.attributedTittle;
    _timeLabel.attributedText = _model.timeString;
    _bodyLabel.attributedText = _model.bodyString;
}

- (CGFloat)cellHeight {
    [self.contentView layoutIfNeeded];
    CGSize bodyLabelSize = [_bodyLabel sizeThatFits:CGSizeMake(kScreenWidth - 16, MAXFLOAT)];
    CGSize titleLabelSize = [_titleLabel sizeThatFits:CGSizeMake(kScreenWidth - 16, MAXFLOAT)];
    CGSize timeLabelSize = [_timeLabel sizeThatFits:CGSizeMake(kScreenWidth - 16, MAXFLOAT)];

    return 5 + titleLabelSize.height + 8 + bodyLabelSize.height + 8 + timeLabelSize.height + 8;
}

@end
