//
//  Utils.m
//  iosapp
//
//  Created by chenhaoxiang on 14-10-16.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import "Utils.h"
#import "AppDelegate.h"

//#import "UIFont+FontAwesome.h"
//#import "NSString+FontAwesome.h"

#import <MBProgressHUD.h>
#import <objc/runtime.h>
//#import <Reachability.h>
#import <SDWebImage/UIImageView+WebCache.h>
//#import <GRMustache.h>
//#import <DTCoreText.h>


@implementation Utils


#pragma mark - 处理API返回信息

//+ (NSAttributedString *)getAppclient:(int)clientType
//{
//    NSMutableAttributedString *attributedClientString;
//    if (clientType > 1 && clientType <= 6) {
//        NSArray *clients = @[@"", @"", @"手机", @"Android", @"iPhone", @"Windows Phone", @"微信"];
//        
//        attributedClientString = [[NSMutableAttributedString alloc] initWithString:[NSString fontAwesomeIconStringForEnum:FAMobile]
//                                                                        attributes:@{
//                                                                                     NSFontAttributeName: [UIFont fontAwesomeFontOfSize:13],
//                                                                                     }];
//        
//        [attributedClientString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", clients[clientType]]]];
//    } else {
//        attributedClientString = [[NSMutableAttributedString alloc] initWithString:@""];
//    }
//    
//    return attributedClientString;
//}


+ (NSAttributedString *)getAppclientName:(int)clientType
{
    NSMutableAttributedString *attributedClientString;
    if (clientType > 1 && clientType <= 6) {
        NSArray *clients = @[@"", @"", @"手机", @"Android", @"iPhone", @"Windows Phone", @"微信"];
        
        
        attributedClientString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", clients[clientType]]];

    } else {
        attributedClientString = [[NSMutableAttributedString alloc] initWithString:@""];
    }
    
    return attributedClientString;
}

+ (NSString *)generateRelativeNewsString:(NSArray *)relativeNews
{
    if (relativeNews == nil || [relativeNews count] == 0) {
        return @"";
    }
    
    NSString *middle = @"";
    for (NSArray *news in relativeNews) {
        middle = [NSString stringWithFormat:@"%@<a href=%@>%@</a><p/>", middle, news[1], news[0]];
    }
    return [NSString stringWithFormat:@"相关文章<div style='font-size:14px'><p/>%@</div>", middle];
}

+ (NSString *)generateTags:(NSArray *)tags
{
    if (tags == nil || tags.count == 0) {
        return @"";
    } else {
        NSString *result = @"";
        for (NSString *tag in tags) {
            result = [NSString stringWithFormat:@"%@<a style='background-color: #BBD6F3;border-bottom: 1px solid #3E6D8E;border-right: 1px solid #7F9FB6;color: #284A7B;font-size: 12pt;-webkit-text-size-adjust: none;line-height: 2.4;margin: 2px 2px 2px 0;padding: 2px 4px;text-decoration: none;white-space: nowrap;' href='http://www.oschina.net/question/tag/%@' >&nbsp;%@&nbsp;</a>&nbsp;&nbsp;", result, tag, tag];
        }
        return result;
    }
}




#pragma mark - 通用

#pragma mark - emoji Dictionary

+ (NSDictionary *)emojiDict
{
    static dispatch_once_t once;
    static NSDictionary *emojiDict;
    
    dispatch_once(&once, ^ {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path = [bundle pathForResource:@"emoji" ofType:@"plist"];
        emojiDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    });
    
    return emojiDict;
}

#pragma mark 信息处理

//+ (NSAttributedString *)attributedTimeString:(NSDate *)date
//{
////    NSString *rawString = [NSString stringWithFormat:@"%@ %@", [NSString fontAwesomeIconStringForEnum:FAClockO], [date timeAgoSinceNow]];
//    NSString *rawString = [date timeAgoSinceNow];
//    
//    NSAttributedString *attributedTime = [[NSAttributedString alloc] initWithString:rawString
//                                                                         attributes:@{
//                                                                                      NSFontAttributeName: [UIFont fontAwesomeFontOfSize:12],
//                                                                                      }];
//    
//    return attributedTime;
//}

//+ (NSAttributedString *)newTweetAttributedTimeString:(NSDate *)date
//{
////    NSString *rawString = [NSString stringWithFormat:@"%@ %@", [NSString fontAwesomeIconStringForEnum:FAClockO], ];
//    
//    NSAttributedString *attributedTime = [[NSAttributedString alloc] initWithString:[date timeAgoSinceNow]
//                                                                         attributes:@{
//                                                                                      NSFontAttributeName: [UIFont fontAwesomeFontOfSize:12],
//                                                                                      }];
//    
//    return attributedTime;
//}

// 参考 http://www.cnblogs.com/ludashi/p/3962573.html

//+ (NSAttributedString *)emojiStringFromRawString:(NSString *)rawString
//{
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:rawString attributes:nil];
//    return [Utils emojiStringFromAttrString:attrString];
//}

