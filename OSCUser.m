//
//  OSCUser.m
//  iosapp
//
//  Created by 李腾芳 on 16/10/31.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "OSCUser.h"
#import <DateTools.h>

@interface MoreUserInfo()<NSCoding>

@end

@implementation MoreUserInfo
- (void)encodeWithCoder:(NSCoder *)aCoder {
    //    @property (nonatomic, copy) NSString *city;
    //    @property (nonatomic, copy) NSString *expertise;
    //    @property (nonatomic, copy) NSString *joinDate;
    //    @property (nonatomic, copy) NSString *platform;
    [aCoder encodeObject:_city forKey:@"city"];
    [aCoder encodeObject:_expertise forKey:@"expertise"];
    [aCoder encodeObject:_joinDate forKey:@"joinDate"];
    [aCoder encodeObject:_platform forKey:@"platform"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _city = [aDecoder decodeObjectForKey:@"city"];
        _expertise = [aDecoder decodeObjectForKey:@"expertise"];
        _joinDate = [aDecoder decodeObjectForKey:@"joinDate"];
        _platform = [aDecoder decodeObjectForKey:@"platform"];
    }
    return self;
}

- (BOOL)isEqual:(MoreUserInfo *)object {
    if ([self class] == [object class]) {
        if (object == self) {
            return YES;
        } else {
     
            return ([self.city isEqual:object.city] || self.city == object.city)
            &&([self.expertise isEqual:object.expertise] || self.expertise == object.expertise)

            &&([self.joinDate isEqual:object.joinDate] || self.joinDate == object.joinDate)
            &&([self.platform isEqual:object.platform] || self.platform == object.platform);
          
        }
    }
    
    return NO;
}

@end

@interface StatisticsInfo()<NSCoding>

@end

@implementation StatisticsInfo
- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeInt:_answer forKey:@"answer"];
    [aCoder encodeInt:_blog forKey:@"blog"];
    [aCoder encodeInt:_collect forKey:@"collect"];
    [aCoder encodeInt:_discuss forKey:@"discuss"];
    [aCoder encodeInt:_fans forKey:@"fans"];
    [aCoder encodeInt:_follow forKey:@"follow"];
    [aCoder encodeInt:_score forKey:@"score"];
    [aCoder encodeInt:_tweet forKey:@"tweet"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _answer = [aDecoder decodeIntForKey:@"answer"];
        _blog = [aDecoder decodeIntForKey:@"blog"];
        _collect = [aDecoder decodeIntForKey:@"collect"];
        _discuss = [aDecoder decodeIntForKey:@"discuss"];
        _fans = [aDecoder decodeIntForKey:@"fans"];
        _follow = [aDecoder decodeIntForKey:@"follow"];
        _score = [aDecoder decodeIntForKey:@"score"];
        _tweet = [aDecoder decodeIntForKey:@"tweet"];
    }
    return self;
}

- (BOOL)isEqual:(StatisticsInfo *)object {
    if ([self class] == [object class]) {
        if (object == self) {
            return YES;
        } else {
        
           return self.answer == object.answer
            && self.blog == object.blog
            && self.collect == object.collect
            && self.discuss == object.discuss
            && self.fans == object.fans
            && self.follow == object.follow
            && self.score == object.score
            && self.tweet == object.tweet;
            
        }
    }
    
    return NO;
}

@end


@interface OSCUser()<NSCoding>

@end

@implementation OSCUser


//oschina =     {
//    notice =         {
//        atmeCount = 0;
//        msgCount = 0;
//        newFansCount = 0;
//        newLikeCount = 0;
//        reviewCount = 0;
//    };
//    result =         {
//        errorCode = 1;
//        errorMessage = "\U767b\U5f55\U6210\U529f";
//    };
//    user =         {
//        fans = 0;
//        favoritecount = 0;
//        followers = 0;
//        gender = 1;
//        location = "\U6e56\U5357 \U5cb3\U9633";
//        name = "\U7231\U5403\U80e1\U841d\U535c";
//        portrait = "https://static.oschina.net/uploads/user/794/1588585_100.jpg?t=1397353598000";
//        score = 0;
//        uid = 1588585;
//    };
//};
//}

- (instancetype)initWithLoginDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        NSDictionary *userDic = dic[@"oschina"][@"user"];
        
        _gender = userDic[@"gender"];
        _name = userDic[@"name"];
        _portrait = userDic[@"portrait"];
        
        _userID = ((NSNumber *)userDic[@"uid"]).intValue;
        
        StatisticsInfo *info = [StatisticsInfo new];
        info.fans = ((NSNumber *)userDic[@"fans"]).intValue;
        info.collect = ((NSNumber *)userDic[@"favoritecount"]).intValue;
        info.follow = ((NSNumber *)userDic[@"followers"]).intValue;
        info.score = ((NSNumber *)userDic[@"score"]).intValue;
        _aStatisticsInfo = info;
        
        _moreInfo = [MoreUserInfo new];
        _moreInfo.city = userDic[@"location"];
    }
    return self;
}

