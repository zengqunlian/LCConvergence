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

@interface MyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
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
_arr =@[@{@"title":@"我的订单"},@{@"title":@"我的推广"},@{@"title":@"积分中心"},@{@"title":@"我的设置"},@{@"title":@"意见反馈"},@{@"title":@"关于我们"}];
}
//有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arr.count;
}
//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
//细胞长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemberCell" forIndexPath:indexPath];
    NSDictionary *dict = _arr[indexPath.section];
    cell.textLabel.text = dict[@"title"];
    return cell;
    }

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.f;
    }
//按住细胞以后（取消选择）
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //if (indexPath.section == 0) {
        if ([Utilities loginCheck]) {
            switch (indexPath.section) {
                case 0:
                    [self performSegueWithIdentifier:@"MyInfo2Order" sender:self];
                    
                
                    break;
                case 1:
                    [self performSegueWithIdentifier:@"MyInfo2MyPromote" sender:self];
                
                    
                    break;
                case 2:
                    [self performSegueWithIdentifier:@"MyInfo2My" sender:self];
                
                    break;
                case 3:
                    [self performSegueWithIdentifier:@"MyInfo2Setting" sender:self];
                
                    
                    break;
                case 4:
                    [self performSegueWithIdentifier:@"MyInfo2Opinion" sender:self];
                    
                    break;
                default:
                    [self performSegueWithIdentifier:@"MyInfo2AboutUs" sender:self];
                    break;
            }
        }else{
            UINavigationController *signNavi = [Utilities getStoryboardInstance:@"Login" byIdentity:@"LoginNavi"];

            [self presentViewController:signNavi animated:YES completion:nil];
        }
    }
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //获取要跳转过去的那个页面
    UINavigationController *signNavi = [Utilities getStoryboardInstance:@"Login" byIdentity:@"LoginNavi"];
    //执行跳转
    [self presentViewController:signNavi animated:YES completion:nil];
}

@end
