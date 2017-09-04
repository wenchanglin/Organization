//
//  ActivityRewardCell.h
//  ShangKOrganization
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityRewardModel.h"

@interface ActivityRewardCell : UITableViewCell
@property (nonatomic,strong)UILabel     *SharePeopleLabel;
@property (nonatomic,strong)UILabel     *ShareLuJLabel;
@property (nonatomic,strong)UILabel     *ShareTimeLabel;
@property (nonatomic,strong)UILabel     *SharePriceLabel;

//-(void)configWithMoEdl:(ActivityRewardModel *)Model;
@end
