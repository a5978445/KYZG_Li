//
//  OSCQuestion.m
//  iosapp
//
//  Created by 李萍 on 16/5/24.
//  Copyright © 2016年 oschina. All rights reserved.
//

#import "OSCQuestion.h"
#import <MJExtension.h>

@implementation OSCQuestion
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"Id" : @"id"
             };
}

@end
