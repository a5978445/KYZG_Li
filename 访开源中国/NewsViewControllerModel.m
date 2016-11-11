//
//  NewsViewControllerModel.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/8.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "NewsViewControllerModel.h"

@implementation NewsViewControllerModel {
    NSMutableArray<OSCBanner *> *_banners;
    NSMutableArray<OSCInformation *> *_infomations;
    NSMutableArray<NewsTableViewCellModel *> *_cellModels;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _infomations = [NSMutableArray new];
        _cellModels = [NSMutableArray new];
        
    }
    return self;
}

#pragma mark - public method
- (void)setNewsImageURLsWithDictionaryArray:(NSArray<NSDictionary *> *)items {
    _banners = [NSMutableArray new];
    
    for (NSDictionary *dic in items) {
        OSCBanner *aBanner = [OSCBanner mj_objectWithKeyValues:dic];
       
        [_banners addObject:aBanner];
    }
}

- (void)addInformationsWithDictionaryArray:(NSArray<NSDictionary *> *)items {
    for (NSDictionary *dic in items) {
        OSCInformation *aInformation = [OSCInformation mj_objectWithKeyValues:dic];
        [_infomations addObject:aInformation];
        
        NewsTableViewCellModel *model = [[NewsTableViewCellModel alloc]initWithInformation:aInformation];
        [_cellModels addObject:model];
    }
}

- (void)setInformationsWithDictionaryArray:(NSArray<NSDictionary *> *)items {
    _infomations = [NSMutableArray new];
    _cellModels = [NSMutableArray new];
    for (NSDictionary *dic in items) {
        OSCInformation *aInformation = [OSCInformation mj_objectWithKeyValues:dic];
        [_infomations addObject:aInformation];
        
         NewsTableViewCellModel *model = [[NewsTableViewCellModel alloc]initWithInformation:aInformation];
        [_cellModels addObject:model];
    }
}

- (NSArray<NSString *> *)newsImageURLs {
    NSMutableArray *result = [NSMutableArray new];
    for (OSCBanner *aBanner in _banners) {
        [result addObject:aBanner.img];
    }
    return  result;
}

- (NSArray<OSCInformation *> *)informations {
    return _infomations;
}

- (NSArray<NewsTableViewCellModel *> *)cellModels {
    return _cellModels;
}




@end
