//
//  detailModel.h
//  Converge
//
//  Created by admin on 2017/9/7.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface detailModel : NSObject
@property (strong,nonatomic)NSString *clubjing;
@property (strong,nonatomic)NSString *clubLogo;
@property (strong,nonatomic)NSString *clubMember;//会员数量
@property (strong,nonatomic)NSString *clubname;
@property (strong,nonatomic)NSString *clubPerson;//教练数量
@property (strong,nonatomic)NSString *clubIntroduce;
@property (strong,nonatomic)NSString *clubAdress;
@property (strong,nonatomic)NSString *clubSite;
@property (strong,nonatomic)NSArray *clubArr;
@property (strong,nonatomic)NSString *elogo;
@property (strong,nonatomic)NSString *eName;
@property (strong,nonatomic)NSString *price;
@property (strong,nonatomic)NSString *sell;
@property (strong,nonatomic)NSString *time;

//- (instancetype)initWithDetailexperience:(NSDictionary *)dict;
- (instancetype)initWithDetailclub:(NSDictionary *)dict;
- (instancetype)initWithclub:(NSDictionary *)dict;
@end
