//
//  ShelvesCourseCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ShelvesCourseCell.h"

@implementation ShelvesCourseCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _ShelvesPic            = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
   
    _ShelvesTextLabel      = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, kScreenWidth - 110, 15)];
    _ShelvesTextLabel.font = [UIFont systemFontOfSize:17];
    _ShelvesBuyLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(_ShelvesTextLabel.frame)+35, kScreenWidth/5+30, 10)];
    
    _ShelvesBuyLabel.font  = [UIFont systemFontOfSize:17];
    
    _ShelvesTimeLabel      = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ShelvesBuyLabel.frame)+5, CGRectGetMaxY(_ShelvesTextLabel.frame)+35, kScreenWidth - 120, 10)];
    
    _ShelvesTimeLabel.font = [UIFont systemFontOfSize:17];
    _ShelvesLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_ShelvesPic.frame)+5, kScreenWidth, 1)];
    _ShelvesLineLabel.alpha     = 0.5;
    _ShelvesLineLabel.backgroundColor = kAppLineColor;
    
    _ShelvesPriceLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_ShelvesLineLabel.frame)+15, 100, 20)];
    _ShelvesPriceLabel.textColor = kAppRedColor;
    _ShelvesPriceLabel.font = [UIFont boldSystemFontOfSize:18];
    
    [self.contentView addSubview:_ShelvesPic];
    [self.contentView addSubview:_ShelvesLineLabel];
    [self.contentView addSubview:_ShelvesTimeLabel];
    [self.contentView addSubview:_ShelvesBuyLabel];
    [self.contentView addSubview:_ShelvesTextLabel];
    [self.contentView addSubview:_ShelvesPriceLabel];
}

-(void)configWithModel:(ShelvesModel *)Model
{
    _ShelvesTextLabel.text = Model.ShelvesName;
    if ([Model.ShelvesPhotoList isKindOfClass:[NSNull class]]) {
        _ShelvesPic.image      = [UIImage imageNamed:@"图层-68@2x.png"];
    }else{
        [_ShelvesPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.ShelvesPhotoList]] placeholderImage:nil];
    }
    NSMutableAttributedString *PriceStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已报名:%ld人",(long)Model.ShelvesBuyCount]];
    [PriceStr addAttribute:NSForegroundColorAttributeName value:kAppOrangeColor range:NSMakeRange(4, 1)];
    _ShelvesBuyLabel.attributedText = PriceStr;
    NSMutableAttributedString *FourStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥:%@",Model.ShelvesPrice]];
//    NSLog(@"!!%@",Model.ShelvesPrice);
    [FourStr addAttribute:NSForegroundColorAttributeName value:kAppRedColor range:NSMakeRange(0, 2)];
    _ShelvesPriceLabel.attributedText = FourStr;
    
    NSMutableAttributedString *ZhuanFaStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已转发:%ld次",(long)Model.ShelvesShareCount]];
    [ZhuanFaStr addAttribute:NSForegroundColorAttributeName value:kAppOrangeColor range:NSMakeRange(4, 1)];
    _ShelvesTimeLabel.attributedText = ZhuanFaStr;
}
@end
