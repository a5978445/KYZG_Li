//
//  ActivityView.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/10.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "ActivityView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ActivityView()
@property(strong,nonatomic) UIImageView *imageView;
@property(strong,nonatomic) UILabel *titleLable;
@property(strong,nonatomic) UILabel *detailLable;

@end

@implementation ActivityView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
       // self.backgroundColor = [UIColor lightGrayColor];
        self.backgroundColor = RGB(222, 221, 222);
    }
    return self;
}

- (void)addSubviews{
    
    _imageView = [[UIImageView alloc] init];
    [self addSubview:_imageView];
    
    _titleLable = [[UILabel alloc] init];
    _titleLable.font = [UIFont systemFontOfSize:18];
    _titleLable.numberOfLines = 0;
    _titleLable.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLable.textColor = [UIColor colorWithHex:0xffffff];
    [self addSubview:_titleLable];
    
    _detailLable = [[UILabel alloc] init];
    _detailLable.font = [UIFont systemFontOfSize:14];
    _detailLable.numberOfLines = 0;
    _detailLable.lineBreakMode = NSLineBreakByWordWrapping;
    _detailLable.textColor = [UIColor colorWithHex:0xffffff];
    [self addSubview:_detailLable];
    
    [self setLayout];
}

- (void)setLayout {
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(16);
        make.height.offset(180);
        make.left.offset(16);
        make.width.offset(120);
    }];
    
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.mas_right).offset(16);
        make.right.offset(-16);
        make.top.offset(16);
    }];
    
    [_detailLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.mas_right).offset(16);
        make.right.offset(-16);
        make.top.equalTo(_titleLable.mas_bottom).offset(16);
        make.bottom.equalTo(_imageView.mas_bottom);
    }];
    
}

- (void)setBanner:(OSCBanner *)banner {

    _banner = banner;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:banner.img]];
    _titleLable.text = banner.name;
    _detailLable.text = banner.detail;
}

@end
