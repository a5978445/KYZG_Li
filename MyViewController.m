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
#import "ParsingXML.h"
#import "Utils.h"
#import "SingleImageViewController.h"
#import <MJRefresh.h>
#import "SettingViewController.h"

@interface MyViewController ()<MyHeaderViewDelegate,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    CombinationHeadView *_headView;
   
    NSArray<TableViewDataModel *> *_dataModels;
}
@property(strong,nonatomic)  UITableView *tableView;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initDataModel];
    [self addSubViews];
    
    if ([UserInfo myUserInfo].user) {
        [self refresh];
    }
    
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    _tableView.mj_header.backgroundColor = RGB(50, 205, 100);
    ((MJRefreshNormalHeader *)_tableView.mj_header).stateLabel.textColor = [UIColor whiteColor];
    ((MJRefreshNormalHeader *)_tableView.mj_header).lastUpdatedTimeLabel.hidden = YES;
    
    //  [_tableView.header beginRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUSerInfo) name:UPDATE_USER_INFO object:nil];

}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    _headView.user = [UserInfo myUserInfo].user;
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

#pragma mark - Observer's
- (void)updateUSerInfo {
    [self refresh];
}

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
    if ([UserInfo myUserInfo].user) {
        
        [self showPortraitAlertView];
        
    } else {
        
        [self showLoginCtrl];
    }
}

- (void)config {
    SettingViewController *p = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:p animated:YES];
}

- (void)showQRCode {
    if ([UserInfo myUserInfo].user == nil) {
        [self showLoginCtrl];
    } else {
        
        [self showQRHud];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"%@",info);
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSData *data = UIImageJPEGRepresentation(image, 0.7f);
    [self updatePortraitWithData:data];
}

#pragma mark init method
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
    _headView.user = [UserInfo myUserInfo].user;
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

#pragma mark - private method

- (void)showQRHud {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView.backgroundColor = [UIColor whiteColor];
    
    hud.label.text = @"扫一扫上面的二维码，加我为好友";
    hud.label.font = [UIFont systemFontOfSize:13];
    hud.label.textColor = [UIColor grayColor];
    hud.customView = self.myQRCodeImageView;
    [hud addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideHUD:)]];
}

- (void)showPortraitAlertView {
    UIAlertController *p = [UIAlertController alertControllerWithTitle:@"选择操作" message:nil preferredStyle:UIAlertControllerStyleAlert];
    // 更换头像 查看大头像  取消
    [p addAction:[UIAlertAction actionWithTitle:@"更换头像" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showPhotoSlectAlertView];
    }]];
    
    [p addAction:[UIAlertAction actionWithTitle:@"查看大头像" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        if ([UserInfo myUserInfo].user.portrait.length == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"尚未设置头像"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"知道了"
                                                      otherButtonTitles: nil];
            [alertView show];
        } else {
            
            NSArray *array1 = [[UserInfo myUserInfo].user.portrait componentsSeparatedByString:@"_"];
            
            NSArray *array2 = [array1[1] componentsSeparatedByString:@"."];
            
            NSString *bigPortraitURL = [NSString stringWithFormat:@"%@_200.%@", array1[0], array2[1]];
            
            SingleImageViewController *imgViewweVC = [[SingleImageViewController alloc] initWithURL:[NSURL URLWithString:bigPortraitURL]];
            
            [self presentViewController:imgViewweVC animated:YES completion:nil];
        }
    }]];
    
    [p addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:p animated:NO completion:nil];
}

- (void)showPhotoSlectAlertView {
    UIAlertController *p = [UIAlertController alertControllerWithTitle:@"选择操作" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [p addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showCameraCtrl];
    }]];
    
    [p addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showPhotoSelectCtrl];
    }]];
    
    [p addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:p animated:NO completion:nil];
}


- (void)showCameraCtrl {
    UIImagePickerController *p = [[UIImagePickerController alloc]init];
    p.sourceType = UIImagePickerControllerSourceTypeCamera;
    p.allowsEditing = YES;
    p.delegate = self;
    [self presentViewController:p animated:YES completion:nil];
}

- (void)showPhotoSelectCtrl {
    UIImagePickerController *p = [[UIImagePickerController alloc]init];
    p.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    p.allowsEditing = YES;
    p.delegate = self;
    [self presentViewController:p animated:YES completion:nil];
}

- (void)showLoginCtrl {
    LoginViewController *p = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:p animated:YES];
}

- (UIImageView *)myQRCodeImageView {
    
    UIImage *myQRCode = [Utils createQRCodeFromString:[NSString stringWithFormat:@"http://my.oschina.net/u/%ld", (long)[UserInfo myUserInfo].user.userID]];
    return [[UIImageView alloc] initWithImage:myQRCode];
}



- (void)hideHUD:(UIGestureRecognizer *)recognizer {
    [(MBProgressHUD *)recognizer.view hideAnimated:YES];
}


- (NSMutableURLRequest *)getUpdatePortraitRequestWithData:(NSData *)data{
    NSString *URLString = [NSString stringWithFormat:@"%@user_edit_portrait", OSCAPI_V2_PREFIX];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:@{@"uid":@([UserInfo myUserInfo].user.userID)} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data
                                    name:@"portrait"
                                fileName:@"img.jpg"
                                mimeType:@"image/jpeg"];
    } error:nil];

    return request;
}

- (NSMutableURLRequest *)getUserInfoRequest {
    NSString *URLString = [NSString stringWithFormat:@"%@user_info", OSCAPI_V2_PREFIX];
    return [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:nil error:nil];
}

- (void)refresh {
    __weak CombinationHeadView *weakHeadView = _headView;
    __weak MyViewController *weakSelf = self;
    NSMutableURLRequest *request = [self getUserInfoRequest];
    
    AFURLSessionManager *manager = defaultAPPSessionManager();
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [Utils showHUDWithText:error.domain];
            
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dic[@"code"] isEqual:@(1)]) {
                OSCUser *info = [[OSCUser alloc]initWithUserInfoDic:dic];
                [UserInfo myUserInfo].user = info;
                weakHeadView.user = info;
                NSLog(@"%@",info);
            } else {
               // [Utils showHUDWithText:dic[@"message"]];
                UIAlertController *p = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"刷新用户数据失败，请重新登陆" preferredStyle:UIAlertControllerStyleAlert];
                [p addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf showLoginCtrl];
                }]];
                [weakSelf presentViewController:p animated:YES completion:nil];
                
            }
        }
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    [dataTask resume];
    
}

- (void)updatePortraitWithData:(NSData *)data {
    
    AFURLSessionManager *manager = defaultAPPSessionManager();
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:[self getUpdatePortraitRequestWithData:data]
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                          if ([dic[@"code"] isEqual:@(1)]) { // sucess
                              OSCUser *user = [[OSCUser alloc]initWithUserInfoDic:dic];
                              [UserInfo myUserInfo].user = user;
                              _headView.user = user;
                          } else {
                              NSLog(@"%@",dic[@"message"]);
                          }

                      }
                  }];
    
    [uploadTask resume];
}

@end
