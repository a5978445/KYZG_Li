//
//  MyHeaderView.h
//  访开源中国
//
//  Created by 李腾芳 on 16/10/25.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyHeaderViewDelegate <NSObject>

- (void)login;
- (void)showQRCode;
- (void)config;
@end

@interface MyHeaderView : UIView

@property(weak,nonatomic) id<MyHeaderViewDelegate> delegate;
@property(retain,nonatomic) OSCUser *user;

@end
