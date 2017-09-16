//
//  ActivityDetailViewController.h
//  Converge
//
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

@interface ActivityDetailViewController : UIViewController

//创建一个容器去接收别的页面传来的数据
@property (strong ,nonatomic) ActivityModel *activity;

@end
