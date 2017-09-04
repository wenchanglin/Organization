//
//  OrganizationActivityCell.h
//  ShangKOrganization
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrganizationActivityModel.h"
@interface OrganizationActivityCell : UITableViewCell
@property (nonatomic,strong)UIImageView *headPic;
@property (nonatomic,strong)UILabel     *TitleLLabel;
@property (nonatomic,strong)UILabel     *TimeLabel;
@property (nonatomic,strong)UILabel     *shareLabel;
@property (nonatomic,strong)UILabel     *ForwardLabel;
@property (nonatomic,strong)UILabel     *LineLabel;
@property (nonatomic,strong)UILabel     *PayStatusLabel;

-(void)configWithModel:(OrganizationActivityModel *)model;
@end
