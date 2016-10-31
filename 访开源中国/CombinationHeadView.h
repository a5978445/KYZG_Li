//
//  CombinationHeadView.h
//  访开源中国
//
//  Created by 李腾芳 on 16/10/31.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyHeaderView.h"

@interface CombinationHeadView : UIView
@property(assign,nonatomic) BOOL isLogin;

- (void)setDelegate:(id<MyHeaderViewDelegate>)delegate;
- (CGFloat)suggestHeight;
@end
