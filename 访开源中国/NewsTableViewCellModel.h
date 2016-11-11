//
//  NewsTableViewCellModel.h
//  访开源中国
//
//  Created by 李腾芳 on 16/11/8.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSCInformation.h"
#import "NewsCellProtocol.h"
@interface NewsTableViewCellModel : NSObject<NewsCellProtocol>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithInformation:(OSCInformation *)information;

@property(strong,nonatomic,readonly) OSCInformation *information;

@end
