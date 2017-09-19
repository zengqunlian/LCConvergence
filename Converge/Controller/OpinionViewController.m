//
//  OpinionViewController.m
//  Converge
//
//  Created by admin on 2017/9/19.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "OpinionViewController.h"

@interface OpinionViewController ()
@property (weak, nonatomic) IBOutlet UITextView *opinionTextView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitAction:(UIButton *)sender forEvent:(UIEvent *)event;

@property (strong, nonatomic) UIActivityIndicatorView *avi;

@end

@implementation OpinionViewController

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
    //设置导航条标题的文字
    self.navigationItem.title = @"意见反馈";
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

- (void)networkRequest{
    [_avi stopAnimating];
    NSDictionary *para = @{@"memberId":@2,@"message":_opinionTextView.text};
    [RequestAPI requestURL:@"/clubFeedback" withParameters:para andHeader:nil byMethod:kPost andSerializer:kJson success:^(id responseObject) {
        [_avi stopAnimating];
        NSLog(@"feedback: %@", responseObject);
        if ([responseObject[@"resultFlag"] integerValue] == 8001) {
            //创建一个通知
            NSNotification *note = [NSNotification notificationWithName:@"refreshHome" object:nil userInfo:nil];
            //发送这个通知
            [[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:note waitUntilDone:YES];
        }else{
            NSString *errorMsg=[ErrorHandler getProperErrorString:[responseObject[@"resultFlag"]integerValue]];
            [Utilities popUpAlertViewWithMsg:errorMsg andTitle:@"提示" onView:self];
        }
        
        
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        //业务逻辑失败的情况下
        [Utilities popUpAlertViewWithMsg:@"网络错误" andTitle:nil onView:self];
    }];

}

- (IBAction)submitAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
