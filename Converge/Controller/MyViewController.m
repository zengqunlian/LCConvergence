//
//  MyViewController.m
//  Converge
//
//  Created by admin on 2017/9/15.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    [self networkRequest];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//这个方法专门做导航条的控制
- (void)naviConfig{
    //设置导航条标题的文字
    self.navigationItem.title = @"我的积分";
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
    NSMutableDictionary *para = [NSMutableDictionary new];
    if ([Utilities loginCheck]) {
        [para setObject:[[StorageMgr singletonStorageMgr]objectForKey:@"MemberId"] forKey:@"memberId"];
    }
    [RequestAPI requestURL:@"/score/memberScore" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        if ([responseObject[@"resultFlag"]integerValue] == 8001) {
            NSDictionary *result = responseObject[@"result"];
            NSString *string = [NSString stringWithFormat:@"当前积分:%@",result];
            [Utilities popUpAlertViewWithMsg:@"积分商城即将登录，请耐心等待" andTitle:string onView:self];
        }
    } failure:^(NSInteger statusCode, NSError *error) {
        //失败以后要做的事情
        NSLog(@"statusCode = %ld",(long)statusCode);
        [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        
    }];
}



@end
