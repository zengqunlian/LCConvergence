//
//  ClubDetailModel.m
//  Convergence
//
//  Created by admin001 on 2017/9/8.
//  Copyright © 2017年 EDucation. All rights reserved.
//

#import "ClubDetailModel.h"

@implementation ClubDetailModel
-(instancetype)initWithClubDetail:(NSDictionary *)dict{
    self = [super self];
    if (self) {
        _clubAddress = [Utilities nullAndNilCheck:dict[@"clubAddressB"] replaceBy:@""];
        _clubIntroduce = [Utilities nullAndNilCheck:dict[@"clubIntroduce"] replaceBy:@""];
        _clubLogo = [Utilities nullAndNilCheck:dict[@"clubLogo"] replaceBy:@""];
        _clubMember = [Utilities nullAndNilCheck:dict[@"clubMember"] replaceBy:@""];
        _clubName =[Utilities nullAndNilCheck:dict[@"clubName"] replaceBy:@""];
        _clubPerson = [Utilities nullAndNilCheck:dict[@"clubPerson"] replaceBy:@""];
        _clubSite = [Utilities nullAndNilCheck:dict[@"clubSite"] replaceBy:@""];
        _clubTel = [Utilities nullAndNilCheck:dict[@"clubTel"] replaceBy:@""];
        _clubTime = [Utilities nullAndNilCheck:dict[@"clubTime"] replaceBy:@""];
        _eId = [Utilities nullAndNilCheck:dict[@"eId"] replaceBy:@""];
        _eLogo = [Utilities nullAndNilCheck:dict[@"eLogo"] replaceBy:@""];
        _eName = [Utilities nullAndNilCheck:dict[@"eName"] replaceBy:@""];
        _number = [Utilities nullAndNilCheck:dict[@"number"] replaceBy:@""];
        _price = [Utilities nullAndNilCheck:dict[@"price"] replaceBy:@""];
        _salaCount = [Utilities nullAndNilCheck:dict[@"saleCount"] replaceBy:@""];
        _jing = [Utilities nullAndNilCheck:dict[@"clubJing"] replaceBy:@""];
        _wei = [Utilities nullAndNilCheck:dict[@"clubWei"] replaceBy:@""];
    }

    return self;
}
-(instancetype)initWithExper:(NSDictionary *)dict{
    self = [super self];
    if (self) {
    
        _eId = [Utilities nullAndNilCheck:dict[@"eId"] replaceBy:@""];
        _eLogo = [Utilities nullAndNilCheck:dict[@"eLogo"] replaceBy:@""];
        _eName = [Utilities nullAndNilCheck:dict[@"eName"] replaceBy:@""];
        _number = [Utilities nullAndNilCheck:dict[@"number"] replaceBy:@""];
        _price = [Utilities nullAndNilCheck:dict[@"price"] replaceBy:@""];
        _salaCount = [Utilities nullAndNilCheck:dict[@"saleCount"] replaceBy:@""];
    
    }
    return self;
}
@end
