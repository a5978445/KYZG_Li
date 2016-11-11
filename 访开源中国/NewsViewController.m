//
//  NewsViewController.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/4.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "NewsViewController.h"
#import "Utils.h"
#import "BannerScrollView.h"
#import "OSCInformation.h"
#import "NewsViewControllerModel.h"
#import "NewsTableViewCell.h"
#import <MJRefresh.h>

@interface NewsViewController () {
    BannerScrollView *_headView;
    NewsViewControllerModel *_model;
    NSString *_nextPageToken;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _model = [NewsViewControllerModel new];
    
    _headView = [[BannerScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 39 /125)];
    _headView.block = ^(NSInteger tag) {
        NSLog(@"tag = %ld",(long)tag);
    };
    
    self.tableView.tableHeaderView = _headView;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    __weak NewsViewController *weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getBannerData];
        
        [weakSelf dropDownRefresh];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf pullRefresh];
    }];
    
   
    [self.tableView.mj_header beginRefreshing];
    
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_headView restartTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_headView cancelTimer];
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
#pragma mark - private method
- (void)getBannerData {
    
    __weak NewsViewControllerModel *weakModel = _model;
    
    NSMutableURLRequest *request = [self bannerDataRequest];
    AFURLSessionManager *manager = defaultAPPSessionManager();
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [Utils showHUDWithText:error.domain];
            
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dic[@"code"] isEqual:@(1)]) {
                [weakModel setNewsImageURLsWithDictionaryArray:dic[@"result"][@"items"] ];
            
                NSLog(@"%@",dic);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_headView setIamgeURLs:weakModel.newsImageURLs];
                });
            } else {
                [Utils showHUDWithText:dic[@"message"]];
                
                
            }
        }
    }];
    [dataTask resume];
}

- (NSMutableURLRequest *)bannerDataRequest {
    NSString* urlStr = [NSString stringWithFormat:@"%@banner", OSCAPI_V2_PREFIX];
    
    return [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                         URLString:urlStr
                                                        parameters:@{@"catalog" : @1}
                                                             error:nil];
}

- (NSMutableURLRequest *)newsRequest:(NSDictionary *)parameters {
    NSString *urlStr = [NSString stringWithFormat:@"%@news",OSCAPI_V2_PREFIX];
    
    return [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                         URLString:urlStr
                                                        parameters:parameters
                                                             error:nil];
}

- (void)pullRefresh {
    __weak NewsViewControllerModel *weakModel = _model;
    __weak NewsViewController *weakSelf = self;
    
    AFURLSessionManager *manager = defaultAPPSessionManager();
    NSMutableURLRequest *request = [self newsRequest:@{@"pageToken":_nextPageToken}];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [Utils showHUDWithText:error.domain];
            
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dic[@"code"] isEqual:@(1)]) { //sucess
                [weakModel addInformationsWithDictionaryArray:dic[@"result"][@"items"]];
                
//                NSString *prevPageToken = dic[@"result"][@"prevPageToken"];
//                NSString *nextPageToken = dic[@"result"][@"nextPageToken"];
//                NSLog(@"%@",dic);
                _nextPageToken = dic[@"result"][@"nextPageToken"];
              //  NSLog(@"%@",dic);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView.mj_footer endRefreshing];
                });
                
                
            } else {
                [Utils showHUDWithText:dic[@"message"]];
            }
        }
    }];
    [dataTask resume];
    
}

- (void)dropDownRefresh {
    __weak NewsViewControllerModel *weakModel = _model;
    __weak NewsViewController *weakSelf = self;
    
    AFURLSessionManager *manager = defaultAPPSessionManager();
    NSMutableURLRequest *request = [self newsRequest:nil];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [Utils showHUDWithText:error.domain];
            
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dic[@"code"] isEqual:@(1)]) { //sucess
                [weakModel setInformationsWithDictionaryArray:dic[@"result"][@"items"]];
                
                //                NSString *prevPageToken = dic[@"result"][@"prevPageToken"];
                //                NSString *nextPageToken = dic[@"result"][@"nextPageToken"];
                //                NSLog(@"%@",dic);
                _nextPageToken = dic[@"result"][@"nextPageToken"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView.mj_header endRefreshing];
                });
                
                
            } else {
                [Utils showHUDWithText:dic[@"message"]];
                
                
            }
        }
    }];
    [dataTask resume];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.cellModels.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.model = _model.cellModels[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    if (cell == nil) {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        
    }
    cell.model = _model.cellModels[indexPath.row];
    return cell.cellHeight;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
