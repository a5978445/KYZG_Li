//
//  UserInfoButtons.m
//  访开源中国
//
//  Created by 李腾芳 on 16/10/27.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "UserInfoButtons.h"

@implementation UserInfoButtons {
    NSMutableArray<UIButton *> *_buttons;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (instancetype)initWithFrame:(CGRect)frame title:(NSArray<NSString *>*)titles{
//    self = [super initWithFrame:frame];
//    if (self) {
//        _buttons = [NSMutableArray new];
//        if (titles.count > 0) {
//            CGFloat buttonWidth = frame.size.width / titles.count;
//            CGFloat buttonHeight = frame.size.height;
//            for (int i = 0; i < titles.count; i ++) {
//                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonWidth * i, 0, buttonWidth, buttonHeight)];
//                [button setTitle:titles[i] forState:UIControlStateNormal];
//                [_buttons addObject:button];
//                [self addSubview:button];
//            }
//        }
//      
//    }
//    self.backgroundColor = RGB(44, 183, 90);
//    
//    //24,12
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame titleDic:(NSArray<NSDictionary *>*)titles{
    self = [super initWithFrame:frame];
    if (self) {
        _buttons = [NSMutableArray new];
        if (titles.count > 0) {
            CGFloat buttonWidth = frame.size.width / titles.count;
            CGFloat buttonHeight = frame.size.height;
            for (int i = 0; i < titles.count; i ++) {
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonWidth * i, 0, buttonWidth, buttonHeight)];
                [button setAttributedTitle:[self getAttributedStringWithTitleDic:titles[i]] forState:UIControlStateNormal];
                button.titleLabel.numberOfLines = 0;
                button.titleLabel.textAlignment = NSTextAlignmentCenter;
             //   [button setTitle:titles[i] forState:UIControlStateNormal];
                [_buttons addObject:button];
                [self addSubview:button];
            }
        }
        
    }
    self.backgroundColor = RGB(44, 183, 90);
    /*
     {@"title":@"关注"，@“subTitle”:@"1234"};
     */
    //24,12
    return self;
}

- (NSAttributedString *)getAttributedStringWithTitleDic:(NSDictionary *)titleDic {
    //NSString *title = titleDic[@"title"];
    //NSString *subTitle = titleDic[@"subTitle"];
    
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:titleDic[@"title"]
                                                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    NSAttributedString *fenGe = [[NSAttributedString alloc]initWithString:@"\n"
                                                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    
    NSAttributedString *subTitle = [[NSAttributedString alloc]initWithString:titleDic[@"subTitle"]
                                                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]initWithAttributedString:subTitle];
    [result appendAttributedString:fenGe];
    [result appendAttributedString:title];
    
    return result;
}



@end
