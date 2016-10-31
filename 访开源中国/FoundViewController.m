//
//  FoundViewController.m
//  访开源中国
//
//  Created by 李腾芳 on 16/10/24.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "FoundViewController.h"
#import "TableViewDataModel.h"
@interface FoundViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;
    NSArray<NSArray<TableViewDataModel *> *> *_models;
}

@end

@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发现";
   
    [self addTableView];
    
    [self initModels];//search
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar-search"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];

}

- (void)search {
    
}

- (void)addTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:235.0f/255 green:235.0f/255 blue:243.0f/255 alpha:1.0f];
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

- (void)initModels {
    TableViewDataModel *model_0_0 = [[TableViewDataModel alloc]initWithTitle:@"开源软件" imageName:@"ic_discover_softwares" selectBlock:^{
        
    }];
    
    TableViewDataModel *model_1_0 = [[TableViewDataModel alloc]initWithTitle:@"找人" imageName:@"ic_discover_find" selectBlock:^{
        
    }];
    
    TableViewDataModel *model_2_0 = [[TableViewDataModel alloc]initWithTitle:@"扫一扫" imageName:@"ic_discover_scan" selectBlock:^{
        
    }];
    
    TableViewDataModel *model_2_1 = [[TableViewDataModel alloc]initWithTitle:@"摇一摇" imageName:@"ic_discover_shake" selectBlock:^{
        
    }];
    
    _models = @[@[model_0_0],
                @[model_1_0],
                @[model_2_0,model_2_1]];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models[section].count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    cell.backgroundColor = [UIColor cellsColor];
    cell.textLabel.textColor = [UIColor titleColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor selectCellSColor];
    
    TableViewDataModel *model = _models[indexPath.section][indexPath.row];
    cell.textLabel.text = model.title;
    cell.imageView.image = [UIImage imageNamed:model.imageName];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 23;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}


@end
