//
//  SiginViewController.m
//  Converge
//
//  Created by admin on 2017/9/5.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "SiginViewController.h"

@interface SiginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *verLabel;
@property (weak, nonatomic) IBOutlet UIButton *siginBtn;
- (IBAction)siginAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (strong,nonatomic)UIActivityIndicatorView *avi;


@end

@implementation SiginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//这个方法专门做导航条的控制
- (void)naviConfig{
    
    //设置导航条的颜色（风格颜色）
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    //设置导航条标题颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //设置导航条是否被隐藏
    self.navigationController.navigationBar.hidden = NO;
    
    //设置导航条上按钮的风格颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置是否需要毛玻璃效果
    self.navigationController.navigationBar.translucent = YES;
    //为导航条左上角创建一个按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = left;
}
//用model的方式返回上一页
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];//用push返回上一页
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)siginAction:(UIButton *)sender forEvent:(UIEvent *)event {
    if (_userNameTextField.text.length == 0) {
        [Utilities popUpAlertViewWithMsg:@"请输入您的手机号" andTitle:nil onView:self];
        return;
    }
    if (_pwdTextField.text.length ==0) {
        [Utilities popUpAlertViewWithMsg:@"请输入密码" andTitle:nil onView:self];
        return;
    }
    if (_nickNameTextField.text.length > 6 || _nickNameTextField.text.length < 18) {
        [Utilities popUpAlertViewWithMsg:@"请您输入的字符必须在6—18位之间" andTitle:nil onView:self];
        return;
    }
    if (_confirmPwdTextField.text.length == 0) {
        [Utilities popUpAlertViewWithMsg:@"请在确认密码输入框输入密码" andTitle:nil onView:self];
        return;
    }
    if (_verLabel.text.length == 0) {
        [Utilities popUpAlertViewWithMsg:@"请输入有效的四位验证码" andTitle:nil onView:self];
        return;
    }
    if (_confirmPwdTextField.text != _pwdTextField.text) {
        [Utilities popUpAlertViewWithMsg:@"请输入与密码框相同的密码" andTitle:nil onView:self];
        return;
    }
    if (_pwdTextField.text.length > 6 || _pwdTextField.text.length < 18) {
        [Utilities popUpAlertViewWithMsg:@"您输入的密码必须在6—18位之间" andTitle:nil onView:self];
        return;
    }
    //判断某个字符中是否每个字符都是数字
    if (_userNameTextField.text.length < 11 || [_userNameTextField.text rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet]invertedSet]].location != NSNotFound) {
        [Utilities popUpAlertViewWithMsg:@"您输入不小于11位的手机号码" andTitle:nil onView:self];
        return;
    }
    //无输入异常的情况
    [self requst];
}

- (void)requst{
    //创建菊花膜
    _avi = [Utilities getCoverOnView:self.view];
    //开始网络请求
    [RequestAPI requestURL:@"/login/getKey" withParameters:@{@"deviceType":@7001,@"deviceId":[Utilities uniqueVendor]} andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        [_avi stopAnimating];
        NSLog(@"%@",responseObject);
        if ([responseObject[@"result"]integerValue] == 8001) {
            [Utilities popUpAlertViewWithMsg:@"注册成功" andTitle:nil onView:self];
            [self performSegueWithIdentifier:@"signUpToLogin" sender:self];
        }
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
    }];
}












@end
