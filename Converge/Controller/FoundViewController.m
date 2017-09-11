//
//  FoundViewController.m
//  Converge
//
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "FoundViewController.h"
#import "FoundTableViewCell.h"
@interface FoundViewController ()
@property (weak, nonatomic) IBOutlet UITableView *foundTableView;
@property (strong,nonatomic)NSString *city;
@end

@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self set];
    [self request];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)set{
    _city = @"无锡";
}
#pragma mark - request
-(void)request{
    NSDictionary *para = @{@"city":_city,@"jing":@"31.568",@"wei":@"120.299",@"page":@1,@"perPage":@10,@"type":@1};
    [RequestAPI requestURL:@"/clubController/nearSearchClub" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        NSLog(@"%@",responseObject);
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
