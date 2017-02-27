//
//  TestQuartsView.m
//  访开源中国
//
//  Created by LiTengFang on 2017/2/27.
//  Copyright © 2017年 李腾芳. All rights reserved.
//

#import "QuartzCanvasView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#define PI 3.14159265358979323846

@interface QuartzCanvasView()


@end

@implementation QuartzCanvasView {
    CGPoint _center;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        _minimumRoundRadius = 30.0f;
        _strokeColor = [UIColor whiteColor];
     //   _center = self.center;
        CGFloat centerX = frame.size.width * 0.5;
        CGFloat centerY = frame.size.height * 0.5 - 5;
        _center = (CGPoint){centerX,centerY};
    }
    return self;
}

- (void)setOffestCenter:(CGPoint)offestCenter{
    if (_offestCenter.x != offestCenter.x ||  _offestCenter.y != offestCenter.y) {
        _offestCenter = offestCenter;
        
        CGFloat originX = _center.x + _offestCenter.x;
        CGFloat originY = _center.y + _offestCenter.y;
        _center = (CGPoint){originX,originY};
        
        [self setNeedsDisplay];
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
  
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //  [self makeGradientColor:ctx];
    
    CGContextSetStrokeColorWithColor(ctx, self.strokeColor.CGColor);//画笔线的颜色
    CGContextSetLineWidth(ctx, 1.0);//线的宽度
    
    [self drawRoundWithContextRef:ctx];
    
    [self addAnimations];
}

- (void)addAnimations {
    CGFloat changeRadius = self.minimumRoundRadius;
    CGFloat standardRadius = MAX(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGPoint center = _center;
    
    for (int i = 0 ;changeRadius < standardRadius;i++) {
        
        CALayer* layer = [self templateLayer];
        [self.layer addSublayer:layer];
        
        /** core Graphics 创建路径 */
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddEllipseInRect(path, NULL, CGRectMake(center.x - changeRadius, center.y - changeRadius, changeRadius * 2, changeRadius * 2));
        BOOL reverses = i % 2 == 0 ? YES : NO;
        [layer addAnimation:[self getKeyframeAnimationWithPath:path reverses:reverses] forKey:@"PostionKeyframeValueAni"];
        CGPathRelease(path);
        
        changeRadius = changeRadius + 40;
    }
}

//画圆
- (void)drawRoundWithContextRef:(CGContextRef)ctx {
    CGPoint center = _center;
    /** 从最内层圆开始绘制 */
    

    CGFloat standardRadius = MAX(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    
    for (CGFloat radius = self.minimumRoundRadius;radius < standardRadius;radius = radius + 40) {
        CGContextAddArc(ctx, center.x, center.y, radius, 0, 2 * PI, 0);
        CGContextDrawPath(ctx, kCGPathStroke);
        
    }
}

- (CAKeyframeAnimation *)getKeyframeAnimationWithPath:(CGMutablePathRef)path reverses:(BOOL)reverses{
    CAKeyframeAnimation* keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.repeatCount = MAXFLOAT;
    keyFrameAnimation.repeatDuration = MAXFLOAT;
    //        keyFrameAnimation.autoreverses = YES;//翻转动画
    keyFrameAnimation.speed = 0.2;
      if (reverses) {
          keyFrameAnimation.speed = - keyFrameAnimation.speed;
      }
    keyFrameAnimation.calculationMode = kCAAnimationPaced;
    keyFrameAnimation.rotationMode = kCAAnimationRotateAuto;
    keyFrameAnimation.removedOnCompletion = NO;


    keyFrameAnimation.path = path;
 
    
    
    
    keyFrameAnimation.duration = 5;
    return keyFrameAnimation;
}


- (CALayer *)templateLayer {
    CALayer* layer = [[CALayer alloc]init];
    layer.backgroundColor = self.strokeColor.CGColor;
    int layerSize = (arc4random() % 4) + 8;
    
    layer.frame = (CGRect){{0,0},{layerSize,layerSize}};
    layer.cornerRadius = 5;
    return layer;
}

@end
