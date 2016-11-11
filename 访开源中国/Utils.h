//
//  Utils.h
//  iosapp
//
//  Created by chenhaoxiang on 14-10-16.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "UIView+Util.h"
#import "UIColor+Util.h"
//#import "UIImageView+Util.h"
//#import "UIImage+Util.h"
//#import "NSTextAttachment+Util.h"
//#import "AFHTTPRequestOperationManager+Util.h"
//#import "UINavigationController+Router.h"
//#import "NSDate+Util.h"
//#import "NSString+Util.h"


typedef NS_ENUM(NSUInteger, hudType) {
    hudTypeSendingTweet,
    hudTypeLoading,
    hudTypeCompleted
};

@class MBProgressHUD;

@interface Utils : NSObject

//+ (NSDictionary *)emojiDict;
//
//+ (NSAttributedString *)getAppclient:(int)clientType;
//+ (NSAttributedString *)getAppclientName:(int)clientType;
//
//+ (NSString *)generateRelativeNewsString:(NSArray *)relativeNews;
//+ (NSString *)generateTags:(NSArray *)tags;
//
//+ (NSAttributedString *)emojiStringFromRawString:(NSString *)rawString;
//+ (NSAttributedString *)emojiStringFromAttrString:(NSAttributedString*)attrString;
//+ (NSAttributedString *)attributedStringFromHTML:(NSString *)HTML;
//+ (NSAttributedString*)contentStringFromRawString:(NSString*)rawString;
//+ (NSData *)compressImage:(UIImage *)image;
//+ (NSString *)convertRichTextToRawText:(UITextView *)textView;
//
//+ (BOOL)isURL:(NSString *)string;
//+ (NSInteger)networkStatus;
//+ (BOOL)isNetworkExist;
//
//+ (CGFloat)valueBetweenMin:(CGFloat)min andMax:(CGFloat)max percent:(CGFloat)percent;

+ (MBProgressHUD *)createHUD;
+ (MBProgressHUD *)showHUDWithText:(NSString *)text;
+ (UIImage *)createQRCodeFromString:(NSString *)string;

+ (NSAttributedString *)attributedTimeString:(NSDate *)date;
+ (NSAttributedString *)attributedCommentCount:(int)commentCount;
//
//+ (NSAttributedString *)newTweetAttributedTimeString:(NSDate *)date;
//
//+ (NSString *)HTMLWithData:(NSDictionary *)data usingTemplate:(NSString *)templateName;
//
//+ (NSString *)numberLimitString:(int)number;
//
//+ (UIImage*)createImageWithColor:(UIColor*) color;

@end
