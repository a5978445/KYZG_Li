//
//  TableViewDataModel.m
//  访开源中国
//
//  Created by 李腾芳 on 16/10/25.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "TableViewDataModel.h"



@implementation TableViewDataModel

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName selectBlock:(SelectBlock)selectBlock {
    self = [super init];
    if (self) {
        _title = title.copy;
        _imageName = imageName.copy;
        _selectBlock = [selectBlock copy];
    }
    return self;
}

@end
