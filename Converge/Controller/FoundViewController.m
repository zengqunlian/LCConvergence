//
//  FoundViewController.m
//  Converge
//
//  Created by admin on 2017/9/16.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "FoundViewController.h"
#import "FoundCollectionViewCell.h"
#import "FoundTableViewCell.h"
#import "FoundModel.h"
#import "detailViewController.h"

@interface FoundViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>{
    NSInteger flag;
    NSInteger pageNum;
    NSInteger totalPage;
    NSInteger pageSize;
    BOOL isLast;
    BOOL isdistance;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIButton *kindOfBtn;
@property (weak, nonatomic) IBOutlet UIButton *distanceBtn;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

- (IBAction)cityAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)kindOfAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)distanceAction:(UIButton *)sender forEvent:(UIEvent *)event;

@property (strong, nonatomic)UIActivityIndicatorView *avi;
@property (strong, nonatomic)NSMutableArray *arr;
@property (strong, nonatomic)NSMutableArray *arr1;
@property (strong, nonatomic)NSArray *city;
@property (strong, nonatomic)NSMutableArray *kindOf;
@property (strong, nonatomic)NSArray *distance;
@property (strong,nonatomic)NSString *distance1;
@property (strong,nonatomic)NSString *kindId;


@end

@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arr = [NSMutableArray new];
    _arr1 = [NSMutableArray new];
    isdistance = NO;
    _city = [[NSArray alloc]initWithObjects:@"全城",@"距离1千米",@"距离2千米",@"距离3千米", nil];
    _distance = [[NSArray alloc]initWithObjects:@"按距离",@"按受欢迎度", nil];
    // Do any additional setup after loading the view.
    pageNum = 1;
    pageSize = 10;
    //初始化一个单机手势，设置它的响应事件为tapClick
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    tapGesture.delegate = self;
    [self.whiteView addGestureRecognizer:tapGesture];
    [self naviConfig];
    [self setRefreshControl];
    [self dataInitialize];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//这个方法专门做导航条的控制
- (void)naviConfig{
    //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //设置导航条标题的文字
    self.navigationItem.title = @"发现";
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
}

- (void)tapClick{
    _whiteView.hidden = YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.tableView]) {
        return NO;
    }
    return YES;
}

#pragma mark - tableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30.f;
}

//筛选条件
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(flag == 1){
        return _city.count;
    }
    if(flag == 2){
        return _kindOf.count;
    }
    if(flag == 3){
        return _distance.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    
    if(flag == 1){
        cell.kindOfLabel.text = _city[indexPath.row];
            }
    if(flag == 2){
        cell.kindOfLabel.text = _kindOf[indexPath.row];
    }
    if(flag == 3){
        cell.kindOfLabel.text = _distance[indexPath.row];
    }
    return cell;
    
}

//设置每一组中每一行被点击以后要做的事情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    pageNum = 1;
    if(flag == 1){
        if(indexPath.row == 0){
            [self clubRequestData];
        }
        if(indexPath.row == 1){
            _distance1 = @"1千米";
            [self KMClubRequestData];
        }
        if(indexPath.row == 2){
            _distance1 = @"2千米";
            [self KMClubRequestData];
        }
        if(indexPath.row == 3){
            _distance1 = @"3千米";
            [self KMClubRequestData];
        }
        
    }
    if(flag == 2){
        
        if(indexPath.row == 0){
            [self KindClubRequestData];
        }
        if(indexPath.row == 1){
            _kindId = @"1";
            [self KindClubRequestData];
        }
        if(indexPath.row == 2){
            _kindId = @"2";
            [self KindClubRequestData];
        }
        if(indexPath.row == 3){
           _kindId = @"3";
            [self KindClubRequestData];
        }
        if(indexPath.row == 4){
            _kindId = @"4";
            [self KindClubRequestData];
        }
    }
    if(flag == 3){
        if(indexPath.row == 0){
            isdistance = YES;
            [self clubRequestData];
        }
        if(indexPath.row == 1){
            isdistance = NO;
            [self TypeClubRequestData];
        }
    }
    
}

#pragma mark - collectionView
//每组有多少个items
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arr.count;
}
//每个items长什么样
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FoundCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    FoundModel *model = _arr[indexPath.item];
    cell.nameLbl.text = model.clubName;
    cell.adressLbl.text = model.address;
    cell.distanceLbl.text = [NSString stringWithFormat:@"%@米",model.distance];
    NSURL *url = [NSURL URLWithString:model.image];
    [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认"]];
    UIView *sbv = [UIView new];
    sbv.backgroundColor = UIColorFromRGB(170, 170, 170);
    cell.selectedBackgroundView = sbv;
    return cell;
}
//设置每个cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((UI_SCREEN_W - 5)/2,185);
}
//最小的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setRefreshControl{
    
    UIRefreshControl *acquireRef = [UIRefreshControl new];
    [acquireRef addTarget:self action:@selector(acquireRef) forControlEvents:UIControlEventValueChanged];
    acquireRef.tag = 10001;
    [_collectionView addSubview:acquireRef];
}

