//
//  UserInfo.m
//  访开源中国
//
//  Created by 李腾芳 on 16/10/31.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "UserInfo.h"

static UserInfo *shareUserInfo;

@implementation UserInfo {
    OSCUser *_user;
}

+ (UserInfo *)myUserInfo {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareUserInfo = [[UserInfo alloc]init];
    });

    return shareUserInfo;
}

- (void)setUser:(OSCUser *)user {
    _user = user;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
//    OSCUser *test = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    assert([_user isEqual:test]);
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:USER_INFO];
}

- (OSCUser *)user {
    if (_user == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USER_INFO];
        if (data) {
            _user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }
    return _user;
}

- (void)clearUser {
    _user = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_INFO];
}


@end
