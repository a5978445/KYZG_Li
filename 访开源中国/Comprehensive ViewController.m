//
//  Comprehensive ViewController.m
//  访开源中国
//
//  Created by 李腾芳 on 16/10/24.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "Comprehensive ViewController.h"
#import "TransverseButtonsView.h"
#import "NewsViewController.h"
@interface Comprehensive_ViewController ()

@end

@implementation Comprehensive_ViewController {
    TransverseButtonsView *_buttonsView;
    
    NewsViewController *_newsViewController;
    UIView *_currentView;
    UIViewController *_currentCtrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"综合";
    
    
    _buttonsView = [[TransverseButtonsView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    [self.view addSubview:_buttonsView];
    [_buttonsView setTitles:@[@"资讯",@"博客",@"问答",@"发现"]];
    [_buttonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(44);
        make.top.offset(64);
    }];
    
    _newsViewController = [[NewsViewController alloc]init];
    _currentView = _newsViewController.view;
    _currentCtrl = _newsViewController;
     [self.view addSubview:_currentView];
    [_currentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.equalTo(_buttonsView.mas_bottom);
        make.bottom.offset(0);
    }];
   
   // _buttonsView.backgroundColor = [UIColor redColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_currentCtrl viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_currentCtrl viewWillDisappear:animated];
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

@end
