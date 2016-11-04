//
//  UserInfo.h
//  访开源中国
//
//  Created by 李腾芳 on 16/10/31.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSCUser.h"
@interface UserInfo : NSObject

+(UserInfo *)myUserInfo;

//@property(retain,nonatomic) OSCUser *user;

@property(strong,nonatomic) OSCUser *user;
- (void)clearUser;
@end
