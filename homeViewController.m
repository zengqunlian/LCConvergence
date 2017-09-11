//
//  homeViewController.m
//  Converge
//
//  Created by admin on 2017/9/4.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "homeViewController.h"
#import "homeTableViewCell.h"
#import "experienceTableViewCell.h"
#import "homeModel.h"
#import "StorageMgr.h"
@interface homeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
//@property (weak, nonatomic) IBOutlet UIImageView *image1;
//@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (strong,nonatomic)NSString *city;
@property (strong,nonatomic)NSArray *homeArr;
@property (strong,nonatomic)NSMutableArray *clubArr;
@property (strong, nonatomic) NSMutableArray *advArr;//广告数组
@end

@implementation homeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self set];
    [self naviConfig];
    [self request];
    [self switchAction];
    //    _homeArr = @[@{@"homeImageView":@"莫梵",@"titleLabel":@"莫梵瑜伽（阳光店）",@"adressLabel":@"无锡",@"distanceLabel":@"距离我3.5公里",@"experiencrImageView":@"莫梵",@"experienceTitleLabel":@"莫梵瑜伽-体验卡",@"integrationLabel":@"综合卷",@"moneyLabel":@"70yuan",@"sellLabel":@"已售1"},@{@"homeImageView":@"莫梵",@"titleLabel":@"莫梵瑜伽（阳光店）",@"adressLabel":@"无锡",@"distanceLabel":@"距离我3.5公里",@"experiencrImageView":@"莫梵",@"experienceTitleLabel":@"莫梵瑜伽-体验卡",@"integrationLabel":@"综合卷",@"moneyLabel":@"70yuan",@"sellLabel":@"已售1"},@{@"homeImageView":@"莫梵",@"titleLabel":@"莫梵瑜伽（阳光店）",@"adressLabel":@"无锡",@"distanceLabel":@"距离我3.5公里",@"experiencrImageView":@"莫梵",@"experienceTitleLabel":@"莫梵瑜伽-体验卡",@"integrationLabel":@"综合卷",@"moneyLabel":@"70yuan",@"sellLabel":@"已售1"}];
    //    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - nav
- (void)naviConfig {
    //设置导航条标题文字
    //self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"首页";
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
    _homeArr = [NSArray new];
    _clubArr = [NSMutableArray new];
    _city = @"无锡";
    _advArr = [NSMutableArray new];
    
}
#pragma mark - table view
//有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _clubArr.count;
}
//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    homeModel *suibian = _clubArr[section];
    return suibian.experArr.count+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 200.f;
    }
    else{
        return 200.f;
    }
}
//细胞长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        homeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell" forIndexPath:indexPath];
        //根据行号拿到数组中对应的数据
        // NSDictionary *dict = _homeArr[indexPath.section];
        homeModel *homeModel = _clubArr[indexPath.section];
        NSURL *url = [NSURL URLWithString:homeModel.advImage];
//        NSLog(@"456%@",_advArr);
//        NSLog(@"456%@",_clubArr);
//        NSLog(@"321%@",homeModel.advImage);
        [cell.homeImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"莫梵"]];
        //cell.homeImageView = homeModel.advImage;
        //cell.titleLabel.text = homeModel.title;
        cell.adressLabel.text = homeModel.adress;
        cell.distanceLabel.text = homeModel.distance;
        cell.titleLabel.text = homeModel.experienceName;
        return cell;
    }else{
        experienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"exprienceCell" forIndexPath:indexPath];
        homeModel *experience = _clubArr[indexPath.section];
        NSURL *url1 = [NSURL URLWithString:experience.experArr[indexPath.row-1][@"logo"]];
        // NSLog(@"456%@",_clubArr);
        //NSLog(@"liubin = %@",experience.experArr[indexPath.row - 1]);
        [cell.experienceImageView sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"莫梵"]];
        cell.experienceTitleLabel.text = experience.experArr[indexPath.row-1][@"name"];
        //NSLog(@"23423456347%@",(experience.hotelid));
        [[StorageMgr singletonStorageMgr] addKey:@"ID" andValue:experience.hotelid];

        //NSLog(@"niubi = %@,%@,%@",experience.experArr[indexPath.row -1][@"orginPrice"],experience.experArr[indexPath.row -1][@"sellNumber"],experience.experArr[indexPath.row -1][@"name"]);
        cell.moneyLabel.text =[NSString stringWithFormat:@"¥：%@",experience.experArr[indexPath.row -1][@"orginPrice"]];
        cell.sellLabel.text = [NSString stringWithFormat:@"已售：%@",experience.experArr[indexPath.row -1][@"sellNumber"]];
        //NSLog(@"text = %@,%@",cell.moneyLabel.text,cell.sellLabel.text);
        //[cell.experienceImageView sd_setImageWithURL:url1]
        //cell.experienceTitleLabel.text = experience.experArr
        
        return cell;
    }
    
    //[[StorageMgr singletonStorageMgr] addKey:@"" andValue:<#(id)#>];
    //[[StorageMgr singletonStorageMgr] removeObjectForKey:<#(NSString *)#>];
    //[[StorageMgr singletonStorageMgr] objectForKey:<#(NSString *)#>];
    
    
    
}
#pragma mark - request
-(void)request{
    NSDictionary *para = @{@"city":_city,@"jing":@"31.568",@"wei":@"120.299",@"page":@1,@"perPage":@10};
    [RequestAPI requestURL:@"/homepage/choice" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
       // NSLog(@"responseObject: %@",responseObject);
        if([responseObject[@"resultFlag"]integerValue] == 8001){
            NSArray *model =responseObject[@"advertisement"];
            for(NSDictionary *dict in model){
                homeModel *adv = [[homeModel alloc]initWithDictForadvertise:dict];
                [_advArr addObject:adv];
                //NSLog(@"advarr = %lu",(unsigned long)_advArr.count);
            }
            NSArray *club = responseObject[@"result"][@"models"];
            //                for (int i =0; i<=club.count;i++){
            //                    if ( [club[i] isKindOfClass:[NSDictionary class]]){
            //                    homeModel *clubImage = [[homeModel alloc]initWithDictForexperienceCell:club[i]];
            //                    [_clubArr addObject:clubImage];
            //                    }
            //                }
            for(NSDictionary *dict in club){
                homeModel *clubImage = [[homeModel alloc]initWithDictForexperienceCell:dict];
                [_clubArr addObject:clubImage];
                //NSLog(@"%@",_clubArr);
            }
            [_homeTableView reloadData];
        }
    } failure:^(NSInteger statusCode, NSError *error) {
        NSLog(@"%ld",(long)statusCode);
    }];
    
}

- (void)switchAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LeftSwitch" object:nil];
}



@end
