//
//  MyHeaderView.m
//  访开源中国
//
//  Created by 李腾芳 on 16/10/25.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "MyHeaderView.h"
#import "QuartzCanvasView.h"
#import <SDWebImage/UIImageView+WebCache.h>



#define userPortrait_width 80
//#define genderImageView_width 20
//#define bottomButton_height 60
//#define bottom_subButton_height 30
//#define setupButton_width 24

#define view_userPortrait 63

@implementation MyHeaderView {
    UIImageView *_headimageView;
    UILabel *_userNameLabel;
    UILabel *_userInfoLabel;
    UILabel *_integralLabel;
    
    UIButton *_setUpButton;
    UIButton *_codeButton;
    
    QuartzCanvasView *_drawView;
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        [self addLayouts];
    }
    return self;
}

#pragma mark - public method
- (void)setUser:(OSCUser *)user {
    _user = user;
    if (user == nil) {
        _headimageView.image = [UIImage imageNamed:@"default-portrait"];
        _userNameLabel.text = @"点击头像登陆";
        _userInfoLabel.text = @"该用户还没有填写描述...";
        _integralLabel.text = @"积分：0";
    } else {
        if (_user.portrait != nil) {
            [_headimageView sd_setImageWithURL:[NSURL URLWithString:_user.portrait]];
        } else {
            _headimageView.image = [UIImage imageNamed:@"default-portrait"];
        }
        _userNameLabel.text = _user.name;
        _userInfoLabel.text = _user.desc;
        _integralLabel.text = [NSString stringWithFormat:@"积分：%d",_user.aStatisticsInfo.score ];
    }
}


#pragma mark - private method
- (void)addSubViews {
   
    [self addSetButton];
    
    [self addCodeButton];
    
    [self addHeadImageView];
   
    [self addUserNameLabel];
   
    [self addUserInfoLabel];
    
    [self addintegralLabel];
//
    [self addDrawView];
       
//    _genderImageView = [UIImageView new];
//    _genderImageView.contentMode = UIViewContentModeScaleAspectFit;
//    _genderImageView.hidden = YES;
//    [self addSubview:_genderImageView];

}

- (void)addSetButton {
    _setUpButton = [[UIButton alloc]init];
    [_setUpButton setImage:[UIImage imageNamed:@"btn_my_setting"] forState:UIControlStateNormal];
    [_setUpButton addTarget:self action:@selector(setAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_setUpButton];
}

- (void)addCodeButton {
    _codeButton = [[UIButton alloc]init];
    [_codeButton setImage:[UIImage imageNamed:@"btn_qrcode"] forState:UIControlStateNormal];
    [_codeButton addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_codeButton];
}

- (void)addHeadImageView {
    _headimageView = [[UIImageView alloc]init];
    // _headimageView.backgroundColor = [UIColor redColor];
    _headimageView.contentMode = UIViewContentModeScaleAspectFit;
    _headimageView.layer.cornerRadius = 25;
    _headimageView.layer.masksToBounds = YES;
    _headimageView.image = [UIImage imageNamed:@"default-portrait"];
    
    _headimageView.userInteractionEnabled = YES;
    [_headimageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clcikImage:)]];
    
    [self addSubview:_headimageView];
}

- (void)addUserNameLabel {
    _userNameLabel = [[UILabel alloc]init];
    _userNameLabel.font = [UIFont systemFontOfSize:20];
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    _userNameLabel.numberOfLines = 1;
    _userNameLabel.textColor = [UIColor colorWithHex:0xFFFFFF];
    _userNameLabel.text = @"点击头像登陆";
    [self addSubview:_userNameLabel];
}

- (void)addUserInfoLabel {
    _userInfoLabel = [[UILabel alloc]init];
    _userInfoLabel.font = [UIFont systemFontOfSize:13];
    _userInfoLabel.textAlignment = NSTextAlignmentCenter;
    _userInfoLabel.numberOfLines = 3;
    _userInfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _userInfoLabel.textColor = [UIColor colorWithHex:0xFFFFFF];
    _userInfoLabel.text = @"该用户还没有填写描述...";
    _userInfoLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 60 ;
    [self addSubview:_userInfoLabel];
}

- (void)addintegralLabel {
    _integralLabel = [[UILabel alloc]init];
    _integralLabel = [UILabel new];
    _integralLabel.font = [UIFont systemFontOfSize:13];
    _integralLabel.textAlignment = NSTextAlignmentCenter;
    _integralLabel.numberOfLines = 1;
    _integralLabel.textColor = [UIColor colorWithHex:0xFFFFFF];
    _integralLabel.text = @"积分：0";
    [self addSubview:_integralLabel];
}

- (void)addDrawView {
    CGFloat viewHeight = CGRectGetHeight(self.frame);
    
    _drawView = [[QuartzCanvasView alloc]initWithFrame:(CGRect){{0,0},self.bounds.size}];
    _drawView.minimumRoundRadius = userPortrait_width * 0.5 + 30;
    _drawView.openRandomness = NO;
    _drawView.duration = 25;
    _drawView.bgColor = [UIColor colorWithHex:0x24CF5F];
    _drawView.strokeColor = [UIColor colorWithHex:0x6FDB94];
    _drawView.offestCenter = (OffestCenter){0, view_userPortrait + userPortrait_width * 0.5 - viewHeight * 0.5};
    [self addSubview:_drawView];
    [self sendSubviewToBack:_drawView];
}

- (void)addLayouts {
    [_setUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(16);
        make.top.equalTo(self.mas_top).with.offset(36);
        
    }];
    
    [_codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-16);
        make.top.equalTo(self.mas_top).with.offset(36);
        
    }];
    
    [_headimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(50, 50));
        make.centerX.offset(0);
        make.top.offset(73);
    }];
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(_headimageView.mas_bottom).offset(10);
    }];
    
    [_userInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
      //  make.left.offset(20);
      //  make.right.offset(-20);
        make.top.equalTo(_userNameLabel.mas_bottom).offset(10);
    }];
    
    [_integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(_userInfoLabel.mas_bottom).offset(10);
    }];
    
    [_drawView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

#pragma mark tapGestureRecognizer
- (void)clcikImage:(UITapGestureRecognizer *)gestureRecognizer {
    [_delegate login];
}

- (void)setAction:(UIButton *)button {
    [_delegate config];
}

- (void)codeAction:(UIButton *)button {
    [_delegate showQRCode];
}

@end
