//
//  experienceViewController.m
//  Converge
//
//  Created by admin on 2017/9/7.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "experienceViewController.h"
#import "experienceModel.h"
@interface experienceViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *experienceImage;
@property (weak, nonatomic) IBOutlet UILabel *experienceTitle;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UILabel *originPrice;
@property (weak, nonatomic) IBOutlet UILabel *clubName;
@property (weak, nonatomic) IBOutlet UILabel *clubAdress;
@property (weak, nonatomic) IBOutlet UILabel *sellNum;
@property (weak, nonatomic) IBOutlet UIView *warmPrompt;
@property (weak, nonatomic) IBOutlet UITextView *useRules;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *useTime;

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
    NSDictionary *para = @{@"experienceId":[[StorageMgr singletonStorageMgr] objectForKey:@"ID"]};
    [RequestAPI requestURL:@"/clubController/experienceDetail" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if([responseObject[@"resultFlag"]integerValue] == 8001){
            experienceModel *model = [[experienceModel alloc]initWithDetailexperience:responseObject[@"result"]];
            NSURL *url1 = [NSURL URLWithString:model.experienceImage];
            _experienceTitle.text = model.experienceName;
            _clubName.text = model.clubName;
            //NSLog(@"%@",model.clubName);
            _currentPrice.text = [NSString stringWithFormat:@"¥:%@",model.currentPrice];
            _originPrice.text = [NSString stringWithFormat:@"原价:%@",model.orginPrice];
            _sellNum.text = [NSString stringWithFormat:@"已售:%@",model.sell];
            _clubAdress.text = model.experienceAddress;
            _useRules.text = model.useRule;
            _startTime.text = model.startTime;
            _endTime.text = model.endTime;
            [_experienceImage sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                    }
        NSLog(@"responseObject: %@",responseObject);
    } failure:^(NSInteger statusCode, NSError *error) {
        
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

@end