//会所列表下拉刷新事件
- (void)acquireRef{
    pageNum = 1;
    if(flag == 1){
        if(_distance1 == nil){
            [self clubRequest];
        }else{
            [self KMClubRequest];
        }
        return;
    }
    if(flag == 2){
        if(_kindId == nil){
            [self clubRequest];
        }else{
            [self KindClubRequest];
        }

        return;
    }
    if(flag == 3){
       [self clubRequest];//默认

    }
    else{
        [self clubRequest];
        }
}

//细胞将要出现时调用
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(indexPath.row == _arr.count-1){
        if(pageNum != totalPage){
            pageNum ++;
            if(flag == 1){
                if(_distance1 == nil){
                    [self clubRequest];
                }else{
                    [self KMClubRequest];
                }
                return;
            }
            
            if(flag == 2){
                if(_kindId == nil){
                    [self clubRequest];
                }else{
                    //   [self KindClubRequest];
                }
                return;
            }
            
            if(flag == 3){
                if(isdistance){
                    [self clubRequest];
                }else{
                    [self typeClubRequest];
                }
                return;
            }
            else{
                [self clubRequest];
                //  NSLog(@"不是最后一页");
            }
        }
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [_collectionView deselectItemAtIndexPath:indexPath animated:YES];
    FoundModel *model = _arr[indexPath.row];
    NSString *clubId = model.clubId;
    [[StorageMgr singletonStorageMgr] addKey:@"clubId" andValue:clubId];
    
    detailViewController  *controller = [Utilities getStoryboardInstance:@"Home" byIdentity:@"Detail"];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - request
-(void)dataInitialize{
    // [self hotRequest];
    _avi = [Utilities getCoverOnView:self.view];
    [self typeRequest];
}

- (void)typeRequest{
    NSDictionary *para =  @{@"city":@"无锡"};
    [RequestAPI requestURL:@"/clubController/getNearInfos" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        // NSLog(@"responseObject:%@", responseObject);
        [_avi stopAnimating];
        if([responseObject[@"resultFlag"] integerValue] == 8001){
            NSDictionary *features = responseObject[@"result"][@"features"];
            NSArray *featureForm = features[@"featureForm"];
            for(NSDictionary *dict in featureForm){
                FoundModel *model = [[FoundModel alloc]initWithType:dict];
                [_arr1 addObject:model];
            }
            if(pageNum == 1){
                [_kindOf removeAllObjects];
            }
            _kindOf  = [[NSMutableArray alloc]initWithObjects:@"全部分类", nil];
            for(int i = 0; i < 4;i++){
                FoundModel *model = _arr1[i];
                [_kindOf addObject:model.fName];
            }
            
            //[_tableView reloadData];
            [self clubRequestData];
            
        }else{
            //业务逻辑失败的情况下
            NSString *errorMsg = [ErrorHandler getProperErrorString:[responseObject[@"resultFlag"] integerValue]];
            [Utilities popUpAlertViewWithMsg:errorMsg andTitle:nil onView:self];
        }
        
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
    }];
}

-(void)clubRequestData{
    _avi = [Utilities getCoverOnView:self.view];
    [self clubRequest];
}

//默认按距离请求数据
- (void)clubRequest{
    //NSLog(@"默认");
    _whiteView.hidden = YES;
    
    NSDictionary *para =  @{@"city":@"无锡",@"jing":@"120.300000",@"wei":@"31.570000",@"page":@(pageNum),@"perPage":@(pageSize),@"Type":@0};
    [RequestAPI requestURL:@"/clubController/nearSearchClub" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        // NSLog(@"responseObject:%@", responseObject);
        [_avi stopAnimating];
        UIRefreshControl *ref = (UIRefreshControl *)[_collectionView viewWithTag:10001];
        [ref endRefreshing];
        if([responseObject[@"resultFlag"] integerValue] == 8001){
            NSDictionary *result = responseObject[@"result"];
            NSArray *array = result[@"models"];
            NSDictionary  *pageDict =result[@"pagingInfo"];
            totalPage = [pageDict[@"totalPage"]integerValue];
            
            if(pageNum == 1){
                [_arr removeAllObjects];
            }
            for(NSDictionary *dict in array){
                FoundModel *model = [[FoundModel alloc]initWithClub:dict];
                [_arr addObject:model];
                
            }
            
            [_collectionView reloadData];
        }else{
            //业务逻辑失败的情况下
            NSString *errorMsg = [ErrorHandler getProperErrorString:[responseObject[@"result"] integerValue]];
            [Utilities popUpAlertViewWithMsg:errorMsg andTitle:nil onView:self];
        }
        
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        UIRefreshControl *ref = (UIRefreshControl *)[_collectionView viewWithTag:10001];
        [ref endRefreshing];
        [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        
    }];
    
}

