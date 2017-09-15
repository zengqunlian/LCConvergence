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
#import "StorageMgr.h"
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
@property (weak, nonatomic) IBOutlet UILabel *memberNum;//会员
@property (weak, nonatomic) IBOutlet UILabel *personNum;//教练
@property (weak, nonatomic) IBOutlet UITextView *clubIntroduce;//会所介绍
//@property (strong,nonatomic)NSMutableArray *clubArr;

@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self naviConfig];
    [self request];
    [self set];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
    
    
    
}
#pragma mark - request
-(void)request{
    //[[StorageMgr singletonStorageMgr] objectForKey:@"ID"];
    NSDictionary *para = @{@"clubKeyId":[[StorageMgr singletonStorageMgr] objectForKey:@"ID"]};
    [RequestAPI requestURL:@"/clubController/getClubDetails" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        // NSLog(@"responseObject: %@",responseObject);
        if([responseObject[@"resultFlag"]integerValue] == 8001){
            
            NSArray *detail = responseObject[@"result"][@"experienceInfos"];
            for (NSDictionary *dict in detail) {
                detailModel *model = [[detailModel alloc]initWithDetailclub:dict];
                NSURL *url1 = [NSURL URLWithString:model.elogo];
                _clubTitle.text = model.clubname;
                _experienceTitleLabel.text = model.eName;
                _moneyLabel.text = [NSString stringWithFormat:@"¥:%@", model.price];
                _sellLabel.text = [NSString stringWithFormat:@"已售:%@", model.sell];
                //NSLog(@"%@",model.price);
                //NSLog(@"%@",model.sell);
                [_experienceImageView sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@""]];
                //                NSArray *arr = responseObject[@"result"][@"clubFeature"];
                //                for (NSDictionary *dict in arr){
                detailModel *model1 = [[detailModel alloc]initWithclub:responseObject[@"result"]];
                NSURL *url = [NSURL URLWithString:model1.clubLogo];
                _clubIntroduce.text = model1.clubIntroduce;
                //NSLog(@"%@",model1.clubIntroduce);
                _clubAdress.text = model1.clubAdress;
                _memberNum.text = [NSString stringWithFormat:@"%@", model1.clubMember];
                _personNum.text = [NSString stringWithFormat:@"%@", model1.clubPerson];
                _num1.text = [NSString stringWithFormat:@"%@", model1.clubSite];
                _timeLabel.text = model1.time;
                //NSLog(@"%@",model1.time);
                [_clubImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
                
            }
        }
        
    } failure:^(NSInteger statusCode, NSError *error) {
        NSLog(@"%ld",(long)statusCode);
    }];
    
    
}

@end


