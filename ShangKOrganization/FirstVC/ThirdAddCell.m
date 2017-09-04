//
//  ThirdAddCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ThirdAddCell.h"
@implementation ThirdAddCell

 -(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
 {
 if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
 [self createUI];
 }
 return self;
 }
 
 -(void)createUI
 {
 _ThirdPic            = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
 _ThirdPic.image      = [UIImage imageNamed:@"图层-68@2x.png"];
 _ThirdTextLabel      = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, kScreenWidth - 110, 15)];
 _ThirdTextLabel.text = @"小提琴基础课程小提琴基础课程小提琴基础课程小提琴基础课程小提琴基础课程";
 _ThirdTextLabel.numberOfLines = 0;
 CGRect textFrame   = _ThirdTextLabel.frame;
 _ThirdTextLabel.frame = CGRectMake(100, 10, kScreenWidth - 110, textFrame.size.height = [_ThirdTextLabel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:_ThirdTextLabel.font,NSFontAttributeName ,nil] context:nil].size.height);
 _ThirdTextLabel.frame = CGRectMake(100, 10, kScreenWidth - 110, textFrame.size.height);
 NSMutableAttributedString *PriceStr = [[NSMutableAttributedString alloc]initWithString:@"已报名:16人"];
 [PriceStr addAttribute:NSForegroundColorAttributeName value:kAppOrangeColor range:NSMakeRange(4, 2)];
 _ThirdBuyLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(_ThirdTextLabel.frame)+10, kScreenWidth/5+30, 10)];
 _ThirdBuyLabel.attributedText = PriceStr;
 _ThirdBuyLabel.font  = [UIFont systemFontOfSize:17];
 NSMutableAttributedString *ZhuanFaStr = [[NSMutableAttributedString alloc]initWithString:@"已转发:385次"];
 [ZhuanFaStr addAttribute:NSForegroundColorAttributeName value:kAppOrangeColor range:NSMakeRange(4, 3)];
 _ThirdTimeLabel      = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ThirdBuyLabel.frame)+5, CGRectGetMaxY(_ThirdTextLabel.frame)+10, kScreenWidth - 120, 10)];
 _ThirdTimeLabel.attributedText = ZhuanFaStr;
 _ThirdTimeLabel.font = [UIFont systemFontOfSize:17];
 _ThirdLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_ThirdTimeLabel.frame)+5, kScreenWidth, 1)];
 _ThirdLineLabel.alpha     = 0.5;
 _ThirdLineLabel.backgroundColor = kAppLineColor;
 NSMutableAttributedString *ThirdStr = [[NSMutableAttributedString alloc]initWithString:@"¥129.00"];
 [ThirdStr addAttribute:NSForegroundColorAttributeName value:kAppRedColor range:NSMakeRange(0, 7)];
 _ThirdPriceLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_ThirdLineLabel.frame)+15, 100, 20)];
 _ThirdPriceLabel.attributedText = ThirdStr;
 _ThirdPriceLabel.font = [UIFont boldSystemFontOfSize:18];
     
 
 [self.contentView addSubview:_ThirdPic];
 [self.contentView addSubview:_ThirdLineLabel];
 [self.contentView addSubview:_ThirdTimeLabel];
 [self.contentView addSubview:_ThirdBuyLabel];
 [self.contentView addSubview:_ThirdTextLabel];
 [self.contentView addSubview:_ThirdPriceLabel];
 }

 
@end
