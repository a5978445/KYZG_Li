//
//  ActivityBannerScrollView.h
//  访开源中国
//
//  Created by 李腾芳 on 16/11/10.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSCBanner.h"

typedef void(^BannerScrollViewClickBlock)(NSInteger tag);
@interface ActivityBannerScrollView : UIView

@property(copy,nonatomic) BannerScrollViewClickBlock block;
@property(strong,nonatomic) NSArray<OSCBanner *> *banners;

- (void)cancelTimer;
- (void)restartTimer;
@end
