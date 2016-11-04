//
//  LoginViewController.m
//  
//
//  Created by 李腾芳 on 16/10/26.
//
//

#import "LoginViewController.h"
#import "GDataXMLNode.h"
#import "ParsingXML.h"
#import "OSCUser.h"
#import "Utils.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loginNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)login:(id)sender;

@end

@implementation LoginViewController {
    MBProgressHUD *_loginHud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";

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


#pragma mark - action's
- (IBAction)login:(id)sender {
    [self hideButton];
   
    _loginHud = [Utils createHUD];
    _loginHud.label.text = @"正在登陆，请稍后。。。";
    [_loginHud showAnimated:YES];
    
    NSMutableURLRequest *request = [self getLoginRequest];
  
    AFURLSessionManager *manager = defaultAPPSessionManager();
   
    __weak MBProgressHUD *weakLoginHud = _loginHud;
    __weak LoginViewController *weakSelf = self;
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        [weakLoginHud hideAnimated:YES];
        if (error) {
            NSLog(@"Error: %@", error);
            // to do :向用户报告错误
            [weakSelf showHudWithMessage:error.domain];
        } else {
            //  NSLog(@"%@ %@", response, responseObject);
            
            ParsingXML *p = [[ParsingXML alloc]initWithData:responseObject];
            NSLog(@"%@",p.dic);
            NSDictionary *resultDic = p.dic[@"oschina"][@"result"];
            NSNumber *errCode = resultDic[@"errorCode"];
            if (errCode.intValue != 1) {
                [weakSelf showHudWithMessage:resultDic[@"errorMessage"]];
            } else {
                [UserInfo myUserInfo].user = [[OSCUser alloc]initWithLoginDic:p.dic];
                [self saveCookies];
                [weakSelf.navigationController popViewControllerAnimated:YES];
                NSLog(@"登录成功");
                [[NSNotificationCenter defaultCenter]postNotificationName:UPDATE_USER_INFO object:nil];
            }
            
            
        }
        
    }];
    [dataTask resume];
}

#pragma mark -touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hideButton];
}

#pragma mark - private method
- (void)showHudWithMessage:(NSString *)title {
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.label.text = title;
    hud.mode = MBProgressHUDModeText;
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2.0f];
}



- (void)hideButton {
    [_loginNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}


- (NSMutableURLRequest *)getLoginRequest {
    NSString *URLString = [NSString stringWithFormat:@"%@%@", OSCAPI_HTTPS_PREFIX , OSCAPI_LOGIN_VALIDATE];
     NSDictionary *parameters = @{@"username": @"510491354@qq.com", @"pwd": @"qq1634",@"keep_login":@(1)};
   // NSDictionary *parameters = @{@"username": _loginNameTextField.text, @"pwd": _passwordTextField.text,@"keep_login":@(1)};
    return [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
}

- (void)saveCookies {
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"sessionCookies"];
    [defaults synchronize];
    
}

@end
