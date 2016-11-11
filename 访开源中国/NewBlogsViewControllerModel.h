//
//  NewBlogsViewControllerModel.h
//  访开源中国
//
//  Created by 李腾芳 on 16/11/9.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSCNewHotBlog.h"
#import "BlogCellModel.h"
typedef enum : NSUInteger {
    BlogTypeRecommend = 0,
    BlogTypeHot = 1,
    BlogTypeNew = 2,
} BlogType;

@interface NewBlogsViewControllerModel : NSObject

- (void)updateModelsWithDic:(NSDictionary *)dic blogType:(BlogType)type;
- (void)addModelsWithDic:(NSDictionary *)dic blogType:(BlogType)type;

- (NSString *)nextPageTokenWithBlogType:(BlogType)type;
- (NSArray<BlogCellModel *>*)blogModelsWithBlogType:(BlogType)type;

@end
