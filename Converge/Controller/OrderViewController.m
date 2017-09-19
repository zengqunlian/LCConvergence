//
//  OrderViewController.m
//  Converge
//
//  Created by admin on 2017/9/15.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderModel.h"
#import "OrderTableViewCell.h"

@interface OrderViewController ()
@property (weak, nonatomic) IBOutlet UITableView *orderTableView;

@property(strong,nonatomic)NSMutableArray *arr;
@property(strong,nonatomic)UIActivityIndicatorView *avi;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    [self networkRequest];
    // Do any additional setup after loading the view.
    _arr = [NSMutableArray new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//这个方法专门做导航条的控制
- (void)naviConfig{
    //设置导航条标题的文字
    self.navigationItem.title = @"我的订单";
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section

{
    
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.textLabel.textColor = [UIColor darkGrayColor];
    header.textLabel.font = [UIFont systemFontOfSize:13];
    header.contentView.backgroundColor = UIColorFromRGB(240, 239, 240);
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    OrderModel *Model = _arr[section];
    NSString *upper = [Model.orderNum uppercaseString];
    NSString *string = [NSString stringWithFormat:@"订单号:%@",upper];
    return string;
}


- (void)networkRequest{
    _avi = [Utilities getCoverOnView:self.view];
    NSMutableDictionary *para = [NSMutableDictionary new];
    if ([Utilities loginCheck]) {
        [para setObject:[[StorageMgr singletonStorageMgr]objectForKey:@"MemberId"] forKey:@"memberId"];
    }
    [RequestAPI requestURL:@"/orderController/orderList" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        [_avi stopAnimating];
        if([responseObject[@"resultFlag"] integerValue] == 8001){
            NSArray *array = responseObject[@"result"][@"orderList"];
            for(NSDictionary *dict in array){
                OrderModel *model = [[OrderModel alloc]initWithOrder:dict];
                [_arr addObject:model];
            }
            [_orderTableView reloadData];
        }
        
        else{
            NSString *errorMsg = [ErrorHandler getProperErrorString:[responseObject[@"resultFlag"] integerValue]];
            [Utilities popUpAlertViewWithMsg:errorMsg andTitle:nil onView:self];
            
        }
        
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
    }];

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
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell"forIndexPath:indexPath];
    OrderModel *Model = _arr[indexPath.section];
    NSURL *url = [NSURL URLWithString: Model.imgUrl];
    [cell.orderImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认"]];
    cell.nameLbl.text = Model.productName;
    cell.clubNameLbl.text = Model.clubName;
    cell.priceLbl.text = [NSString stringWithFormat:@"%@元",Model.shouldpay];
    
    return cell;
}
//设置每行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120.f;
}

//细胞选中后调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
