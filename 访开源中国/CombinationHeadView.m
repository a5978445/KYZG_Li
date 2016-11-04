//
//  CombinationHeadView.m
//  访开源中国
//
//  Created by 李腾芳 on 16/10/31.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "CombinationHeadView.h"
#import "UserInfoButtons.h"

static const CGFloat buttonsHeight = 64.0f;

@implementation CombinationHeadView {
    MyHeaderView *_headView;
    UserInfoButtons *_buttons;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _headView = [[MyHeaderView alloc]initWithFrame:frame];
        CGRect buttonFrame = frame;
        buttonFrame.size.height = buttonsHeight;
        _buttons = [[UserInfoButtons alloc]initWithFrame:buttonFrame
                                                titleDic:@[@{kTitle:@"动弹",kSubTitle:@"0"},
                                                                             @{kTitle:@"收藏",kSubTitle:@"0"},
                                                                             @{kTitle:@"关注",kSubTitle:@"0"},
                                                                             @{kTitle:@"粉丝",kSubTitle:@"0"}]];
        [self addSubview:_headView];
        [self addSubview:_buttons];
        
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(0);
            make.right.offset(0);
            make.bottom.equalTo(_buttons.mas_top);
        }];
        
        [_buttons mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(0);
            make.right.offset(0);
            make.bottom.offset(0);
            make.height.offset(buttonsHeight);
        }];
    }
    return self;
}

- (void)setDelegate:(id<MyHeaderViewDelegate>)delegate {
    _headView.delegate = delegate;
}



- (void)setUser:(OSCUser *)user {
    [_buttons mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(user == nil ? 0 : buttonsHeight);
    }];
    
    _user = user;
    _headView.user = user;
    
    [_buttons updateTitles:@[@{kTitle:@"动弹",kSubTitle:[NSString stringWithFormat:@"%d",_user.aStatisticsInfo.tweet]},
                            @{kTitle:@"收藏",kSubTitle:[NSString stringWithFormat:@"%d",_user.aStatisticsInfo.collect]},
                            @{kTitle:@"关注",kSubTitle:[NSString stringWithFormat:@"%d",_user.aStatisticsInfo.follow]},
                             @{kTitle:@"粉丝",kSubTitle:[NSString stringWithFormat:@"%d",_user.aStatisticsInfo.fans]}]];
}

- (CGFloat)suggestHeight {
    return _user ? 280 + 64 : 280;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
