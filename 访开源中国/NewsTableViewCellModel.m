//
//  NewsTableViewCellModel.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/8.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "NewsTableViewCellModel.h"
#import "Utils.h"
#import "NSTextAttachment+Util.h"


@implementation NewsTableViewCellModel {
    NSMutableAttributedString *_attributedTittle;
    NSAttributedString *_attributedCommentCount;
    NSAttributedString *_bodyString;
    NSAttributedString *_timeString;
}

- (instancetype)initWithInformation:(OSCInformation *)information {
    self = [super init];
    if (self) {
        _information = information;
    }
    return self;
}

- (NSAttributedString *)attributedTittle {
    if (!_attributedTittle) {
        NSDate *date = [NSDate dateWithString:_information.pubDate formatString:@"yyyy-MM-dd HH:mm:ss"];
        if ([date isToday]) {
            NSTextAttachment *textAttachment = [NSTextAttachment new];
            textAttachment.image = [UIImage imageNamed:@"widget_taday"];
            [textAttachment adjustY:-2];
            NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
            _attributedTittle = [[NSMutableAttributedString alloc] initWithAttributedString:attachmentString];
            [_attributedTittle appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
            [_attributedTittle appendAttributedString:[[NSAttributedString alloc] initWithString:_information.title]];
        } else {
            _attributedTittle = [[NSMutableAttributedString alloc] initWithString:_information.title];
        }
        
    }
    
    return _attributedTittle;
}

- (NSAttributedString *)attributedCommentCount {
    if (!_attributedCommentCount) {
        _attributedCommentCount = [Utils attributedCommentCount:_information.commentCount];
    }
    
    return _attributedCommentCount;
}

- (NSAttributedString *)timeString {
    if (_timeString == nil) {
        NSDate *date = [NSDate dateWithString:_information.pubDate formatString:@"yyyy-MM-dd HH:mm:ss"];
        _timeString = [[NSAttributedString alloc]initWithString: [date timeAgoSinceNow]attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor]}];
    }

    return _timeString;
}

- (NSAttributedString *)bodyString {
    if (_bodyString == nil) {
        _bodyString = [[NSAttributedString alloc]initWithString:_information.body attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor]}];
    }
    return _bodyString;
}


@end
