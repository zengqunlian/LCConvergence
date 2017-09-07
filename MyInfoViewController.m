//
//  MyInfoViewController.m
//  Converge
//
//  Created by admin on 2017/9/7.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyInfoTableViewCell.h"
#import "UserModel.h"

@interface MyInfoViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property (weak, nonatomic) IBOutlet UIImageView *avatrImage;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginAction:(UIButton *)sender forEvent:(UIEvent *)event;

@property (strong,nonatomic) NSArray *arr;

@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)naviConfig{
    //设置导航条标题文字
    self.navigationItem.title = @"我的";
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
}

//用Model的方式返回上一页
-(void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)uilayout{
    _avatrImage.layer.borderColor = [[UIColor lightGrayColor]CGColor];
}

- (void)dataInitialize{
    _arr = @[@"我的订单",@"我的推广",@"积分中心",@"意见反馈",@"关于我们"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _arr.count;
    } else {
        return 1;
    }
    
}

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50.f;
    }else{
        return UI_SCREEN_H - 500;
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
    
}












@end
