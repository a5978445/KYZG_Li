//
//  QuestionsViewControllerModel.h
//  访开源中国
//
//  Created by 李腾芳 on 16/11/11.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSCQuestion.h"

typedef enum : NSUInteger {
    QuestionsTypeQuestions = 0,
    QuestionsTypeShare = 1,
    QuestionsTypeComposite = 2,
    QuestionsTypeProfession = 3,
    QuestionsTypeDepot = 4
} QuestionsType;

@interface QuestionsViewControllerModel : NSObject
- (void)updateModelsWithDic:(NSDictionary *)dic questionsType:(QuestionsType)type;
- (void)addModelsWithDic:(NSDictionary *)dic questionsType:(QuestionsType)type;

- (NSString *)nextPageTokenWithQuestionsType:(QuestionsType)type;
- (NSArray<OSCQuestion *>*)questionModelsWithQuestionsType:(QuestionsType)type;
@end




