//
//  OSCUser.h
//  iosapp
//
//  Created by 李腾芳 on 16/10/31.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MoreUserInfo,StatisticsInfo;
@interface OSCUser : NSObject

@property (nonatomic, copy) NSString *desc;//描述
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, assign) NSInteger userID;
@property (nonatomic,strong) MoreUserInfo *moreInfo;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSString *portrait;
@property (nonatomic, assign) NSInteger relation;
@property (nonatomic,strong) StatisticsInfo *aStatisticsInfo;


@property (nonatomic, strong) NSDate *latestOnlineTime;
//@property (nonatomic, readwrite, copy) NSString *pinyin; //拼音
//@property (nonatomic, readwrite, copy) NSString *pinyinFirst; //拼音首字母

- (instancetype)initWithLoginDic:(NSDictionary *)dic;
- (instancetype)initWithUserInfoDic:(NSDictionary *)userInfoDic;

@end

@interface MoreUserInfo : NSObject
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *expertise;
@property (nonatomic, copy) NSString *joinDate;
@property (nonatomic, copy) NSString *platform;
@end

@interface StatisticsInfo : NSObject
@property (nonatomic, assign) int answer;
@property (nonatomic, assign) int blog;
@property (nonatomic, assign) int collect;
@property (nonatomic, assign) int discuss;
@property (nonatomic, assign) int fans;
@property (nonatomic, assign) int follow;
@property (nonatomic, assign) int score;
@property (nonatomic, assign) int tweet;
@end

