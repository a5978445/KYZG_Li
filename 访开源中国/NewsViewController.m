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

@interface NewsViewController () {
    BannerScrollView *_headView;
   __block NSArray<NSDictionary *> *items;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _headView = [[BannerScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 39 /125)];
    _headView.block = ^(NSInteger tag) {
        NSLog(@"tag = %ld",(long)tag);
    };

    self.tableView.tableHeaderView = _headView;
    
    [self getBannerData];
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
- (void)getBannerData{
  
    NSMutableURLRequest *request = [self bannerDataRequest];
    AFURLSessionManager *manager = defaultAPPSessionManager();
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [Utils showHUDWithText:error.domain];
            
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dic[@"code"] isEqual:@(1)]) {
                items = dic[@"result"][@"items"];
                /*
                 {
                 detail = "";
                 href = "https://www.oschina.net/question/2720166_2203951";
                 id = 2203951;
                 img = "http://static.oschina.net/uploads/cooperation/75410/google-beta-natural-language-api_9923790c-e15f-455f-bdf8-a2040e927c10.jpg";
                 name = "Linux \U8fd0\U7ef4\U6700\U4f73\U5b9e\U8df5";
                 pubDate = "2016-11-03 15:51:21";
                 type = 2;
                 },
                 */
                NSLog(@"%@",dic);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_headView setIamgeURLs:self.imageURLs];
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

- (NSArray<NSString *> *)imageURLs {
    NSMutableArray *result = [NSMutableArray new];
    for (NSDictionary *dic in items) {
        [result addObject:dic[@"img"]];
    }
    return  result;
}

@end
