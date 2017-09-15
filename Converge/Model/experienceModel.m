//
//  experienceModel.m
//  Converge
//
//  Created by admin on 2017/9/12.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "experienceModel.h"

@implementation experienceModel
- (instancetype)initWithDetailexperience:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.experienceName = [Utilities nullAndNilCheck:dict[@"eName"] replaceBy:@"未知"];
        self.experienceImage = [Utilities nullAndNilCheck:dict[@"eLogo"] replaceBy:@""];
        self.experienceAddress = [Utilities nullAndNilCheck:dict[@"eAddress"] replaceBy:@"未知"];
        self.clubName = [Utilities nullAndNilCheck:dict[@"eClubName"] replaceBy:@"未知"];
        self.orginPrice = [Utilities nullAndNilCheck:dict[@"orginPrice"] replaceBy:@"未知"];
        self.currentPrice = [Utilities nullAndNilCheck:dict[@"currentPrice"] replaceBy:@"未知"];
        self.rule = [Utilities nullAndNilCheck:dict[@"rules"] replaceBy:@"未知"];
        self.prompt = [Utilities nullAndNilCheck:dict[@"ePromot"] replaceBy:@"未知"];
        self.sell = [Utilities nullAndNilCheck:dict[@"saleCount"] replaceBy:@"0"];
        self.useRule = [Utilities nullAndNilCheck:dict[@"rules"] replaceBy:@""];
        self.startTime = [Utilities nullAndNilCheck:dict[@"beginDate"] replaceBy:@""];
        self.endTime = [Utilities nullAndNilCheck:dict[@"endDate"] replaceBy:@""];
        
    }
    return self;
}
@end
