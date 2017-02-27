//
//  TestQuartsView.h
//  访开源中国
//
//  Created by LiTengFang on 2017/2/27.
//  Copyright © 2017年 李腾芳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuartzCanvasView : UIView
@property (nonatomic,assign) CGPoint offestCenter;
@property (nonatomic,assign) NSInteger minimumRoundRadius;
@property (nonatomic,strong) UIColor* strokeColor;
@end
