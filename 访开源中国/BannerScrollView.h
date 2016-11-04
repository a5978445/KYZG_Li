//
//  BannerScrollView.h
//  访开源中国
//
//  Created by 李腾芳 on 16/11/4.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BannerScrollViewClickBlock)(NSInteger tag);
@interface BannerScrollView : UIView

@property(copy,nonatomic) BannerScrollViewClickBlock block;

- (void)setIamgeURLs:(NSArray<NSString *> *)URLs;
- (void)cancelTimer;
- (void)restartTimer;
@end
