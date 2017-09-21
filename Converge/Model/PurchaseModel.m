//
//  PurchaseModel.m
//  Converge
//
//  Created by admin on 2017/9/20.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "PurchaseModel.h"

@implementation PurchaseModel

-(instancetype)initWithexperience:(NSDictionary *)dict{
    self = [super self];
    if(self){
        _beginDate = [Utilities nullAndNilCheck:dict[@"beginDate"] replaceBy:@""];
        _endDate = [Utilities nullAndNilCheck:dict[@"endDate"] replaceBy:@""];
        _clubTel = [Utilities nullAndNilCheck:dict[@"clubTel"] replaceBy:@"暂无号码"];
        
        _userTime = [Utilities nullAndNilCheck:dict[@"useDate"] replaceBy:@""];
        _currentPrice = [Utilities nullAndNilCheck:dict[@"currentPrice"] replaceBy:@""];
        _orginPrice = [Utilities nullAndNilCheck:dict[@"orginPrice"] replaceBy:@""];
        _eName = [Utilities nullAndNilCheck:dict[@"eName"] replaceBy:@""];
        _clubName = [Utilities nullAndNilCheck:dict[@"eClubName"] replaceBy:@""];
        _eLogo = [Utilities nullAndNilCheck:dict[@"eLogo"] replaceBy:@""];
        _latitude = [Utilities nullAndNilCheck:dict[@"latitude"] replaceBy:@""];
        _longitude = [Utilities nullAndNilCheck:dict[@"longitude"] replaceBy:@""];
        _rules = [Utilities nullAndNilCheck:dict[@"rules"] replaceBy:@""];
        _saleCount = [Utilities nullAndNilCheck:dict[@"saleCount"] replaceBy:@""];
        _eAddress = [Utilities nullAndNilCheck:dict[@"eAddress"] replaceBy:@""];
        _ePromot = [Utilities nullAndNilCheck:dict[@"ePromot"] replaceBy:@"暂无"];
    }
    return  self;
}


@end
