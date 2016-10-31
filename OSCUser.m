//
//  OSCUser.m
//  iosapp
//
//  Created by chenhaoxiang on 11/5/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import "OSCUser.h"

@implementation OSCUser

//- (instancetype)initWithXML:(ONOXMLElement *)xml
//{
//    self = [super init];
//    if (!self) {return nil;}
//    // 有些API返回用<id>，有些地方用<userid>，这样写是为了简化处理
//    _userID = [[[xml firstChildWithTag:@"uid"] numberValue] longLongValue] | [[[xml firstChildWithTag:@"userid"] numberValue] longLongValue];
//    
//    // 理由同上
//    _location = [[[xml firstChildWithTag:@"location"] stringValue] copy];
//    if (!_location) {_location = [[[xml firstChildWithTag:@"from"] stringValue] copy];}
//    
//    _name = [[[xml firstChildWithTag:@"name"] stringValue] copy];
//    _followersCount = [[[xml firstChildWithTag:@"followers"] numberValue] intValue];
//    _fansCount = [[[xml firstChildWithTag:@"fans"] numberValue] intValue];
//    _score = [[[xml firstChildWithTag:@"score"] numberValue] intValue];
//    _relationship = [[[xml firstChildWithTag:@"relation"] numberValue] intValue];
//    _portraitURL = [NSURL URLWithString:[[xml firstChildWithTag:@"portrait"] stringValue]];
//    _favoriteCount = [[[xml firstChildWithTag:@"favoritecount"] numberValue] intValue];
//    
//    _gender             = [[[xml firstChildWithTag:@"gender"] stringValue] copy];
//    
//    _developPlatform    = [[[xml firstChildWithTag:@"devplatform"] stringValue] copy];
//    _expertise = [[[xml firstChildWithTag:@"expertise"] stringValue] copy];
//    _joinTime = [NSDate dateFromString:[xml firstChildWithTag:@"jointime"].stringValue];
//    _latestOnlineTime = [NSDate dateFromString:[xml firstChildWithTag:@"latestonline"].stringValue];
//    
//    return self;
//}




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
        NSDictionary *userDic = dic[@"user"];
        _fansCount = ((NSNumber *)userDic[@"fans"]).intValue;
        _favoriteCount = ((NSNumber *)userDic[@"favoritecount"]).intValue;
        _followersCount = ((NSNumber *)userDic[@"favoritecount"]).intValue;
        _gender = userDic[@"favoritecount"];
        _location = userDic[@"favoritecount"];
        _name = userDic[@"favoritecount"];
        _portraitURL = userDic[@"favoritecount"];
        _score = ((NSNumber *)userDic[@"favoritecount"]).intValue;
        _userID = ((NSNumber *)userDic[@"favoritecount"]).intValue;
        
        
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if ([self class] == [object class]) {
        return _userID == ((OSCUser *)object).userID;
    }
    
    return NO;
}


@end
