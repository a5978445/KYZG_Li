//
//  QuesAnsTableViewCell.h
//  iosapp
//
//  Created by Graphic-one on 16/5/27.
//  Copyright © 2016年 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* QuesAnsTableViewCell_IdentifierString;

@class OSCQuestion;
@interface QuesAnsTableViewCell : UITableViewCell

@property (nonatomic,strong) OSCQuestion* viewModel;

@end
