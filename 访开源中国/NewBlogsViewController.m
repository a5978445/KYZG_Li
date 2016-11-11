//
//  NewBlogsViewController.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/9.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "NewBlogsViewController.h"
#import "TagButtons.h"
#import "OSCNewHotBlog.h"
#import "NewBlogsViewControllerModel.h"
#import "NewsTableViewCell.h"

@interface NewBlogsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) UITableView *tableView;
@property(strong,nonatomic) NewBlogsViewControllerModel *model;
@end

@implementation NewBlogsViewController {

    BlogType _currentBlogType;
    TagButtons *_tagButtons;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _model = [NewBlogsViewControllerModel new];
    
    _currentBlogType = BlogTypeRecommend;
    
    [self addSubViews];
    [self addLayoutSubViews];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)addSubViews {
    [self addTagButtons];
    [self addTableView];
}

- (void)addLayoutSubViews {
    [_tagButtons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.right.offset(0);
        make.left.offset(0);
        make.height.offset(44);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tagButtons.mas_bottom);
        make.right.offset(0);
        make.left.offset(0);
        make.bottom.offset(0);
    }];
}

- (void)addTagButtons {
    __weak NewBlogsViewController *weakSelf = self;
    _tagButtons = [[TagButtons alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    [_tagButtons setTitles:@[@"最新推荐",@"本周热门",@"最新博客"]];
    _tagButtons.block = ^(NSInteger tag) {
        [weakSelf changeTag:tag];
    };
    [self.view addSubview:_tagButtons];
}

- (void)addTableView {
    __weak NewBlogsViewController *weakSelf = self;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    // self.tableView.tableHeaderView = button;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf dropDownRefresh];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullRefresh)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeTag:(NSInteger)tag {
    _currentBlogType = tag;
    if ([_model blogModelsWithBlogType:tag].count == 0) {
        [self.tableView reloadData];
        [self.tableView.mj_header beginRefreshing];
    } else {
        [self.tableView reloadData];
    }
}

#pragma mark - NetWorking
- (void)dropDownRefresh {
    __weak NewBlogsViewController *weakSelf = self;
    AFURLSessionManager *manager = defaultAPPSessionManager();
    BlogType type = _currentBlogType;
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:[self blogRequestWithParameters:@{@"catalog":@([self getTagWithBlogType:_currentBlogType])}] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            [Utils showHUDWithText:error.domain];
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dic[@"code"] isEqual:@(1)]) { //sucess
                NSDictionary* result = dic[@"result"];
                [weakSelf.model updateModelsWithDic:result blogType:type];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView.mj_header endRefreshing];
                });
                
                NSLog(@"%@",dic);
            } else {
                [Utils showHUDWithText:dic[@"message"]];
            }
        }
    }];
    [task resume];
}

- (void)pullRefresh {
    __weak NewBlogsViewController *weakSelf = self;
    AFURLSessionManager *manager = defaultAPPSessionManager();
    BlogType type = _currentBlogType;
    NSDictionary *dic = @{@"catalog":@([self getTagWithBlogType:_currentBlogType]),
                          @"pageToken":[self.model nextPageTokenWithBlogType:_currentBlogType ]};
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:[self blogRequestWithParameters:dic] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            [Utils showHUDWithText:error.domain];
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dic[@"code"] isEqual:@(1)]) { //sucess
                NSDictionary* result = dic[@"result"];
                [weakSelf.model updateModelsWithDic:result blogType:type];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView.mj_footer endRefreshing];
                });
                
                NSLog(@"%@",dic);
            } else {
                [Utils showHUDWithText:dic[@"message"]];
            }
        }
    }];
    [task resume];
}


- (NSUInteger)getTagWithBlogType:(BlogType)type {
    switch (type) {
        case BlogTypeRecommend:
            return 3;
            break;
        case BlogTypeHot:
            return 2;
            break;
        case BlogTypeNew:
            return 1;
            break;

    }
}

- (NSMutableURLRequest *)blogRequestWithParameters:(NSDictionary *)parameters {
    NSString *url = [NSString stringWithFormat:@"%@blog",OSCAPI_V2_PREFIX];
    
    return [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                         URLString:url
                                                        parameters:parameters
                                                             error:nil];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_model blogModelsWithBlogType:_currentBlogType].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.model = [_model blogModelsWithBlogType:_currentBlogType][indexPath.row];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    if (cell == nil) {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
    }
    cell.model = [_model blogModelsWithBlogType:_currentBlogType][indexPath.row];

    
    return cell.cellHeight;
}

@end
