//
//  LoginViewController.m
//  Converge
//
//  Created by admin on 2017/9/5.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "LoginViewController.h"
#import "UserModel.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pawTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (strong,nonatomic) UIActivityIndicatorView *aiv;



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    [self uilayout];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)naviConfig{
    //设置导航条标题文字
    //self.navigationItem.title = @"发布活动";
    //设置导航条的颜色（风格颜色）
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    //设置导航条标题的颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //设置导航条是否隐藏
    self.navigationController.navigationBar.hidden = NO;
    //设置导航条上按钮的风格颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置是否需要毛玻璃效果
    self.navigationController.navigationBar.translucent = YES;
    //为导航条左上角创建一个按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = left;
}

//用Model的方式返回上一页
-(void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)uilayout{
    //判断是否存在记忆体
    if (![[Utilities  getUserDefaults:@"Username"] isKindOfClass:[NSNull class]]) {
        if ([Utilities  getUserDefaults:@"Username"] != nil) {
            //将它显示在用户名输入框中
            _userNameTextField.text = [Utilities getUserDefaults:@"Username"];
        }
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginAction:(UIButton *)sender forEvent:(UIEvent *)event {
    if (_userNameTextField.text.length == 0) {
        [Utilities popUpAlertViewWithMsg:@"请输入您的手机号" andTitle:nil onView:self];
        return;
    }
    if (_pawTextField.text.length == 0) {
        [Utilities popUpAlertViewWithMsg:@"请输入密码" andTitle:nil onView:self];
        return;
    }
    if (_pawTextField.text.length < 6 || _pawTextField.text.length > 18) {
        [Utilities popUpAlertViewWithMsg:@"您输入的密码必须在6—18位之间" andTitle:nil onView:self];
        return;
    }
    //判断某个字符串中是否每个字符都是数字
    if (_userNameTextField.text.length < 11 || [_userNameTextField.text rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet]invertedSet]].location != NSNotFound) {
        [Utilities popUpAlertViewWithMsg:@"您输入不小于11位的手机号码" andTitle:nil onView:self];
        return;
    }
    //无输入异常的情况
    [self readyForEncoding];
}

- (void)readyForEncoding{
    // 创建菊花膜
    _aiv = [Utilities getCoverOnView:self.view];
    //开始请求
    [RequestAPI requestURL:@"/login/getKey" withParameters:@{@"deviceType":@7001,@"deviceId":[Utilities uniqueVendor]} andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        NSLog(@"responseObject = %@", responseObject);
        if ([responseObject[@"resultFlag"] integerValue] == 8001) {
            NSDictionary *result = responseObject[@"result"];
            //用字符串去接
            NSString *exponent =result[@"exponent"];
            NSString *modulus = result[@"modulus"];
            //对内容进行MD5加密
            NSString *md5Str = [_pawTextField.text getMD5_32BitString];
            //用模数于指数对MD5加密后的密码进行加密
            NSString *rsaStr = [NSString encryptWithPublicKeyFromModulusAndExponent:md5Str.UTF8String modulus:modulus exponent:exponent];
            //加密完成执行登陆窗口
            [self signInWithEnCryptPwd:rsaStr];
        }else{
            NSString *errorMsg = [ErrorHandler getProperErrorString:[responseObject[@"resultFlag"] integerValue]];
            [Utilities popUpAlertViewWithMsg:errorMsg andTitle:nil onView:self];
        }
        
    } failure:^(NSInteger statusCode, NSError *error) {
        NSLog(@"statusCode = %ld", (long)statusCode);
        [_aiv stopAnimating];
        [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
    }];
    
}
- (void)signInWithEnCryptPwd:(NSString *)encryptPwd{
    [RequestAPI requestURL:@"/login" withParameters:@{@"userName":_userNameTextField.text, @"password":encryptPwd, @"deviceType":@7001, @"deviceId":[Utilities uniqueVendor]} andHeader:nil byMethod:kPost andSerializer:kJson success:^(id responseObject) {
        [_aiv stopAnimating];
        NSLog(@"responseObject = %@", responseObject);
        if ([responseObject[@"resultFlag"] integerValue] == 8001) {
            NSDictionary *result = responseObject[@"result"];
            UserModel *user = [[UserModel alloc]initWithDictionary:result];
            //将登陆获取到的用户信息打包存储到单立化全局变量中
            [[StorageMgr singletonStorageMgr]addKey:@"MemberInfo" andValue:user];
            //单独将用户的ID也存储进单例化全局变量来作为用户是否已经登陆的判断依据，同时也方便其他所有页面更快捷的使用用户Id这个参数
            [[StorageMgr singletonStorageMgr] addKey:@"MemberId" andValue:user.memberId];
            //收起有可能没有收回去的键盘（如果键盘还打开着让它收回去）
            [self.view endEditing:YES];
            //清空密码输入框里的内容
            _pawTextField.text = @"";
            //记忆用户名
            [Utilities setUserDefaults:@"Username" content:_userNameTextField.text];
            //用model的方式返回上一页
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            NSString *orrorMsg = [ErrorHandler getProperErrorString:[responseObject[@"resultFlag"] integerValue]];
            [Utilities popUpAlertViewWithMsg:orrorMsg andTitle:nil onView:self];
        }
        
    } failure:^(NSInteger statusCode, NSError *error) {
        
    }];
}
//按键盘上的return健收回键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}











@end
