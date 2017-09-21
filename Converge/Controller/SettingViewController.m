//
//  SettingViewController.m
//  Converge
//
//  Created by admin on 2017/9/19.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "SettingViewController.h"
#import "UserModel.h"
#import "SettingTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *setImgView;
@property (weak, nonatomic) IBOutlet UITableView *setTableView;
@property (weak, nonatomic) IBOutlet UIButton *nicknameBtn;
- (IBAction)nicknameAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (strong,nonatomic) NSArray *arr;
@property (strong, nonatomic) NSMutableArray *setArr;
@property (strong, nonatomic) UIActivityIndicatorView *avi;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    
    // Do any additional setup after loading the view.
    //监听名为@"refreshSetup"的通知，监听到后执行refreshSetup方法

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)naviConfig{
    //设置导航条标题的文字
    self.navigationItem.title = @"设置";
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


//当前页面将要显示的时候，显示导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    if ([Utilities loginCheck]) {
        //已登录
        UserModel *user = [[StorageMgr singletonStorageMgr]objectForKey:@"MemberInfo"];
        NSLog(@"是：%@",user.dob);
        _setArr = [[NSMutableArray alloc]initWithObjects:@{@"nicknameLbl":@"昵称",@"afandaLbl":user.nickname},@{@"nicknameLbl":@"性别",@"afandaLbl":user.gender},@{@"nicknameLbl":@"生日",@"afandaLbl":user.dob},@{@"nicknameLbl":@"身份证号码",@"afandaLbl":user.idCardNo}, nil];
        
        [_setImgView sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl] placeholderImage:[UIImage imageNamed:@"ic_user_head"]];
        
    }else{
        _setImgView.image= [UIImage imageNamed:@"ic_user_head"];
        
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
                [self performSegueWithIdentifier:@"setting2name" sender:self];
                
                
                break;
            case 1:
                [self performSegueWithIdentifier:@"setting2gender" sender:self];
                
                
                break;
            case 2:
                [self performSegueWithIdentifier:@"setting2birthday" sender:self];
                
                break;
            default:
                [self performSegueWithIdentifier:@"setting2identity" sender:self];
                break;
        }
    }else{
        UINavigationController *signNavi = [Utilities getStoryboardInstance:@"Login" byIdentity:@"LoginNavi"];
        
        [self presentViewController:signNavi animated:YES completion:nil];
    }
}

//按键盘上的return健收回键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //让根视图结束编辑状态达到收起键盘的目的
    [self.view endEditing:YES];
}



- (IBAction)nicknameAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
