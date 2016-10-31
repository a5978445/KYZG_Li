//
//  RootTabBarViewController.m
//  访开源中国
//
//  Created by 李腾芳 on 16/10/24.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "MyViewController.h"
#import "FoundViewController.h"
#import "PlayViewController.h"
#import "MoveViewController.h"
#import "Comprehensive ViewController.h"
#import "RootNavigationController.h"

@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController {
    UIButton *_centerButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addControllers];
    
    [self configTabBar];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"%@",self.tabBar.subviews);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
- (void)addControllers {
    Comprehensive_ViewController *p1 = [[Comprehensive_ViewController alloc]init];
    RootNavigationController *nav1 = [[RootNavigationController alloc]initWithRootViewController:p1];
    MoveViewController *p2 = [[MoveViewController alloc]init];
    RootNavigationController *nav2 = [[RootNavigationController alloc]initWithRootViewController:p2];
    UIViewController *p3 =  [[UIViewController alloc]init];
    FoundViewController *p4 = [[FoundViewController alloc]init];
    RootNavigationController *nav4 = [[RootNavigationController alloc]initWithRootViewController:p4];
    MyViewController *p5 = [[MyViewController alloc]init];
    RootNavigationController *nav5 = [[RootNavigationController alloc]initWithRootViewController:p5];
    
    self.viewControllers = @[nav1,nav2,p3,nav4,nav5];
}

- (void)configTabBar {
    NSArray *titles = @[@"综合", @"动弹", @"", @"发现", @"我的"];
    NSArray *images = @[@"tabbar-news", @"tabbar-tweet", @"", @"tabbar-discover", @"tabbar-me"];
    for (int i = 0; i < self.tabBar.items.count; i++) {
        UITabBarItem *item = self.tabBar.items[i];
        item.title = titles[i];
        //        item.image = [UIImage imageNamed:images[i]];
        //        NSLog(@"%@",[UIImage imageNamed:[images[i] stringByAppendingString:@"-selected"]]);
        //        item.selectedImage = [UIImage imageNamed:[images[i] stringByAppendingString:@"-selected"]];
        
        //图片render模式有两种：一种按原图颜色填充，另一种忽略原图颜色
        item.image = [[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:[images[i] stringByAppendingString:@"-selected"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
    }
    self.tabBar.items[2].enabled = NO;
    
    self.tabBar.selectedImageTintColor = [UIColor colorWithRed:50/255.0f green:205/255.0 blue:100/255.0 alpha:1.0];
    [self addCenterButton];
}

- (void)addCenterButton {
    _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGPoint origin = [self.view convertPoint:self.tabBar.center toView:self.tabBar];
    CGSize buttonSize = CGSizeMake(self.tabBar.frame.size.width / 5 - 6, self.tabBar.frame.size.height - 4);
    
    _centerButton.frame = CGRectMake(origin.x - buttonSize.height/2, origin.y - buttonSize.height/2, buttonSize.height, buttonSize.height);
    
    
    [_centerButton setImage:[UIImage imageNamed:@"ic_nav_add"] forState:UIControlStateNormal];
    [_centerButton setImage:[UIImage imageNamed:@"ic_nav_add_actived"] forState:UIControlStateHighlighted];
    [_centerButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
  
    
    [self.tabBar addSubview:_centerButton];
   
}

- (void)buttonPressed {
    PlayViewController *tweetEditingVC = [PlayViewController new];
    RootNavigationController *tweetEditingNav = [[RootNavigationController alloc] initWithRootViewController:tweetEditingVC];
    [self.selectedViewController presentViewController:tweetEditingNav animated:YES completion:nil];
    
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
