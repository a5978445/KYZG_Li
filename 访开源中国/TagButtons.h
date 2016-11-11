//
//  TagButtons.h
//  访开源中国
//
//  Created by 李腾芳 on 16/11/9.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TagButtonsClickBlock)(NSInteger tag);

@interface TagButtons : UIView
@property(strong,nonatomic) TagButtonsClickBlock block;

- (void)setTitles:(NSArray<NSString *> *)titles;
@end
