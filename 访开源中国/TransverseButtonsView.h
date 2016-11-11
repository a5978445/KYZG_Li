//
//  TransverseButtonsView.h
//  访开源中国
//
//  Created by 李腾芳 on 16/10/25.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TransverseButtonsViewClickBlock)(NSInteger tag);

@interface TransverseButtonsView : UIView
@property(strong,nonatomic) TransverseButtonsViewClickBlock block;

- (void)setTitles:(NSArray<NSString *> *)titles;

@end
