//
//  NewsCellTableViewCell.h
//  访开源中国
//
//  Created by 李腾芳 on 16/11/8.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsTableViewCellModel.h"

@interface NewsTableViewCell : UITableViewCell
@property(strong,nonatomic) id<NewsCellProtocol> model;

- (CGFloat)cellHeight;
@end
