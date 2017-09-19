//
//  MyPromoteViewController.m
//  Converge
//
//  Created by admin on 2017/9/15.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "MyPromoteViewController.h"

@interface MyPromoteViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pomoteImgView;

@property (strong, nonatomic) UIActivityIndicatorView *avi;
@property (strong,nonatomic)NSString *at;


@end

@implementation MyPromoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    [self networkRequest];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//这个方法专门做导航条的控制
- (void)naviConfig{
    //设置导航条标题的文字
    self.navigationItem.title = @"我的推广";
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


- (void)networkRequest{
    _avi = [Utilities getCoverOnView:self.view];
    
    [RequestAPI requestURL:@"/mySelfController/getInvitationCode" withParameters:@{@"memberId":@2} andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        [_avi stopAnimating];
        NSLog(@"mypromotion:%@", responseObject);
        if ([responseObject[@"resultFlag"]integerValue]==8001) {
            _at = responseObject[@"result"];
            // 1.创建过滤器 -- 苹果没有将这个字符封装成常量
            CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
            
            // 2.过滤器恢复默认设置
            [filter setDefaults];
            
            // 3.给过滤器添加数据(正则表达式/帐号和密码) -- 通过KVC设置过滤器,只能设置NSData类型
            NSString *dataString = [NSString stringWithFormat:@"http://dwz.cn/%@",_at];
            NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
            [filter setValue:data forKeyPath:@"inputMessage"];
            
            // 4.获取输出的二维码
            CIImage *outputImage = filter.outputImage;
            UIImage *image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
            // 5.显示二维码
            _pomoteImgView.image = image;
            
        }
        else{
            [_avi stopAnimating];
            NSString *errorMsg=[ErrorHandler getProperErrorString:[responseObject[@"resultFlag"]integerValue]];
            [Utilities popUpAlertViewWithMsg:errorMsg andTitle:nil onView:self];
        }
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        [Utilities popUpAlertViewWithMsg:@"网络错误,请稍等再试" andTitle:@"提示" onView:self];
    }];
    
    
}
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


@end
