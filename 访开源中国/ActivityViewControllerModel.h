//
//  ActivityViewControllerModel.h
//  访开源中国
//
//  Created by 李腾芳 on 16/11/10.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSCBanner.h"
#import "OSCActivities.h"

@interface ActivityViewControllerModel : NSObject

@property(strong,nonatomic) NSMutableArray<OSCActivities *> *activities;
@property(copy,nonatomic) NSString *nextPageToken;
- (void)setNewsImageURLsWithDictionaryArray:(NSArray<NSDictionary *> *)items;
- (NSArray<OSCBanner *> *)banners;

@end
