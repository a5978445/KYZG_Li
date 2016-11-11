//
//  TagButtons.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/9.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "TagButtons.h"

@implementation TagButtons {
    NSMutableArray<UIButton *> *_buttons;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _buttons = [NSMutableArray new];
       // self.backgroundColor = RGB(246, 246, 246);
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    
    [self removeButtons];
    if (titles.count > 0) {
        [self addButtonsWithTitles:titles];
        
        [self addLayouts];
    }
    
    _buttons.firstObject.selected = YES;
    _buttons.firstObject.layer.borderWidth = 1.0f;
}

- (void)addButtonsWithTitles:(NSArray<NSString *> *)titles {
    for (int i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.autoresizesSubviews = NO;
        [button setBackgroundColor:RGB(246, 246, 246)];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor titleBarColor];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:[UIColor colorWithHex:0x909090] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor newSectionButtonSelectedColor] forState:UIControlStateSelected];
        button.tag = i;
        
        button.layer.cornerRadius = 2.0f;
        button.layer.borderColor = [UIColor newSectionButtonSelectedColor].CGColor;
        
        
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [_buttons addObject:button];
    }
}

- (void)removeButtons {
    for (UIButton *button in _buttons) {
        [button removeFromSuperview];
    }
    [_buttons removeAllObjects];
}

- (void)addLayouts {
    CGFloat jianXi = 12.0f;
    CGFloat buttonWidth = (self.bounds.size.width - jianXi *(_buttons.count + 1))* 1.0f/_buttons.count;
    for (int i = 0; i < _buttons.count; i++) {
        UIButton *button = _buttons[i];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(5);
            make.bottom.offset(-5);
            //    make.width.equalTo(self.mas_width).priority(1.0f/_buttons.count);
            make.width.offset(buttonWidth);
            if (i > 0) {
                make.left.equalTo(_buttons[i - 1].mas_right).offset(jianXi);
            } else {
                make.left.offset(jianXi);
            }
        }];
        
    }
}

- (void)click:(UIButton *)button {
    
    for (UIButton *aButton in _buttons) {
        aButton.selected = NO;
        aButton.layer.borderWidth = 0.0f;
    }
    button.selected = YES;
    
    button.layer.borderWidth = 1.0f;
    if (_block) {
        _block(button.tag);
    }
}

@end
