//
//  SettingViewController.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/3.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController () {
    NSArray<NSArray<NSString *> *> *_dataModels;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([UserInfo myUserInfo].user) {
        _dataModels = @[@[@"清除缓存"],
                       @[@"应用评分",@"关于我们",@"开源许可",@"问题反馈"],
                       @[@"注销登录"]];
    } else {
        _dataModels = @[@[@"清除缓存"],
                       @[@"应用评分",@"关于我们",@"开源许可",@"问题反馈"]];
    }
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = RGB(235, 235, 243);
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataModels[section].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _dataModels[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 0) {
        [[UserInfo myUserInfo] clearUser];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
