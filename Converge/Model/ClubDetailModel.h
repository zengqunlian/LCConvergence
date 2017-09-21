//
//  ClubDetailModel.h
//  Convergence
//
//  Created by admin001 on 2017/9/8.
//  Copyright © 2017年 EDucation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClubDetailModel : NSObject
@property(strong,nonatomic)NSString *clubAddress;
@property(strong,nonatomic)NSString *clubIntroduce;
@property(strong,nonatomic)NSString *clubLogo;
@property(strong,nonatomic)NSString *clubName;
@property(strong,nonatomic)NSString *clubTime;
@property(strong,nonatomic)NSString *eLogo;
@property(strong,nonatomic)NSString *eName;
@property(strong,nonatomic)NSString *price;
@property(strong,nonatomic)NSString *clubMember;
@property(strong,nonatomic)NSString *clubPerson;
@property(strong,nonatomic)NSString *clubSite;
@property(strong,nonatomic)NSString * clubTel;
@property(strong,nonatomic)NSString * eId;
@property(strong,nonatomic)NSString *number;
@property(strong,nonatomic)NSString *salaCount;
@property(strong,nonatomic)NSString *jing;
@property(strong,nonatomic)NSString *wei;
-(instancetype)initWithClubDetail:(NSDictionary *)dict;
-(instancetype)initWithExper:(NSDictionary *)dict;
@end
