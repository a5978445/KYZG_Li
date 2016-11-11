//
//  QuestionsViewController.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/10.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "QuestionsViewController.h"
#import "TagButtons.h"
#import "QuestionsViewControllerModel.h"
#import "QuesAnsTableViewCell.h"

@interface QuestionsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) UITableView *tableView;
@property(strong,nonatomic) TagButtons *tagButtons;
@end

@implementation QuestionsViewController {
    QuestionsViewControllerModel *_model;
    QuestionsType _currentType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _model = [QuestionsViewControllerModel new];
    _currentType = QuestionsTypeQuestions;
    
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
    __weak QuestionsViewController *weakSelf = self;
    _tagButtons = [[TagButtons alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    [_tagButtons setTitles:@[@"提问",@"分享",@"综合",@"职业",@"站务"]];
    _tagButtons.block = ^(NSInteger tag) {
        [weakSelf changeTag:tag];
    };
    [self.view addSubview:_tagButtons];
}

- (void)addTableView {
    __weak QuestionsViewController *weakSelf = self;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf dropDownRefresh];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullRefresh)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - private method
- (void)changeTag:(NSUInteger)tag {
    _currentType = tag;
    if ([_model questionModelsWithQuestionsType:_currentType].count == 0) {
        [self.tableView.mj_header beginRefreshing];
    }
    [self.tableView reloadData];
}

- (NSUInteger)getTagWithQuestionsType:(QuestionsType)type {
   
    return type + 1;
}

- (void)dropDownRefresh {
    __weak QuestionsViewControllerModel *weakModel = _model;
    __weak QuestionsViewController *weakSelf = self;
    
    QuestionsType type = _currentType;
    NSMutableURLRequest *request = [self questionRequestWithParameters:@{@"catalog" : @([self getTagWithQuestionsType:_currentType])}];
    AFURLSessionManager *manager = defaultAPPSessionManager();
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [Utils showHUDWithText:error.domain];
            
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            if ([dic[@"code"] isEqual:@(1)]) {

                [weakModel updateModelsWithDic:dic[@"result"] questionsType:type];
                
            } else {
                [Utils showHUDWithText:dic[@"message"]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView.mj_header endRefreshing];
                [weakSelf.tableView reloadData];
            });
        }
    }];
    [dataTask resume];

}

- (void)pullRefresh {
    __weak QuestionsViewControllerModel *weakModel = _model;
    __weak QuestionsViewController *weakSelf = self;
    
    QuestionsType type = _currentType;
    NSMutableURLRequest *request = [self questionRequestWithParameters:@{@"catalog":@(_currentType)}];
    AFURLSessionManager *manager = defaultAPPSessionManager();
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [Utils showHUDWithText:error.domain];
            
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            if ([dic[@"code"] isEqual:@(1)]) {
                
                [weakModel addModelsWithDic:dic[@"result"] questionsType:type];
                
            } else {
                [Utils showHUDWithText:dic[@"message"]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView.mj_footer endRefreshing];
                [weakSelf.tableView reloadData];
            });
        }
    }];
    [dataTask resume];
}

- (NSMutableURLRequest *)questionRequestWithParameters:(NSDictionary *)parameters {
   NSString *urlStr = [NSString stringWithFormat:@"%@question",OSCAPI_V2_PREFIX];
    return [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                         URLString:urlStr
                                                        parameters:parameters
                                                             error:nil];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_model questionModelsWithQuestionsType:_currentType].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuesAnsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"QuesAnsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    cell.viewModel = [_model questionModelsWithQuestionsType:_currentType][indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
//    }
//   // cell.model = [_model blogModelsWithBlogType:_currentBlogType][indexPath.row];
//    
//    
//    return cell.cellHeight;
    return 130;
}

@end
