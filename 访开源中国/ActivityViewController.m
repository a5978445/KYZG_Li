//
//  ActivityViewController.m
//  访开源中国
//
//  Created by 李腾芳 on 16/11/10.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityViewControllerModel.h"
#import "ActivityBannerScrollView.h"
#import "OSCActivities.h"
#import "OSCActivityTableViewCell.h"

@interface ActivityViewController ()
@property(strong,nonatomic) ActivityBannerScrollView *headView;
@end

@implementation ActivityViewController {
    ActivityViewControllerModel *_model;
    
    NSString *_nextPageToken;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _model = [ActivityViewControllerModel new];
   
    
    _headView = [[ActivityBannerScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 215.0f)];
    _headView.block = ^(NSInteger tag) {
        NSLog(@"tag = %ld",(long)tag);
    };
    
    self.tableView.tableHeaderView = _headView;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    __weak ActivityViewController *weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getBannerData];
        
        [weakSelf dropDownRefresh];
    }];

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf pullRefresh];
    }];
    
    
    [self.tableView.mj_header beginRefreshing];
    
    
}

- (void)dropDownRefresh {
    __weak ActivityViewControllerModel *weakModel = _model;
    __weak ActivityViewController *weakSelf = self;
    
    NSMutableURLRequest *request = [self eventRequestWithparameters:nil];
    AFURLSessionManager *manager = defaultAPPSessionManager();
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [Utils showHUDWithText:error.domain];
            
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            if ([dic[@"code"] isEqual:@(1)]) {
     
              //  NSLog(@"%@",dic);
                weakModel.activities = [OSCActivities mj_objectArrayWithKeyValuesArray:dic[@"result"][@"items"]];
                weakModel.nextPageToken = dic[@"result"][@"nextPageToken"];
              
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
    __weak ActivityViewControllerModel *weakModel = _model;
    __weak ActivityViewController *weakSelf = self;
    
    NSMutableURLRequest *request = [self eventRequestWithparameters:@{@"pageToken":_model.nextPageToken}];
    AFURLSessionManager *manager = defaultAPPSessionManager();
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [Utils showHUDWithText:error.domain];
            
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            if ([dic[@"code"] isEqual:@(1)]) {

                [weakModel.activities addObjectsFromArray:[OSCActivities mj_objectArrayWithKeyValuesArray:dic[@"result"][@"items"]]];
                weakModel.nextPageToken = dic[@"result"][@"nextPageToken"];
               
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

- (void)getBannerData {
    
    __weak ActivityViewControllerModel *weakModel = _model;
    __weak ActivityViewController *weakSelf = self;
    
    NSMutableURLRequest *request = [self bannerDataRequest];
    AFURLSessionManager *manager = defaultAPPSessionManager();
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [Utils showHUDWithText:error.domain];
            
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            if ([dic[@"code"] isEqual:@(1)]) {
                [weakModel setNewsImageURLsWithDictionaryArray:dic[@"result"][@"items"] ];
                
                NSLog(@"%@",dic);
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.headView.banners = weakModel.banners;
                });
            } else {
                [Utils showHUDWithText:dic[@"message"]];
                
                
            }
        }
    }];
    [dataTask resume];
}

- (NSMutableURLRequest *)bannerDataRequest {
    NSString* urlStr = [NSString stringWithFormat:@"%@banner",OSCAPI_V2_PREFIX];
    
    return [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                         URLString:urlStr
                                                        parameters:@{@"catalog" : @(3)}
                                                             error:nil];
}

- (NSMutableURLRequest *)eventRequestWithparameters:(NSDictionary *)parameters {
    NSString* urlStr = [NSString stringWithFormat:@"%@event",OSCAPI_V2_PREFIX];
    
    return [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                         URLString:urlStr
                                                        parameters:parameters
                                                             error:nil];

}

//-(void)getJsonDataWithParametersDic:(NSDictionary*)paraDic isRefresh:(BOOL)isRefresh{//yes 下拉 no 上拉
//    
//    if(isRefresh) {
//        [self getBannerData];
//    }
//    
//    NSMutableDictionary* paraMutableDic = @{}.mutableCopy;
//    if (!isRefresh && [self.nextToken length] > 0) {
//        [paraMutableDic setObject:self.nextToken forKey:@"pageToken"];
//    }
//    
//    [self.manager GET:self.generateUrl()
//           parameters:paraMutableDic.copy
//              success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                  if([responseObject[@"code"]integerValue] == 1) {
//                      [self handleData:responseObject isRefresh:isRefresh];
//                      NSDictionary* resultDic = responseObject[@"result"];
//                      NSArray* items = resultDic[@"items"];
//                      self.nextToken = resultDic[@"nextPageToken"];
//                      
//                      self.lastCell.status = items.count < 1 ? LastCellStatusFinished : LastCellStatusMore;
//                      
//                      if (self.tableView.mj_header.isRefreshing) {
//                          [self.tableView.mj_header endRefreshing];
//                      }
//                      if (!isRefresh) {
//                          if (items.count > 0) {
//                              [self.tableView.mj_footer endRefreshing];
//                          } else {
//                              [self.tableView.mj_footer endRefreshingWithNoMoreData];
//                          }
//                      }
//                      
//                      dispatch_async(dispatch_get_main_queue(), ^{
//                          
//                          [self.tableView reloadData];
//                      });
//                  }
//                  
//              }
//              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                  MBProgressHUD *HUD = [Utils createHUD];
//                  HUD.mode = MBProgressHUDModeCustomView;
//                  //                  HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
//                  HUD.detailsLabel.text = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
//                  
//                  [HUD hideAnimated:YES afterDelay:1];
//                  dispatch_async(dispatch_get_main_queue(), ^{
//                      self.lastCell.status = LastCellStatusError;
//                      if (self.tableView.mj_header.isRefreshing) {
//                          [self.tableView.mj_header endRefreshing];
//                      }
//                      [self.tableView reloadData];
//                  });
//              }
//     ];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.activities.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OSCActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
         [tableView registerNib:[UINib nibWithNibName:@"OSCActivityTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    cell.viewModel = _model.activities[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
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
