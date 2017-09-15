//
//  ActivityModel.h
//  Converge
//
//  Created by admin on 2017/9/11.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject

@property (strong, nonatomic) NSString *activtyId;//活动Id
@property (strong,nonatomic) NSString *imgUrl; //活动图片url字符串
@property (strong,nonatomic) NSString *name;   //活动名称
@property (strong,nonatomic) NSString *content;//活动内容
@property (nonatomic) NSInteger like;                 //活动点赞数
@property (nonatomic) NSInteger unlike;             //活动被踩数
@property (nonatomic) BOOL isFavo;                   //活动是否被收藏
@property (strong,nonatomic) NSString *address;//报名费
@property (strong,nonatomic) NSString *applyFee;//报名状态
@property (strong,nonatomic) NSString *attendence;//报名人数
@property (strong,nonatomic) NSString *limitation;//限制报名人数
@property (strong,nonatomic) NSString *type;//类型
@property (strong,nonatomic) NSString *issuer;//发布者名字
@property (strong,nonatomic) NSString *phone;//发布者电话号码
@property (nonatomic) NSTimeInterval duetime;//截止时间
@property (nonatomic) NSTimeInterval starttime;//开始时间
@property (nonatomic) NSTimeInterval endtime;//结束时间
@property (nonatomic) NSInteger status;//状态



-(id)initWithDictionary:(NSDictionary *)dict;
-(id)initWithDetailDictionary:(NSDictionary *)dict;



@end
