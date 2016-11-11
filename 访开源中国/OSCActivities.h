//
//  OSCActivities.h
//  iosapp
//
//  Created by Graphic-one on 16/5/24.
//  Copyright © 2016年 oschina. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM (NSUInteger, ActivityStatus){
    ActivityStatusEnd = 1,// 活动已经结束
    ActivityStatusHaveInHand,//活动进行中
    ActivityStatusClose//活动报名已经截止
};

typedef NS_ENUM (NSUInteger, ActivityType){
    ActivityTypeOSChinaMeeting = 1,//源创会
    ActivityTypeTechnical,//技术交流
    ActivityTypeOther,// 其他
    ActivityTypeBelow//站外活动(当为站外活动的时候，href为站外活动报名地址)
};

typedef NS_ENUM(NSUInteger, ApplyStatus) {
    ApplyStatusUnSignUp = -1,//未报名
    ApplyStatusAudited = 0 ,//审核中
    ApplyStatusDetermined = 1 ,//已经确认
    ApplyStatusAttended,//已经出席
    ApplyStatusCanceled,//已取消
    ApplyStatusRejected,//已拒绝
};

@interface OSCActivities : NSObject

@property (nonatomic,assign) NSInteger id;

@property (nonatomic,strong) NSString* title;

@property (nonatomic,strong) NSString* body;

@property (nonatomic,strong) NSString* img;

@property (nonatomic,strong) NSString* startDate;

@property (nonatomic,strong) NSString* endDate;

@property (nonatomic,strong) NSString* pubDate;

@property (nonatomic,strong) NSString* href;

@property (nonatomic,assign) NSInteger applyCount;

@property (nonatomic,assign) ActivityStatus status;

@property (nonatomic,assign) ActivityType type;

/* 新增活动详情节点 */
@property (nonatomic, assign) ApplyStatus applyStatus;

@property (nonatomic, copy)   NSString *author;

@property (nonatomic, assign) NSInteger authorId;

@property (nonatomic, copy)   NSString *authorPortrait;

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, assign) NSInteger viewCount;

@property (nonatomic, copy)   NSString *spot;//活动详细地址

@property (nonatomic, copy)   NSString *location;//活动位置坐标

@property (nonatomic, copy)   NSString *city;

@property (nonatomic, copy)   NSString *costDesc;//活动花费描述

@property (nonatomic, assign) BOOL favorite;

@property (nonatomic, strong) NSDictionary *remark;

@end
