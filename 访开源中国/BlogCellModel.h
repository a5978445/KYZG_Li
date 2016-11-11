//
//  BlogCellModel.h
//  访开源中国
//
//  Created by 李腾芳 on 16/11/9.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSCNewHotBlog.h"
#import "NewsCellProtocol.h"

@interface BlogCellModel : NSObject<NewsCellProtocol>
@property(strong,nonatomic) OSCNewHotBlog *blog;

@end
