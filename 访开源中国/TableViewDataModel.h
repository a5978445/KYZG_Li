//
//  TableViewDataModel.h
//  访开源中国
//
//  Created by 李腾芳 on 16/10/25.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SelectBlock)();

@interface TableViewDataModel : NSObject

@property(readonly,nonatomic) NSString *title;
@property(readonly,nonatomic) NSString *imageName;
@property(readonly,nonatomic) SelectBlock selectBlock;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName selectBlock:(SelectBlock)selectBlock;

@end
