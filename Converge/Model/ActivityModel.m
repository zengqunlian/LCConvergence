//
//  ActivityModel.m
//  Converge
//
//  Created by admin on 2017/9/11.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

- (id) initWithDictionary: (NSDictionary *)dict{
    self = [super init];//self调用者本身
    if (self){
        _activtyId = [Utilities nullAndNilCheck:dict[@"id"] replaceBy:@"0"];
        _imgUrl = [dict[@"imgUrl"] isKindOfClass:[NSNull class]] ? @"":dict[@"imgUrl"];
        self.name = [dict[@"name"] isKindOfClass:[NSNull class]] ? @"活动" :dict[@"name"];
        self.content = [dict[@"content"] isKindOfClass:[NSNull class]] ? @"暂无内容" :dict[@"content"];
        self.like = [dict[@"reliableNumber"] isKindOfClass:[NSNull class]] ? 0 :[dict[@"reliableNumber"] integerValue];
        self.unlike = [dict[@"unReliableNumber"] isKindOfClass:[NSNull class]] ? 0 :[dict[@"unReliableNumber"] integerValue];
        self.isFavo = [dict[@"isFavo"] isKindOfClass:[NSNull class] ] ? NO :[dict[@"isFavo"] boolValue];
    }
    return self;
}

-(id)initWithDetailDictionary:(NSDictionary *)dict;{
    self = [super init];
    if (self) {
        _activtyId = [Utilities nullAndNilCheck:dict[@"id"] replaceBy:@"0"];
        _imgUrl =[Utilities nullAndNilCheck:dict [@"imgUrl"] replaceBy:@"imgUrl"];
        _content = [Utilities nullAndNilCheck:dict [@"content"] replaceBy:@"暂无内容"];
        _name =[Utilities nullAndNilCheck:dict [@"name"] replaceBy:@"暂无名称"];
        _like = [dict[@"reliableNumber"]isKindOfClass:[NSNull class]] ? 0 :[dict[@"reliableNumber"] integerValue] ;
        _unlike = [dict[@"unReliableNumber"]isKindOfClass:[NSNull class]] ? 0 :[dict[@"unReliableNumber"] integerValue] ;
        _address = [Utilities nullAndNilCheck:dict[@"address"] replaceBy:@"活动地址待定"];
        _applyFee = [Utilities nullAndNilCheck:dict[@"applicationFee"] replaceBy:@"0"];
        _attendence = [Utilities nullAndNilCheck:dict[@"participantsNumber"] replaceBy:@"0"];
        _limitation = [Utilities nullAndNilCheck:dict[@"attendenceAmount"] replaceBy:@"0"];
        _type = [Utilities nullAndNilCheck:dict[@"categoryName"] replaceBy:@"普通活动"];
        _issuer = [Utilities nullAndNilCheck:dict[@"issuerName"] replaceBy:@"未知发布者"];
        _phone = [Utilities nullAndNilCheck:dict[@"issuerPhone"] replaceBy:@""];
        _duetime = [dict[@"applicationExpirationDate"] isKindOfClass:[NSNull class]] ? (NSTimeInterval)0: (NSTimeInterval)[dict[@"applicationExpirationDate"] integerValue];
        _starttime = [dict[@"startDate"] isKindOfClass:[NSNull class]] ? (NSTimeInterval)0: (NSTimeInterval)[dict[@"startDate"] integerValue];
        _endtime = [dict[@"endDate"] isKindOfClass:[NSNull class]] ? (NSTimeInterval)0: (NSTimeInterval)[dict[@"endDate"] integerValue];
        _status = [dict[@"applyStatus"] isKindOfClass:[NSNull class]] ? -1: [dict[@"applyStatus"] integerValue];
        
        
    }
    return self;

}

@end
