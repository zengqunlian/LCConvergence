//
//  experienceModel.h
//  Converge
//
//  Created by admin on 2017/9/12.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface experienceModel : NSObject
@property (strong,nonatomic)NSString *experienceImage;
@property (strong,nonatomic)NSString *experienceAddress;
@property (strong,nonatomic)NSString *experienceName;
@property (strong,nonatomic)NSString *clubName;
@property (strong,nonatomic)NSString *orginPrice;
@property (strong,nonatomic)NSString *currentPrice;
@property (strong,nonatomic)NSString *rule;
@property (strong,nonatomic)NSString *prompt;
@property (strong,nonatomic)NSString *sell;
- (instancetype)initWithDetailexperience:(NSDictionary *)dict;
@end
