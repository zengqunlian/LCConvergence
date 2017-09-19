//
//  OrderModel.m
//  Converge
//
//  Created by admin on 2017/9/19.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

-(instancetype)initWithOrder:(NSDictionary *)dict{
    self = [super self];
    if(self){
        _imgUrl = [Utilities nullAndNilCheck:dict[@"imgUrl"] replaceBy:@""];
        _clubName = [Utilities nullAndNilCheck:dict[@"clubName"] replaceBy:@""];
        _productName = [Utilities nullAndNilCheck:dict[@"productName"] replaceBy:@""];
        _shouldpay = [Utilities nullAndNilCheck:dict[@"shouldpay"] replaceBy:@""];
        _orderNum = [Utilities nullAndNilCheck:dict[@"orderNum"] replaceBy:@""];
        
    }
    return self;
}


@end
