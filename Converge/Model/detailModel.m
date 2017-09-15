//
//  detailModel.m
//  Converge
//
//  Created by admin on 2017/9/7.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "detailModel.h"

@implementation detailModel
- (instancetype)initWithDetailclub:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.clubname = [Utilities nullAndNilCheck:dict[@"clubName"] replaceBy:@"未知"];
        self.elogo = [Utilities nullAndNilCheck:dict[@"eLogo"] replaceBy:@""];
        self.eName = [Utilities nullAndNilCheck:dict[@"eName"] replaceBy:@"未知"];
        self.price = [Utilities nullAndNilCheck:dict[@"price"] replaceBy:@"0"];
        self.sell = [Utilities nullAndNilCheck:dict[@"saleCount"] replaceBy:@"1"];
        if([dict[@"experienceInfos"]isKindOfClass:[NSNull class]]){
            _clubArr = @[];
        }
        else{
            _clubArr = dict[@"experienceInfos"];
        }
    }
    return self;
}
- (instancetype)initWithclub:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.clubLogo = [Utilities nullAndNilCheck:dict[@"clubLogo"] replaceBy:@""];
        self.clubMember = [Utilities nullAndNilCheck:dict[@"clubMember"]replaceBy:@"暂无"];
        self.clubPerson = [Utilities nullAndNilCheck:dict[@"clubPerson"] replaceBy:@"未知"];
        self.clubAdress = [Utilities nullAndNilCheck:dict[@"clubAddressB"] replaceBy:@"未知"];
        self.clubSite = [Utilities nullAndNilCheck:dict[@"clubSite"] replaceBy:@"0"];
        self.time = [Utilities nullAndNilCheck:dict[@"clubTime"] replaceBy:@""];
        self.clubIntroduce = [Utilities nullAndNilCheck:dict[@"clubIntroduce"] replaceBy:@"wu"];
 
    }
    return self;
}
@end
