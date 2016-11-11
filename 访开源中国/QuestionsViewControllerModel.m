//
//  QuestionsViewControllerModel.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/11.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "QuestionsViewControllerModel.h"

@interface QuestionModel : NSObject

@property(strong,nonatomic) NSMutableArray<OSCQuestion *> *models;
@property(strong,nonatomic) NSString *nextPageToken;

@end

@implementation QuestionModel
- (NSMutableArray<OSCQuestion *> *)models {
    if (_models == nil) {
        _models = [NSMutableArray new];
    }
    return _models;
}

@end

@implementation QuestionsViewControllerModel {
    NSMutableArray<QuestionModel *> *_models;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _models = [NSMutableArray new];
        [_models addObject:[QuestionModel new]];
        [_models addObject:[QuestionModel new]];
        [_models addObject:[QuestionModel new]];
        [_models addObject:[QuestionModel new]];
        [_models addObject:[QuestionModel new]];
    }
    return self;
}

- (void)updateModelsWithDic:(NSDictionary *)dic questionsType:(QuestionsType)type{
    NSArray* JsonItems = dic[@"items"];
    _models[type].models = [OSCQuestion mj_objectArrayWithKeyValuesArray:JsonItems];
    _models[type].nextPageToken = dic[@"nextPageToken"];
}


- (void)addModelsWithDic:(NSDictionary *)dic questionsType:(QuestionsType)type{
    NSArray* JsonItems = dic[@"items"];
    [_models[type].models addObjectsFromArray:[OSCQuestion mj_objectArrayWithKeyValuesArray:JsonItems]];
    _models[type].nextPageToken = dic[@"nextPageToken"];
}

- (NSArray<OSCQuestion *> *)questionModelsWithQuestionsType:(QuestionsType)type {
    return _models[type].models;
}

- (NSString *)nextPageTokenWithQuestionsType:(QuestionsType)type {
    return _models[type].nextPageToken;
}
@end
