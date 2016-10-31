//
//  UserInfo.m
//  访开源中国
//
//  Created by 李腾芳 on 16/10/31.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "UserInfo.h"

static UserInfo *shareUserInfo;

@implementation UserInfo

+ (UserInfo *)myUserInfo {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareUserInfo = [[UserInfo alloc]init];
    });
    return shareUserInfo;
}

@end
