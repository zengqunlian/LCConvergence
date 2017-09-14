//
//  ActivityDetailViewController.m
//  Converge
//
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PayTableViewController.h"

@interface ActivityDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *activityImgView;
@property (weak, nonatomic) IBOutlet UILabel *applyFeeLbl;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;
@property (weak, nonatomic) IBOutlet UILabel *applyStateLbl;
@property (weak, nonatomic) IBOutlet UILabel *attendenceLbl;
@property (weak, nonatomic) IBOutlet UILabel *typeLbl;
@property (weak, nonatomic) IBOutlet UILabel *issuerLbl;
@property (weak, nonatomic) IBOutlet UILabel *timelbl;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *applyDueLbl;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIView *applyStartView;
@property (weak, nonatomic) IBOutlet UIView *applyDueView;
@property (weak, nonatomic) IBOutlet UIView *applyIngView;
@property (weak, nonatomic) IBOutlet UIView *applyEndView;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

- (IBAction)applyAction:(UIButton *)sender;
- (IBAction)callAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self networkRequest];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//这个方法专门做导航栏的控制
- (void)naviConfig{
    //设置导航条标题的文字
    self.navigationItem.title = _activity.name;
    //设置导航条的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    //设置导航条标题的颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //设置导航条是否被隐藏
    self.navigationController.navigationBar.hidden = NO;
    
    //设置导航条上按钮的风格颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置是否需要毛玻璃效果
    self.navigationController.navigationBar.translucent = YES;
}

-(void)networkRequest{
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    NSString *request =[NSString stringWithFormat:@"/event/%@",_activity.activtyId];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    if ([Utilities loginCheck]) {
        [parameters setObject:[[StorageMgr singletonStorageMgr]objectForKey:@"MemberId"] forKey:@"memberId"];
    }
    [RequestAPI requestURL:request withParameters:parameters andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        [aiv stopAnimating];
        if ([responseObject[@"resultFlag"]integerValue]==8001) {
            NSDictionary *result = responseObject[@"result"];
            _activity = [[ActivityModel alloc]initWithDictionary:result];
            [self uiLayout];
        }else{
            //业务逻辑失败的情况下
            NSString *errorMsg = [ErrorHandler getProperErrorString:[responseObject[@"resultFlag"] integerValue]];
            [Utilities popUpAlertViewWithMsg:errorMsg andTitle:nil onView:self];
        }
    } failure:^(NSInteger statusCode, NSError *error) {
        //失败以后要做的事情
        NSLog(@"statusCode = %ld",(long)statusCode);
        
        [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
    }];
}

-(void)uiLayout{
    [_activityImgView sd_setImageWithURL:[NSURL URLWithString:_activity.imgUrl] placeholderImage:[UIImage imageNamed:@"image"]];
    _applyFeeLbl.text = [NSString stringWithFormat:@"%@元",_activity.applyFee];
    _attendenceLbl.text = [NSString stringWithFormat:@"%@/%@",_activity.attendence,_activity.limitation];
    _typeLbl.text = _activity.type;
    _issuerLbl.text = _activity.issuer;
    _addressLbl.text = _activity.address;
    _contentLbl.text =_activity.content;
    [_phoneBtn setTitle:[NSString stringWithFormat:@"联系活动发布者%@",_activity.phone] forState:UIControlStateNormal];
    NSString *dueTimeStr = [Utilities dateStrFromCstampTime:_activity.duetime withDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *startTimeStr = [Utilities dateStrFromCstampTime:_activity.starttime withDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *endTimeStr = [Utilities dateStrFromCstampTime:_activity.endtime withDateFormat:@"yyyy-MM-dd HH:mm"];
    _timelbl.text =[NSString stringWithFormat:@"%@ ~ %@",startTimeStr, endTimeStr];
    _applyDueLbl.text = [NSString stringWithFormat:@"报名截止时间(%@)",dueTimeStr];
    //获取什么时候调用这方法这个时间
    NSDate *now=[NSDate date];
    NSTimeInterval nowTime=[now timeIntervalSince1970InMilliSecond];
    _applyStartView.backgroundColor = [UIColor grayColor];
    if (nowTime>= _activity.duetime) {
        _applyDueView.backgroundColor = [UIColor grayColor];
        _applyBtn.enabled = NO;
        [_applyBtn setTitle:@"报名截止" forState:UIControlStateNormal];
        if (nowTime >= _activity.starttime) {
            _applyIngView.backgroundColor = [UIColor grayColor];
            if (nowTime>= _activity.endtime) {
                _applyEndView.backgroundColor = [UIColor grayColor];
            }
        }
    }
    if (_activity.attendence>=_activity.limitation) {
        _applyBtn.enabled = NO;
        [_applyBtn setTitle:@"活动满员" forState:UIControlStateNormal];
    }
    switch (_activity.status) {
        case 0:{
            _applyStateLbl.text = @"已取消";
        }
            break;
        case 1:{
            _applyStateLbl.text = @"待付款";
            [_applyBtn setTitle:@"去付款" forState:UIControlStateNormal];
        }
            break;
        case 2:{
            _applyStateLbl.text = @"已报名";
            [_applyBtn setTitle:@"已报名" forState:UIControlStateNormal];
            _applyBtn.enabled = NO;
        }
            break;
        case 3:{
            _applyStateLbl.text = @"退款中";
            [_applyBtn setTitle:@"退款中" forState:UIControlStateNormal];
            _applyBtn.enabled = NO;
        }
            break;
        case 4:{
            _applyStateLbl.text = @"已退款";
        }
            break;
        default:{
            _applyStateLbl.text = @"待报名";
        }
            break;
    }
}





- (IBAction)applyAction:(UIButton *)sender {
    if ([Utilities loginCheck]) {
        PayTableViewController*purchaseVC = [Utilities getStoryboardInstance:@"Activity" byIdentity:@"Pay"];
        //传数据到下一个页面
        purchaseVC.activity = _activity;
        //push跳转
        [self.navigationController pushViewController:purchaseVC animated:YES];
    }else{
        //获取要跳转过去的那个页面
        UINavigationController *signNavi = [Utilities getStoryboardInstance:@"Login" byIdentity:@"LoginNavi"];
        //执行跳转
        [self presentViewController:signNavi animated:YES completion:nil];
    }

}

- (IBAction)callAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //配置电话APP的路径，并将要拨打的号码组合到路径中
    NSString *targetAppStr = [NSString stringWithFormat:@"telprompt://%@",_activity.phone];
    NSURL *targetAppUrl = [NSURL URLWithString:targetAppStr];
    //从当前APP跳转到其他指定的APP中
    [[UIApplication sharedApplication] openURL:targetAppUrl];
}

@end

