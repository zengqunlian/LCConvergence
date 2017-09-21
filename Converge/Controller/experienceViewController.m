//
//  experienceViewController.m
//  Converge
//
//  Created by admin on 2017/9/7.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "experienceViewController.h"
#import "experienceModel.h"
#import "PurchaseTableViewController.h"
@interface experienceViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *experienceImage;
@property (weak, nonatomic) IBOutlet UILabel *experienceTitle;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UILabel *originPrice;
@property (weak, nonatomic) IBOutlet UILabel *clubName;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;


@property (weak, nonatomic) IBOutlet UILabel *sellNum;
@property (weak, nonatomic) IBOutlet UIView *warmPrompt;
@property (weak, nonatomic) IBOutlet UITextView *useRules;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *useTime;
- (IBAction)payAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)addressAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)callAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (strong,nonatomic)PurchaseModel *model;
@property (strong,nonatomic)NSArray *arr;

@end

@implementation experienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self request];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - nav
- (void)naviConfig {
    //设置导航条标题文字
    //self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"体验卷信息";
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
-(void)set{
}
#pragma mark - request
-(void)request{
    //[[StorageMgr singletonStorageMgr] objectForKey:@"ID"];
     UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    NSDictionary *para = @{@"experienceId":[[StorageMgr singletonStorageMgr] objectForKey:@"ID"]};
    [RequestAPI requestURL:@"/clubController/experienceDetail" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        //NSLog(@"%@",responseObject);
        [aiv stopAnimating];
        if([responseObject[@"resultFlag"]integerValue] == 8001){
            experienceModel *model = [[experienceModel alloc]initWithDetailexperience:responseObject[@"result"]];
            NSURL *url1 = [NSURL URLWithString:model.experienceImage];
            _experienceTitle.text = model.experienceName;
            _clubName.text = model.clubName;
            //NSLog(@"%@",model.clubName);
            _currentPrice.text = [NSString stringWithFormat:@"¥:%@",model.currentPrice];
            _originPrice.text = [NSString stringWithFormat:@"原价:%@",model.orginPrice];
            _sellNum.text = [NSString stringWithFormat:@"已售:%@",model.sell];
           _addressBtn.titleLabel.text = model.experienceAddress;
            _useRules.text = model.useRule;
            _startTime.text = model.startTime;
            _endTime.text = model.endTime;
            [_experienceImage sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                    }
        NSLog(@"responseObject: %@",responseObject);
    } failure:^(NSInteger statusCode, NSError *error) {
        NSLog(@"%ld",(long)statusCode);
        [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
    }];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)payAction:(UIButton *)sender forEvent:(UIEvent *)event {
    if([Utilities loginCheck]){
        PurchaseTableViewController *purchase = [Utilities getStoryboardInstance:@"Home" byIdentity:@"Purchase"];
        purchase.model = _model;
        [self.navigationController pushViewController:purchase animated:YES];
    }else{
        //获取要跳转过去的那个页面
        UINavigationController *signNavi = [Utilities getStoryboardInstance:@"Login" byIdentity:@"LoginNavi"];
        //执行跳转
        [self presentViewController:signNavi animated:YES completion:nil];
    }

}

- (IBAction)addressAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)callAction:(UIButton *)sender forEvent:(UIEvent *)event {
    NSString *string = _model.clubTel;
    _arr =  [string componentsSeparatedByString:@","];
    // NSLog(@"数组里的是：%@",_arr);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // for(int i = 0 ; i < _arr.count ; i++){
    UIAlertAction *callAction = [UIAlertAction actionWithTitle:_arr[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //配置电话APP的路径，并将要拨打的号码组合到路径中
        NSString *targetAppStr = [NSString stringWithFormat:@"tel:%@",_arr[0]];
        
        UIWebView *callWebview =[[UIWebView alloc]init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:targetAppStr]]];
        [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
        
        
    }];
    [alertController addAction:callAction];
    // }
    if(_arr.count == 2)
    {
        
        UIAlertAction *callAction = [UIAlertAction actionWithTitle:_arr[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // NSLog(@"点了第二个");
            // NSLog(@"%@",_arr[1]);
            //配置电话APP的路径，并将要拨打的号码组合到路径中
            NSString *targetAppStr = [NSString stringWithFormat:@"tel:%@",_arr[1]];
            
            UIWebView *callWebview =[[UIWebView alloc]init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:targetAppStr]]];
            [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
            
            
        }];
        [alertController addAction:callAction];
        
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];

    // 由于它是一个控制器 直接modal出来就好了
    
    [self presentViewController:alertController animated:YES completion:nil];

}
@end
