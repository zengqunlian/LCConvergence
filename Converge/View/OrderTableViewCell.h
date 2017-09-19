//
//  OrderTableViewCell.h
//  Converge
//
//  Created by admin on 2017/9/19.
//  Copyright © 2017年 Yixin studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *orderImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *clubNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;


@end
