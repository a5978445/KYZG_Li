//
//  BannerScrollView.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/4.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "BannerScrollView.h"
#import <UIImageView+WebCache.h>

#define FIRE_TIMER 5.0f
@interface BannerScrollView()<UIScrollViewDelegate>

@end

@implementation BannerScrollView {
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
    NSArray *_URLs;
    
    NSMutableArray<UIImageView *> *_imageViews;
    NSTimer *_timer;
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
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        _pageControl = [UIPageControl new];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = RGB(74, 210, 240);
        [self addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.bottom.offset(0);
        }];
        
        _imageViews = [NSMutableArray new];
        
    }
    return self;
}

#pragma mark - public method
- (void)setIamgeURLs:(NSArray<NSString *> *)URLs {
    if ([_URLs isEqual:URLs]) {
        return;
    }
    
    if (_URLs.count == URLs.count) {
        _URLs = URLs;
        [self updateImage];
    } else {
        
        _URLs = URLs;
        [self removeImageViews];
        
        [self addImageViews];
        
        [self updateImage];
    }
    
    [self resetViewStates];
    
    [self resetTimer];
    
}

- (void)cancelTimer {
    [_timer invalidate];
}

- (void)restartTimer {
    [_timer invalidate];
    
    [self resetTimer];
    
}

#pragma mark - timer fire
- (void)fire:(NSTimer *)timer {
    NSLog(@"timer fire");
    
    if (_pageControl.currentPage + 1 == _pageControl.numberOfPages) {
        _pageControl.currentPage = 0;
        [_scrollView setContentOffset:CGPointMake(0, 0)];
    } else {
        _pageControl.currentPage ++;
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width * _pageControl.currentPage, 0) animated:YES];
    }
}

#pragma mark - private method
- (void)removeImageViews {
    for (UIImageView *imageView in _imageViews) {
        [imageView removeFromSuperview];
    }
    [_imageViews removeAllObjects];
}

- (void)addImageViews {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    [_scrollView setContentSize:CGSizeMake(width * _URLs.count, height)];
    for (int i = 0; i < _URLs.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * width, 0, width, height)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
        [_scrollView addSubview:imageView];
        [_imageViews addObject:imageView];
    }
}

- (void)updateImage {
    for (int i = 0; i < _URLs.count; i++) {
        UIImageView *imageView = _imageViews[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:_URLs[i]]];
    }
}

- (void)resetViewStates {
    _pageControl.numberOfPages = _URLs.count;
    _pageControl.currentPage = 0;
    [_scrollView setContentOffset:CGPointMake(0, 0)];
}

- (void)resetTimer {
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:FIRE_TIMER target:self selector:@selector(fire:) userInfo:nil repeats:YES];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _timer.fireDate = [_timer.fireDate dateByAddingTimeInterval:MAXFLOAT];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
 //   NSLog(@"hello!");
    _pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
    _timer.fireDate = [[NSDate date] dateByAddingTimeInterval:FIRE_TIMER];
}

#pragma mark - imageView tapGestureRecognizer
- (void)tap:(UITapGestureRecognizer *)tapGestureRecognizer {
    NSInteger tag = tapGestureRecognizer.view.tag;
    if (_block) {
        _block(tag);
    }
}

@end
