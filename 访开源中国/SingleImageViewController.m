//
//  SingleImageViewController.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/2.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "SingleImageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface SingleImageViewController ()<UIScrollViewDelegate>
@property(strong,nonatomic) NSURL *imageURL;
@property(strong,nonatomic) UIImageView *imageView;
@property(strong,nonatomic) UIScrollView *scrollView;
@end

@implementation SingleImageViewController


- (instancetype)initWithURL:(NSURL *)imageURL {
    self = [super init];
    if (self) {
        _imageURL = imageURL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_scrollView];

    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    _scrollView.minimumZoomScale = 0.4f;
    _scrollView.maximumZoomScale = 2.5f;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
   // _scrollView.bouncesZoom = NO;
    _scrollView.delegate = self;
    
  
    _imageView = [[UIImageView alloc]init];
    _imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [_scrollView addSubview:_imageView];

    [_imageView sd_setImageWithURL:_imageURL];
    [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)]];
    
}

- (void)tap:(UITapGestureRecognizer *)gestureRecognizer {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}



- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.bounds.size.width > scrollView.contentSize.width ?
    (scrollView.bounds.size.width - scrollView.contentSize.width) / 2 : 0;
    
    CGFloat offsetY = scrollView.bounds.size.height > scrollView.contentSize.height ?
    (scrollView.bounds.size.height - scrollView.contentSize.height) / 2 : 0;
    
    _imageView.center = CGPointMake(scrollView.contentSize.width / 2 + offsetX,
                                    scrollView.contentSize.height / 2 + offsetY);
}

@end
