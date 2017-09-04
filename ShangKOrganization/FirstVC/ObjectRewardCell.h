//
//  ObjectRewardCell.h
//  ShangKOrganization
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectRewardModel.h"
@interface ObjectRewardCell : UITableViewCell
@property (nonatomic,strong)UILabel *ObjectRewardName;
@property (nonatomic,strong)UILabel *ObjectRewardPrice;
@property (nonatomic,strong)UILabel *ObjectRewardTuiJianPrice;
@property (nonatomic,strong)UILabel *ObjectRewardTuiGuangPeople;
@property (nonatomic,strong)UILabel *ObjectRewardHuoJiangTime;
@property (nonatomic,strong)UILabel *ObjectRewardBuyPeople;
@property (nonatomic,strong)UILabel *ObjectRewardBuyTime;
@property (nonatomic,strong)UILabel *ObjectRewardGetPrice;

-(void)configWithMoDel:(ObjectRewardModel *)Model;
@end