/*
 {
 code = 1;
 message = SUCCESS;
 result =     {
 desc = "\U8fd9\U4e2a\U4eba\U5f88\U61d2\Uff0c\U5565\U4e5f\U6ca1\U5199";
 gender = 1;
 id = 1588585;
 more =         {
 city = "\U5cb3\U9633";
 expertise = "<\U65e0>";
 joinDate = "2014-04-13 09:46:38";
 platform = "<\U65e0>";
 };
 name = "\U7231\U5403\U80e1\U841d\U535c";
 portrait = "https://static.oschina.net/uploads/user/794/1588585_50.jpg?t=1397353598000";
 relation = 1;
 statistics =         {
 answer = 0;
 blog = 0;
 collect = 0;
 discuss = 7;
 fans = 0;
 follow = 0;
 score = 0;
 tweet = 1;
 };
 };
 time = "2016-11-01 09:42:20";
 }
 */
- (instancetype)initWithUserInfoDic:(NSDictionary *)userInfoDic {
    self = [super init];
    if (self) {
        NSDictionary *resultDic = userInfoDic[@"result"];
        _desc = resultDic[@"desc"];
        _userID = ((NSNumber *)resultDic[@"id"]).integerValue;
        _moreInfo = resultDic[@"more"];
        _name = resultDic[@"name"];
        _portrait = resultDic[@"portrait"];
        _relation = ((NSNumber *)resultDic[@"relation"]).integerValue;
        _aStatisticsInfo = [self getStatisticsInfoWithDic:resultDic[@"statistics"]];
        
        _latestOnlineTime = [NSDate dateWithString:userInfoDic[@"time"] formatString:@"yyyy-MM-dd HH:mm:ss"];

//        NSLog(@"%@,%@",_latestOnlineTime,userInfoDic[@"time"]);
//        NSLog(@"%@",[_latestOnlineTime formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss"]);
    }
    return self;
}

- (MoreUserInfo *)getMoreUserInfoWithDic:(NSDictionary *)dic {
    MoreUserInfo *info = [MoreUserInfo new];
    for (NSString *key in dic.allKeys) {
        [info setValue:dic[key] forKey:key];
    }
    return info;
}

- (StatisticsInfo *)getStatisticsInfoWithDic:(NSDictionary *)dic {
    StatisticsInfo *info = [StatisticsInfo new];
  //  info.blog = ((NSNumber *)dic[@"blog"]).intValue;
    for (NSString *key in dic.allKeys) {
        [info setValue:dic[key] forKey:key];
    }
    
    return info;
}


- (BOOL)isEqual:(OSCUser *)object {
    if ([self class] == [object class]) {
        if (object == self) {
            return YES;
        } else {
            /*
             @property (nonatomic, copy) NSString *desc;//描述
             @property (nonatomic, copy) NSString *gender;
             @property (nonatomic, assign) NSInteger userID;
             @property (nonatomic,strong) MoreUserInfo *moreInfo;
             @property (nonatomic, copy) NSString *name;
             @property (nonatomic, strong) NSString *portrait;
             @property (nonatomic, assign) NSInteger relation;
             @property (nonatomic,strong) StatisticsInfo *aStatisticsInfo;
             @property (nonatomic, strong) NSDate *latestOnlineTime;
             */
            return ([self.desc isEqual:object.desc] || self.desc == object.desc)
            &&([self.gender isEqual:object.gender] || self.gender == object.gender)
            &&(self.userID == object.userID)
            &&([self.moreInfo isEqual:object.moreInfo] || self.moreInfo == object.moreInfo)
            &&([self.name isEqual:object.name] || self.name == object.name)
            &&([self.portrait isEqual:object.portrait] || self.portrait == object.portrait)
            &&([self.aStatisticsInfo isEqual:object.aStatisticsInfo] || self.aStatisticsInfo == object.aStatisticsInfo)
            &&([self.latestOnlineTime isEqual:object.latestOnlineTime] || self.latestOnlineTime == object.latestOnlineTime)
            ;
        }
    }
    
    return NO;
}




- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    
    [aCoder encodeObject:_desc forKey:@"desc"];
    
    [aCoder encodeObject:_gender forKey:@"gender"];
    
    [aCoder encodeObject:@(_userID) forKey:@"userID"];
    
    [aCoder encodeObject:_moreInfo forKey:@"moreInfo"];
    
    [aCoder encodeObject:_name forKey:@"name"];
    
    [aCoder encodeObject:_portrait forKey:@"portrait"];
    
    [aCoder encodeObject:@(_relation) forKey:@"relation"];
    
    [aCoder encodeObject:_aStatisticsInfo forKey:@"aStatisticsInfo"];
    
    
    [aCoder encodeObject:_latestOnlineTime forKey:@"latestOnlineTime"];
    
    
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self) {
        _desc = [aDecoder decodeObjectForKey:@"desc"];
        _gender = [aDecoder decodeObjectForKey:@"gender"];
        _userID = ((NSNumber *)[aDecoder decodeObjectForKey:@"userID"]).integerValue;
        _moreInfo = [aDecoder decodeObjectForKey:@"moreInfo"];
        _name = [aDecoder decodeObjectForKey:@"name"];
        _portrait = [aDecoder decodeObjectForKey:@"portrait"];
        _relation = ((NSNumber *)[aDecoder decodeObjectForKey:@"relation"]).integerValue;
        _aStatisticsInfo = [aDecoder decodeObjectForKey:@"aStatisticsInfo"];
        _latestOnlineTime = [aDecoder decodeObjectForKey:@"latestOnlineTime"];
    }
    return self;
}

@end