//+ (NSAttributedString *)emojiStringFromAttrString:(NSAttributedString*)attrString
//{
//    NSMutableAttributedString *emojiString = [[NSMutableAttributedString alloc] initWithAttributedString:attrString];
//    NSDictionary *emoji = self.emojiDict;
//    
//    NSString *pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]|:[a-zA-Z0-9\\u4e00-\\u9fa5_]+:";
//    NSError *error = nil;
//    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
//    
//    NSArray *resultsArray = [re matchesInString:attrString.string options:0 range:NSMakeRange(0, attrString.string.length)];
//    
//    NSMutableArray *emojiArray = [NSMutableArray arrayWithCapacity:resultsArray.count];
//	
//	int maxCount = 0;
//	
//    for (NSTextCheckingResult *match in resultsArray) {
//		
//		if (maxCount >= 6) {
//			break; //最多只允许六个emoji表情（和web保持一致）
//		}
//		
//        NSRange range = [match range];
//        NSString *emojiName = [attrString.string substringWithRange:range];
//        
//        if ([emojiName hasPrefix:@"["] && emoji[emojiName]) {
//            NSTextAttachment *textAttachment = [NSTextAttachment new];
//            textAttachment.image = [UIImage imageNamed:emoji[emojiName]];
//            [textAttachment adjustY:-3];
//            NSAttributedString *emojiAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
//            [emojiArray addObject: @{@"image": emojiAttributedString, @"range": [NSValue valueWithRange:range]}];
//        } else if ([emojiName hasPrefix:@":"]) {
//            if (emoji[emojiName]) {
//                [emojiArray addObject:@{@"text": emoji[emojiName], @"range": [NSValue valueWithRange:range]}];
//            } else {
//                UIImage *emojiImage = [UIImage imageNamed:[emojiName stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":"]]];
//                NSTextAttachment *textAttachment = [NSTextAttachment new];
//                textAttachment.image = emojiImage;
//                [textAttachment adjustY:-3];
//                NSAttributedString *emojiAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
//                [emojiArray addObject: @{@"image": emojiAttributedString, @"range": [NSValue valueWithRange:range]}];
//            }
//        }
//		
//		maxCount += 1;
//    }
//    
//    for (NSInteger i = emojiArray.count -1; i >= 0; i--) {
//        NSRange range;
//        [emojiArray[i][@"range"] getValue:&range];
//        if (emojiArray[i][@"image"]) {
//            [emojiString replaceCharactersInRange:range withAttributedString:emojiArray[i][@"image"]];
//        } else {
//            [emojiString replaceCharactersInRange:range withString:emojiArray[i][@"text"]];
//        }
//    }
//    
//    return emojiString;
//}

//+ (NSAttributedString *)attributedStringFromHTML:(NSString *)html
//{
//    // [NSAttributedAttributedString initWithData:options:documentAttributes:error:] is very slow
//    // use DTCoreText instead
//    
//    if (![html hasPrefix:@"<"]) {
//        html = [NSString stringWithFormat:@"<span>%@</span>", html]; // DTCoreText treat raw string as <p> element
//    }
//    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
//    return [[NSAttributedString alloc] initWithHTMLData:data options:@{ DTUseiOS6Attributes: @YES}
//                                     documentAttributes:nil];
//}

//+ (NSAttributedString*)contentStringFromRawString:(NSString*)rawString
//{
//    if (!rawString || rawString.length == 0) return [[NSAttributedString alloc] initWithString:@""];
//    
//    NSAttributedString *attrString = [Utils attributedStringFromHTML:rawString];
//    NSMutableAttributedString *mutableAttrString = [[Utils emojiStringFromAttrString:attrString] mutableCopy];
//    [mutableAttrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, mutableAttrString.length)];
//    
//    // remove under line style
//    [mutableAttrString beginEditing];
//    [mutableAttrString enumerateAttribute:NSUnderlineStyleAttributeName
//                                  inRange:NSMakeRange(0, mutableAttrString.length)
//                                  options:0
//                               usingBlock:^(id value, NSRange range, BOOL *stop) {
//                                   if (value) {
//                                       [mutableAttrString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleNone) range:range];
//                                   }
//                               }];
//    [mutableAttrString endEditing];
//    
//    return mutableAttrString;
//}

