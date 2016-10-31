//
//  UserInfoButtons.h
//  访开源中国
//
//  Created by 李腾芳 on 16/10/27.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 {@"title":@"关注"，@“subTitle”:@"1234"};
 */
#define kTitle @"title"
#define kSubTitle @"subTitle"

@interface UserInfoButtons : UIView

//- (instancetype)initWithFrame:(CGRect)frame title:(NSArray<NSString *>*)titles;
- (instancetype)initWithFrame:(CGRect)frame titleDic:(NSArray<NSDictionary *>*)titles;
@end
