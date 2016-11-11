//
//  NewBlogsViewControllerModel.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/9.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "NewBlogsViewControllerModel.h"

@interface BlogModel : NSObject

@property(strong,nonatomic) NSMutableArray<BlogCellModel *> *models;
@property(strong,nonatomic) NSString *nextPageToken;

- (void)setDataMoldels:(NSArray<OSCNewHotBlog *> *)dataMoldels;
- (void)addDataMoldels:(NSArray<OSCNewHotBlog *> *)dataMoldels;
@end

@implementation BlogModel
- (NSMutableArray<BlogCellModel *> *)models {
    if (_models == nil) {
        _models = [NSMutableArray new];
    }
    return _models;
}

- (void)setDataMoldels:(NSArray<OSCNewHotBlog *> *)dataMoldels {
    self.models = [self getCellModelsWithDataModels:dataMoldels];
}

- (void)addDataMoldels:(NSArray<OSCNewHotBlog *> *)dataMoldels {
    [self.models addObjectsFromArray:[self getCellModelsWithDataModels:dataMoldels]];
}

- (NSMutableArray *)getCellModelsWithDataModels:(NSArray<OSCNewHotBlog *> *)dataModels {
    NSMutableArray *result = [NSMutableArray new];
    for (OSCNewHotBlog *blog in dataModels) {
        BlogCellModel *model = [BlogCellModel new];
        model.blog = blog;
        [result addObject:model];
    }
    return result;
}


@end

@implementation NewBlogsViewControllerModel {
    NSMutableArray<BlogModel *> *_models;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _models = [NSMutableArray new];
        [_models addObject:[BlogModel new]];
        [_models addObject:[BlogModel new]];
        [_models addObject:[BlogModel new]];
    }
    return self;
}

- (void)updateModelsWithDic:(NSDictionary *)dic blogType:(BlogType)type{
    NSArray* JsonItems = dic[@"items"];
    [_models[type] setDataMoldels:[OSCNewHotBlog mj_objectArrayWithKeyValuesArray:JsonItems]];
    _models[type].nextPageToken = dic[@"nextPageToken"];
}


- (void)addModelsWithDic:(NSDictionary *)dic blogType:(BlogType)type{
    NSArray* JsonItems = dic[@"items"];
    [_models[type] addDataMoldels:[OSCNewHotBlog mj_objectArrayWithKeyValuesArray:JsonItems]];
    _models[type].nextPageToken = dic[@"nextPageToken"];
}

- (NSArray<BlogCellModel *> *)blogModelsWithBlogType:(BlogType)type {
    return _models[type].models;
}

- (NSString *)nextPageTokenWithBlogType:(BlogType)type {
    return _models[type].nextPageToken;
}


@end