-(void)KMClubRequestData{
    _avi = [Utilities getCoverOnView:self.view];
    [self KMClubRequest];
}

//请求n千米范围内的会所
- (void)KMClubRequest{
    _whiteView.hidden = YES;
    // NSLog(@"千米");
    NSDictionary *para =  @{@"city":@"无锡",@"jing":@"120.300000",@"wei":@"31.570000",@"page":@(pageNum),@"perPage":@(pageSize),@"Type":@0,@"distance":_distance};
    [RequestAPI requestURL:@"/clubController/nearSearchClub" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        //  NSLog(@"responseObject:%@", responseObject);
        [_avi stopAnimating];
        UIRefreshControl *ref = (UIRefreshControl *)[_collectionView viewWithTag:10001];
        [ref endRefreshing];
        if([responseObject[@"resultFlag"] integerValue] == 8001){
            NSDictionary *result = responseObject[@"result"];
            NSArray *array = result[@"models"];
            NSDictionary  *pageDict =result[@"pagingInfo"];
            totalPage = [pageDict[@"totalPage"]integerValue];
            
            if(pageNum == 1){
                [_arr
                 removeAllObjects];
            }
            
            for(NSDictionary *dict in array){
                FoundModel *model = [[FoundModel alloc]initWithClub:dict];
                
                [_arr addObject:model];
                // NSLog(@"数组里的是%@",model);
                
            }
            
            // NSLog(@"按%@米请求",_distance);
            [_collectionView reloadData];
            
        }else{
            //业务逻辑失败的情况下
            NSString *errorMsg = [ErrorHandler getProperErrorString:[responseObject[@"result"] integerValue]];
            [Utilities popUpAlertViewWithMsg:errorMsg andTitle:nil onView:self];
        }
        
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        UIRefreshControl *ref = (UIRefreshControl *)[_collectionView viewWithTag:10001];
        [ref endRefreshing];
        [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
    }];
    
}
-(void)KindClubRequestData{
    _avi = [Utilities getCoverOnView:self.view];
    [self KindClubRequest];
}

//按种类请求会所
- (void)KindClubRequest{
    _whiteView.hidden = YES;
    //NSLog(@"种类");
    NSDictionary *para =  @{@"city":@"无锡",@"jing":@"120.300000",@"wei":@"31.570000",@"page":@(pageNum),@"perPage":@(pageSize),@"Type":@0,@"featureId":_kindOf};
    [RequestAPI requestURL:@"/clubController/nearSearchClub" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        // NSLog(@"responseObject:%@", responseObject);
        [_avi stopAnimating];
        UIRefreshControl *ref = (UIRefreshControl *)[_collectionView viewWithTag:10001];
        [ref endRefreshing];
        if([responseObject[@"resultFlag"] integerValue] == 8001){
            NSDictionary *result = responseObject[@"result"];
            NSArray *array = result[@"models"];
            NSDictionary  *pageDict =result[@"pagingInfo"];
            totalPage = [pageDict[@"totalPage"]integerValue];
            if(pageNum == 1){
                [_arr
                 removeAllObjects];
            }
            
            for(NSDictionary *dict in array){
                FoundModel *model = [[FoundModel alloc]initWithClub:dict];
                
                [_arr addObject:model];
                
            }
            [_collectionView reloadData];
        }else{
            //业务逻辑失败的情况下
            NSString *errorMsg = [ErrorHandler getProperErrorString:[responseObject[@"result"] integerValue]];
            [Utilities popUpAlertViewWithMsg:errorMsg andTitle:nil onView:self];
        }
        
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        UIRefreshControl *ref = (UIRefreshControl *)[_collectionView viewWithTag:10001];
        [ref endRefreshing];
        [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
    }];
    
}
-(void)TypeClubRequestData{
    _avi = [Utilities getCoverOnView:self.view];
    
}
- (void)typeClubRequest{
}


- (IBAction)cityAction:(UIButton *)sender forEvent:(UIEvent *)event {
    flag = 1;
    self.height.constant = _city.count *40 ;
    _whiteView.hidden = NO;
    [_tableView reloadData];
}
    
- (IBAction)kindOfAction:(UIButton *)sender forEvent:(UIEvent *)event {
    flag = 2;
    self.height.constant = _kindOf.count *40 ;
    _whiteView.hidden = NO;
    [_tableView reloadData];
}

- (IBAction)distanceAction:(UIButton *)sender forEvent:(UIEvent *)event {
    flag = 3;
    self.height.constant = _distance.count *40;
    _whiteView.hidden = NO;
    [_tableView reloadData];

}
@end
