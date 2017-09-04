//
//  EventDetailsCell.h
//  ShangKOrganization
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDetailsModel.h"

@interface EventDetailsCell : UITableViewCell
@property(nonatomic,strong) UIImageView *DetailsImage;
@property(nonatomic,strong) UILabel *DetailsName;
@property(nonatomic,strong) UILabel *DetailsPrice;
@property (nonatomic,strong)UILabel *DetailsScore;
@property (nonatomic,strong)UILabel *DetailsBuyCount;

-(void)configWithMoedl:(EventDetailsModel *)Model;
@end
