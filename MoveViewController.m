//
//  MoveViewController.m
//  访开源中国
//
//  Created by 李腾芳 on 16/10/24.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "MoveViewController.h"
#import "TransverseButtonsView.h"

@interface MoveViewController () {
    TransverseButtonsView *_buttonsView;
}

@end

@implementation MoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"动弹";
    self.view.backgroundColor = [UIColor whiteColor];
    _buttonsView = [[TransverseButtonsView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    [self.view addSubview:_buttonsView];
    [_buttonsView setTitles:@[@"最新动弹",@"热门动弹",@"我的动弹"]];
    [_buttonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(44);
        make.top.offset(64);
    }];
    _buttonsView.backgroundColor = [UIColor redColor];
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
