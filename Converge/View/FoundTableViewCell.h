//
//  FoundTableViewCell.h
//  Converge
//
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoundTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UILabel *foundTitle1;
@property (weak, nonatomic) IBOutlet UILabel *foundTitle2;
@property (weak, nonatomic) IBOutlet UILabel *foundAdress1;
@property (weak, nonatomic) IBOutlet UILabel *foundAdress2;
@property (weak, nonatomic) IBOutlet UILabel *foundDistance1;
@property (weak, nonatomic) IBOutlet UILabel *foundDistance2;


@end
