//
//  MyInfoViewController.m
//  Converge
//
//  Created by admin on 2017/9/7.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "MyInfoViewController.h"
#import "UserModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MyInfoViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (strong,nonatomic) NSArray *arr;

@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uiLayout];
    [self dataInitialize];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([Utilities loginCheck]) {
        //已登录
        _loginBtn.hidden = YES;
        _userNameLbl.hidden = NO;
        UserModel *user = [[StorageMgr singletonStorageMgr]objectForKey:@"MemberInfo"];
        [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl] placeholderImage:[UIImage imageNamed:@"Avatar"]];
        _userNameLbl.text = user.nickname;
    }else{
        //未登录
        _loginBtn.hidden = NO;
        _userNameLbl.hidden = YES;
        _avatarImageView.image= [UIImage imageNamed:@"Avatar"];
        _userNameLbl.text = @"客户";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)uiLayout{
    _avatarImageView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
}
- (void)dataInitialize{
    _arr = @[@"我的订单",@"我的推广",@"积分中心",@"意见反馈",@"关于我们"];
}
//有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemberCell" forIndexPath:indexPath];
        cell.textLabel.text = _arr[indexPath.row];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCell" forIndexPath:indexPath];
        return cell;
    }
}
//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        return 50.f;
    }else{
        return UI_SCREEN_H - 500;
    }
    
}
//按住细胞以后（取消选择）
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if ([Utilities loginCheck]) {
            switch (indexPath.row) {
                case 0:{
                    [self performSegueWithIdentifier:@"Let2MyAct" sender:self];
                    
                }
                    break;
                case 1:
                    
                    break;
                case 2:
                    
                    break;
                case 3:
                    
                    break;
                case 4:
                    
                    break;
                default:
                    break;
            }
        }else{
            //UINavigationController *signNavi = [Utilities getStoryboardInstance:@"Member" byIdentity:@"SignNavi"];

            //[self presentViewController:signNavi animated:YES completion:nil];
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
}

- (IBAction)settingAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
