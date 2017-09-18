//
//  FoundModel.m
//  Converge
//
//  Created by admin on 2017/9/16.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "FoundModel.h"

@implementation FoundModel

-(instancetype)initWithArr:(NSDictionary *)dict{
    self = [super init];
    if(self){ _hotArr = [dict[@"hot"] isKindOfClass:[NSNull class]] ? @[] :dict[@"hot"];
        _upgradedArr = [dict[@"upgraded"] isKindOfClass:[NSNull class]] ?@[]:dict[@"upgraded"];
    }
    return self;
}
-(instancetype)initWithClub:(NSDictionary *)dict{
    self = [super init];
    if(self){
        _clubId = [Utilities nullAndNilCheck:dict[@"clubId"] replaceBy:@""];
        _clubName = [Utilities nullAndNilCheck:dict[@"clubName"] replaceBy:@""];
        _image = [Utilities nullAndNilCheck:dict[@"clubLogo"] replaceBy:@""];
        _address = [Utilities nullAndNilCheck:dict[@"clubAddressB"] replaceBy:@""];
        _distance= [Utilities nullAndNilCheck:dict[@"distance"] replaceBy:@""];
    }
    return self;
}
-(instancetype)initWithType:(NSDictionary *)dict{
    self = [super init];
    if(self){
        _fId = [Utilities nullAndNilCheck:dict[@"fId"] replaceBy:@""];
        _fName = [Utilities nullAndNilCheck:dict[@"fName"] replaceBy:@""];
        _total = [Utilities nullAndNilCheck:dict[@"total"] replaceBy:@""];
        
    }
    return self;
}


@end