+ (NSString *)convertRichTextToRawText:(UITextView *)textView
{
    NSMutableString *rawText = [[NSMutableString alloc] initWithString:textView.text];
    
    [textView.attributedText enumerateAttribute:NSAttachmentAttributeName
                                        inRange:NSMakeRange(0, textView.attributedText.length)
                                        options:NSAttributedStringEnumerationReverse
                                     usingBlock:^(NSTextAttachment *attachment, NSRange range, BOOL *stop) {
                                                    if (!attachment) {return;}
                                        
                                                    NSString *emojiStr = objc_getAssociatedObject(attachment, @"emoji");
                                                    [rawText insertString:emojiStr atIndex:range.location];
                                                }];
    
    NSString *pattern = @"[\ue000-\uf8ff]|[\\x{1f300}-\\x{1f7ff}]|\\x{263A}\\x{FE0F}|☺";
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *resultsArray = [re matchesInString:textView.text options:0 range:NSMakeRange(0, textView.text.length)];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"emojiToText" ofType:@"plist"];
    NSDictionary *emojiToText = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    for (NSTextCheckingResult *match in [resultsArray reverseObjectEnumerator]) {
        NSString *emoji = [textView.text substringWithRange:match.range];
        [rawText replaceCharactersInRange:match.range withString:emojiToText[emoji]];
    }
    
    return [rawText stringByReplacingOccurrencesOfString:@"\U0000fffc" withString:@""];
}

+ (NSData *)compressImage:(UIImage *)image
{
    CGSize size = [self scaleSize:image.size];
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSUInteger maxFileSize = 500 * 1024;
    CGFloat compressionRatio = 0.7f;
    CGFloat maxCompressionRatio = 0.1f;
    
    NSData *imageData = UIImageJPEGRepresentation(scaledImage, compressionRatio);
    
    while (imageData.length > maxFileSize && compressionRatio > maxCompressionRatio) {
        compressionRatio -= 0.1f;
        imageData = UIImageJPEGRepresentation(image, compressionRatio);
    }
    
    return imageData;
}

+ (CGSize)scaleSize:(CGSize)sourceSize
{
    float width = sourceSize.width;
    float height = sourceSize.height;
    if (width >= height) {
        return CGSizeMake(800, 800 * height / width);
    } else {
        return CGSizeMake(800 * width / height, 800);
    }
}


+ (BOOL)isURL:(NSString *)string
{
    NSString *pattern = @"^(http|https)://.*?$(net|com|.com.cn|org|me|)";
    
    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    return [urlPredicate evaluateWithObject:string];
}


//+ (NSInteger)networkStatus
//{
//    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.oschina.net"];
//    return reachability.currentReachabilityStatus;
//}

//+ (BOOL)isNetworkExist
//{
//    return [self networkStatus] > 0;
//}


#pragma mark UI处理

+ (CGFloat)valueBetweenMin:(CGFloat)min andMax:(CGFloat)max percent:(CGFloat)percent
{
    return min + (max - min) * percent;
}

+ (MBProgressHUD *)createHUD {
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    HUD.detailsLabel.font = [UIFont boldSystemFontOfSize:16];
    [window addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    //[HUD addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:HUD action:@selector(hide:)]];
    
    return HUD;
}

+ (MBProgressHUD *)showHUDWithText:(NSString *)text {
    MBProgressHUD *HUD = [self createHUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.label.text = text;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:2.0f];
    return HUD;
}

+ (UIImage *)createQRCodeFromString:(NSString *)string
{
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *QRFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [QRFilter setValue:stringData forKey:@"inputMessage"];
    [QRFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    CGFloat scale = 5;
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:QRFilter.outputImage fromRect:QRFilter.outputImage.extent];
    
    //Scale the image usign CoreGraphics
    CGFloat width = QRFilter.outputImage.extent.size.width * scale;
    UIGraphicsBeginImageContext(CGSizeMake(width, width));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //Cleaning up
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    
    return image;
}

//+ (NSAttributedString *)attributedCommentCount:(int)commentCount
//{
//    NSString *rawString = [NSString stringWithFormat:@"%@ %d", [NSString fontAwesomeIconStringForEnum:FACommentsO], commentCount];
//    NSAttributedString *attributedCommentCount = [[NSAttributedString alloc] initWithString:rawString
//                                                                                 attributes:@{
//                                                                                              NSFontAttributeName: [UIFont fontAwesomeFontOfSize:12],
//                                                                                              }];
//    
//    return attributedCommentCount;
//}


//+ (NSString *)HTMLWithData:(NSDictionary *)data usingTemplate:(NSString *)templateName
//{
//    NSString *templatePath = [[NSBundle mainBundle] pathForResource:templateName ofType:@"html" inDirectory:@"html"];
//    NSString *template = [NSString stringWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:nil];
//    
//    NSMutableDictionary *mutableData = [data mutableCopy];
//    [mutableData setObject:@(((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode)
//                    forKey:@"night"];
//    
//    return [GRMustacheTemplate renderObject:mutableData fromString:template error:nil];
//}

/*
 数字限制字符串
 */
+ (NSString *)numberLimitString:(int)number
{
    NSString *numberStr = @"";
    if (number >= 0 && number < 1000) {
        numberStr = [NSString stringWithFormat:@"%d", number];
    } else if (number >= 1000 && number < 10000) {
        int integer = number / 1000;
        int decimal = number % 1000 / 100;
        
        numberStr = [NSString stringWithFormat:@"%d.%dk", integer, decimal];
    } else {
        int inte = number / 1000;
        numberStr = [NSString stringWithFormat:@"%dk", inte];
    }
    
    return numberStr;
}

+ (UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



@end
