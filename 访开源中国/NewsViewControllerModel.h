//
//  NewsViewControllerModel.h
//  访开源中国
//
//  Created by 李腾芳 on 16/11/8.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSCBanner.h"
#import "OSCInformation.h"
#import "NewsTableViewCellModel.h"

@interface NewsViewControllerModel : NSObject

- (NSArray<NSString *> *)newsImageURLs;
- (NSArray<OSCInformation *> *)informations;
- (NSArray<NewsTableViewCellModel *> *)cellModels;

- (void)setNewsImageURLsWithDictionaryArray:(NSArray<NSDictionary *> *)items;

- (void)addInformationsWithDictionaryArray:(NSArray<NSDictionary *> *)items;
- (void)setInformationsWithDictionaryArray:(NSArray<NSDictionary *> *)items;

@end
