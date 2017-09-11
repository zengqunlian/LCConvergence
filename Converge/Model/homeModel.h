//
//  homeModel.h
//  Converge
//
//  Created by admin on 2017/9/5.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface homeModel : NSObject
@property (strong,nonatomic)NSString *imgUrl;
@property (strong,nonatomic)NSString *linkUrl;
@property (strong,nonatomic)NSString *experienceName;
@property (strong,nonatomic)NSString *experienceImage;
@property (strong,nonatomic)NSString *advImage;
@property (strong,nonatomic)NSString *adress;
@property (strong,nonatomic)NSString *distance;
@property (strong,nonatomic)NSArray *experArr;
@property (strong,nonatomic)NSString *hotelid;
- (instancetype)initWithDictForadvertise:(NSDictionary *)dict;
- (instancetype)initWithDictForexperienceCell:(NSDictionary *)dict;

@end
