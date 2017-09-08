//
//  detailModel.h
//  Converge
//
//  Created by admin on 2017/9/7.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface detailModel : NSObject
@property (strong,nonatomic)NSString *experienceName;
@property (strong,nonatomic)NSString *experienceImage;
@property (strong,nonatomic)NSString *advImage;
@property (strong,nonatomic)NSString *adress;
@property (strong,nonatomic)NSString *distance;
@property (strong,nonatomic)NSArray *experArr;
- (instancetype)initWithDetailDictionary:(NSDictionary *)dict;
@end
