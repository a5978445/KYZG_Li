//
//  MyViewController.m
//  访开源中国
//
//  Created by 李腾芳 on 16/10/24.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "MyViewController.h"
#import "CombinationHeadView.h"
#import "TableViewDataModel.h"
#import "LoginViewController.h"

@interface MyViewController ()<MyHeaderViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    CombinationHeadView *_headView;
    UITableView *_tableView;
    NSArray<TableViewDataModel *> *_dataModels;
}

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initDataModel];
    [self addSubViews];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    _headView.isLogin = [UserInfo myUserInfo].user != nil ? YES : NO;
    CGRect frame = _headView.frame;
    frame.size.height = _headView.suggestHeight;
    _headView.frame = frame;
    _tableView.tableHeaderView = _headView;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
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
    return _dataModels.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.imageView.image = [UIImage imageNamed:_dataModels[indexPath.row].imageName];
    cell.textLabel.text = _dataModels[indexPath.row].title;
    return cell;
}


#pragma mark - MyHeaderViewDelegate
- (void)login {
    LoginViewController *p = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:p animated:YES];
}

#pragma mark - private method
- (void)addSubViews {
    
    [self initHeadView];
    
    [self initTableView];
    
}

- (void)initTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(-20);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
    }];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.tableHeaderView = _headView;
}

- (void)initHeadView {
    _headView = [[CombinationHeadView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 280)];
    _headView.isLogin = [UserInfo myUserInfo].user != nil ? YES : NO;
    _headView.backgroundColor = [UIColor redColor];
    _headView.delegate = self;
    
}

- (void)initDataModel {
    TableViewDataModel *model0 = [[TableViewDataModel alloc]initWithTitle:@"我的消息" imageName:@"ic_my_messege" selectBlock:^{
        
    }];
    TableViewDataModel *model1 = [[TableViewDataModel alloc]initWithTitle:@"我的博客" imageName:@"ic_my_blog" selectBlock:^{
        
    }];
    TableViewDataModel *model2 = [[TableViewDataModel alloc]initWithTitle:@"我的活动" imageName:@"ic_my_event" selectBlock:^{
        
    }];
    TableViewDataModel *model3 = [[TableViewDataModel alloc]initWithTitle:@"我的团队" imageName:@"ic_my_team" selectBlock:^{
        
    }];
    
    _dataModels = @[model0,model1,model2,model3];
    
}

@end
