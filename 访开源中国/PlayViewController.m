//
//  PlayViewController.m
//  访开源中国
//
//  Created by 李腾芳 on 16/10/24.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "PlayViewController.h"
#import "PlaceholderTextView.h"

@interface PlayViewController ()<UITextViewDelegate> {
    PlaceholderTextView *_textView;
}

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"弹一弹";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sender)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self addSubViews];
}

- (void)addSubViews {
    _textView = [[PlaceholderTextView alloc]init];
    _textView.placeholder = @"今天你动弹了吗";
    _textView.delegate = self;
    [self.view addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

- (void)sender {
    
}

- (void)cancel {
    [_textView endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length > 0;
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
