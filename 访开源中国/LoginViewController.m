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

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loginNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)login:(id)sender;

@end

@implementation LoginViewController

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
   
    NSMutableURLRequest *request = [self getLoginRequest];
  
    AFURLSessionManager *manager = defaultAPPSessionManager();
   
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            // to do :向用户报告错误
        } else {
            //  NSLog(@"%@ %@", response, responseObject);
            
            ParsingXML *p = [[ParsingXML alloc]initWithData:responseObject];
            NSLog(@"%@",p.dic);
            NSDictionary *resultDic = p.dic[@"oschina"][@"result"];
            NSNumber *errCode = resultDic[@"errorCode"];
            if (errCode.intValue != 1) {
                [self showHudWithMessage:resultDic[@"errorMessage"]];
            } else {
                [UserInfo myUserInfo].user = [[OSCUser alloc]initWithLoginDic:p.dic];
                [self.navigationController popViewControllerAnimated:YES];
                NSLog(@"登录成功");
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
    // NSDictionary *parameters = @{@"username": @"bar", @"pwd": @"1234",@"keep_login":@(1)};
    NSDictionary *parameters = @{@"username": _loginNameTextField.text, @"pwd": _passwordTextField.text,@"keep_login":@(1)};
    return [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
}
@end
