//
//  detailViewController.m
//  Converge
//
//  Created by admin on 2017/9/7.
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "detailViewController.h"
#import "detailModel.h"
@interface detailViewController ()
<<<<<<< HEAD
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
@property (strong,nonatomic)NSMutableArray *clubArr;

=======
>>>>>>> 622a97b3e6b8c7bb869042815b84ab070e126927

@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
<<<<<<< HEAD
    [self naviConfig];
    [self request];
    [self set];
=======
>>>>>>> 622a97b3e6b8c7bb869042815b84ab070e126927
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
<<<<<<< HEAD
#pragma mark - nav
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
-(void)set{
   
    _clubArr = [NSMutableArray new];
}
#pragma mark - request
-(void)request{
    NSDictionary *para = @{@"clubKeyId":@4};
    [RequestAPI requestURL:@"/clubController/getClubDetails" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        NSLog(@"responseObject: %@",responseObject);
        if([responseObject[@"resultFlag"]integerValue] == 8001){
                                                 }
    } failure:^(NSInteger statusCode, NSError *error) {
        NSLog(@"%ld",(long)statusCode);
    }];
    
=======

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
>>>>>>> 622a97b3e6b8c7bb869042815b84ab070e126927
}

@end
