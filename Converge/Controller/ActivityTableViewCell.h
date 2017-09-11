//
//  ActivityTableViewCell.h
//  Converge
//
//  Created by admin on 2017/9/11.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;
@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityLikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityUnlikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoBtn;



@end
