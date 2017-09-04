//
//  ActivityRewardCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ActivityRewardCell.h"
@implementation ActivityRewardCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{

//    _SharePeopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth - 100, 15)];
//    _SharePeopleLabel.text = @"分享人:李钟硕";
    _SharePeopleLabel.font = [UIFont boldSystemFontOfSize:15];
    _ShareLuJLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth - 100, 15)];
    
    _ShareLuJLabel.font = [UIFont boldSystemFontOfSize:15];
    _ShareTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, kScreenWidth - 100, 15)];
    _ShareTimeLabel.font = [UIFont boldSystemFontOfSize:15];
//    NSMutableAttributedString *PriceStr = [[NSMutableAttributedString alloc]initWithString:@"+¥20.00"];
//    [PriceStr addAttribute:NSForegroundColorAttributeName value:kAppRedColor range:NSMakeRange(0, 7)];
    _SharePriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 80, 30, 80, 15)];
    _SharePriceLabel.textColor = kAppRedColor;
    _SharePriceLabel.font = [UIFont boldSystemFontOfSize:15];
    
    [self.contentView addSubview:_SharePriceLabel];
    [self.contentView addSubview:_ShareTimeLabel];
    
//    [self.contentView addSubview:_SharePeopleLabel];
}

//-(void)configWithMoEdl:(ActivityRewardModel *)Model
//{
//    NSLog(@"几点%@",Model.ActivityRewardCreateTime);
//    
//}











@end
