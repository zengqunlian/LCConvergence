//
//  UserModel.h
//  Converge
//
//  Created by admin on 2017/9/7.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (strong,nonatomic) NSString *memberId;
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *nickname;
@property (strong,nonatomic) NSString *age;
//出生日期
@property (strong,nonatomic) NSString *dob;
@property (strong,nonatomic) NSString *idCardNo;
//性别
@property (strong,nonatomic) NSString *gender;
//用户头像网址
@property (strong,nonatomic) NSString *avatarUrl;
//令牌钥匙
@property (strong,nonatomic) NSString *tokenkey;
//积分
@property (strong,nonatomic) NSString *creadit;

-(id)initWithDictionary:(NSDictionary *)dict;


@end
