//
//  BlogCellModel.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/9.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "BlogCellModel.h"
#import "NSTextAttachment+Util.h"

@implementation BlogCellModel {
    NSMutableAttributedString *_attributedTittle;
    NSMutableAttributedString *_attributedCommentCount;
    NSAttributedString *_bodyString;
    NSAttributedString *_timeString;
}

- (NSMutableAttributedString *)attributedTittle {
    if (_attributedTittle == nil) {
        
        _attributedTittle = [NSMutableAttributedString new];
        if (_blog.recommend) {
            NSTextAttachment *textAttachment = [NSTextAttachment new];
            textAttachment.image = [UIImage imageNamed:@"ic_label_recommend"];
            [textAttachment adjustY:-3];
            NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
            _attributedTittle = [[NSMutableAttributedString alloc] initWithAttributedString:attachmentString];
            [_attributedTittle appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        }
        if (_blog.original) {
            NSTextAttachment *textAttachment = [NSTextAttachment new];
            textAttachment.image = [UIImage imageNamed:@"ic_label_originate"];
            [textAttachment adjustY:-3];
            NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
            [_attributedTittle appendAttributedString:attachmentString];
        } else {
            NSTextAttachment *textAttachment = [NSTextAttachment new];
            textAttachment.image = [UIImage imageNamed:@"ic_label_reprint"];
            [textAttachment adjustY:-3];
            NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
            [_attributedTittle appendAttributedString:attachmentString];
            
        }
        [_attributedTittle appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        
        if (_blog.title.length > 0) {
            [_attributedTittle appendAttributedString:[[NSAttributedString alloc] initWithString:_blog.title]];
        }
        
        
    }
    return _attributedTittle;
}

- (NSAttributedString *)attributedCommentCount {// ic_view,ic_comment
    if (!_attributedCommentCount) {
       // _attributedCommentCount = [Utils attributedCommentCount:_blog.commentCount];
        
        NSTextAttachment *textAttachment1 = [[NSTextAttachment alloc]init];
        textAttachment1.image = [UIImage imageNamed:@"ic_view"];
        [textAttachment1 adjustY:-1];
        
        NSTextAttachment *textAttachment2 = [[NSTextAttachment alloc]init];
        textAttachment2.image = [UIImage imageNamed:@"ic_comment"];
        [textAttachment2 adjustY:-2];
        
       NSAttributedString *viewCountString = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %d   ",_blog.viewCount]
                                                                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor]}];
        
        NSAttributedString *commentCountString = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %d",_blog.commentCount]
                                                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor]}];
        
        _attributedCommentCount = [[NSMutableAttributedString alloc]initWithAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment1]];
        [_attributedCommentCount appendAttributedString:viewCountString];
        [_attributedCommentCount appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment2]];
        [_attributedCommentCount appendAttributedString:commentCountString];
    }
 
    
    return _attributedCommentCount;
}

- (NSAttributedString *)timeString {
    if (_timeString == nil) {
          NSDate *date = [NSDate dateWithString:_blog.pubDate formatString:@"yyyy-MM-dd HH:mm:ss"];
        NSString *str = [NSString stringWithFormat:@"%@   %@",_blog.author,[date timeAgoSinceNow]];
        _timeString = [[NSAttributedString alloc]initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor]}];
    }
    
    return _timeString;
}

- (NSAttributedString *)bodyString {
    if (_bodyString == nil) {
        _bodyString = [[NSAttributedString alloc]initWithString:_blog.body attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor]}];
    }
    return _bodyString;
}
@end
