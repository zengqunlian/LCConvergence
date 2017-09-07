//
//  homeModel.m
//  Converge
//
//  Created by admin on 2017/9/5.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "homeModel.h"

@implementation homeModel
- (instancetype)initWithDictForadvertise:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.imgUrl = [Utilities nullAndNilCheck:dict[@"imgurl"] replaceBy:@""];
        self.linkUrl = [Utilities nullAndNilCheck:dict[@"linkUrl"] replaceBy:@""];
        //self.integration = [Utilities nullAndNilCheck:dict[] replaceBy:<#(NSString *)#>]
    }
    return self;
}
- (instancetype)initWithDictForexperienceCell:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.advImage = [Utilities nullAndNilCheck:dict[@"image"] replaceBy:@""];
        self.adress = [Utilities nullAndNilCheck:dict[@"address"] replaceBy:@"未知"];
        self.distance = [Utilities nullAndNilCheck:dict[@"distance"] replaceBy:@"未知"];
        self.experienceName = [Utilities nullAndNilCheck:dict[@"name"] replaceBy:@"未知"];
        self.experienceImage = [Utilities nullAndNilCheck:dict[@"logo"] replaceBy:@""];
        if([dict[@"experience"]isKindOfClass:[NSNull class]]){
            _experArr = @[];
        }
        else
        {
            self.experArr = dict[@"experience"];
        }
    }
    return self;
}
@end
