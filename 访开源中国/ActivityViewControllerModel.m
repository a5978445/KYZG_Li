//
//  ActivityViewControllerModel.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/10.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "ActivityViewControllerModel.h"

@implementation ActivityViewControllerModel {
    NSMutableArray<OSCBanner *> *_banners;
}


#pragma mark - public method
- (void)setNewsImageURLsWithDictionaryArray:(NSArray<NSDictionary *> *)items {
    _banners = [NSMutableArray new];
    
    for (NSDictionary *dic in items) {
        OSCBanner *aBanner = [OSCBanner mj_objectWithKeyValues:dic];
        
        [_banners addObject:aBanner];
    }
}

- (NSArray<OSCBanner *> *)banners {
    return _banners;
}

@end
