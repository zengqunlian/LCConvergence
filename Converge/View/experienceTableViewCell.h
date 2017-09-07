//
//  experienceTableViewCell.h
//  Converge
//
//  Created by admin on 2017/9/6.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface experienceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *experienceImageView;
@property (weak, nonatomic) IBOutlet UILabel *experienceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *integrationLabel;//综合卷
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellLabel;
@end
