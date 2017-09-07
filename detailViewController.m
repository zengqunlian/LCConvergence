//
//  detailViewController.m
//  Converge
//
//  Created by admin on 2017/9/7.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "detailViewController.h"

@interface detailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *experienceImageView;
@property (weak, nonatomic) IBOutlet UILabel *experienceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *integrationLabel;//综合卷
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellLabel;
@property (weak, nonatomic) IBOutlet UIImageView *clubImage;
@property (weak, nonatomic) IBOutlet UILabel *clubTitle;
@property (weak, nonatomic) IBOutlet UILabel *clubAdress;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *num1;//场地
@property (weak, nonatomic) IBOutlet UILabel *num2;//会员
@property (weak, nonatomic) IBOutlet UILabel *num3;//教练
@property (weak, nonatomic) IBOutlet UITextView *clubIntroduce;//会所介绍


@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)naviConfig {
    //设置导航条标题文字
        self.navigationItem.title = @"会所信息";
    //设置导航条颜色（风格颜色）
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    //设置导航条标题颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //设置导航条是否隐藏.
    self.navigationController.navigationBar.hidden = NO;
    //设置导航条上按钮的风格颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置是否需要毛玻璃效果
    self.navigationController.navigationBar.translucent = YES;
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
