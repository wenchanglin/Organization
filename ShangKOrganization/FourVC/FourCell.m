//
//  FourCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FourCell.h"
@implementation FourCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _FourPic            = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    _FourTextLabel      = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, kScreenWidth - 210, 15)];
    _FourTextLabel.font = [UIFont systemFontOfSize:17];
    _FourPayStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FourTextLabel.frame)+10, 15, 100, 15)];
    _FourPayStatusLabel.font = [UIFont systemFontOfSize:17];
    _FourPayStatusLabel.textColor = kAppRedColor;
//    _FourTextLabel.numberOfLines = 0;
//    CGRect textFrame   = _FourTextLabel.frame;
//    _FourTextLabel.frame = CGRectMake(100, 10, kScreenWidth - 110, textFrame.size.height = [_FourTextLabel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:_FourTextLabel.font,NSFontAttributeName ,nil] context:nil].size.height);
    //_FourTextLabel.frame = CGRectMake(100, 10, kScreenWidth - 110, textFrame.size.height);
    
    _FourBuyLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(_FourTextLabel.frame)+35, kScreenWidth/5+30, 10)];
    
    _FourBuyLabel.font  = [UIFont systemFontOfSize:17];
    _FourTimeLabel      = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FourBuyLabel.frame)+5, CGRectGetMaxY(_FourTextLabel.frame)+35, kScreenWidth - 120, 10)];
    _FourLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_FourPic.frame)+5, kScreenWidth, 1)];
    _FourLineLabel.alpha     = 0.5;
    _FourLineLabel.backgroundColor = kAppLineColor;
    
    _FourPriceLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_FourLineLabel.frame)+15, 100, 20)];
    _FourPriceLabel.textColor = kAppRedColor;
    _FourPriceLabel.font = [UIFont boldSystemFontOfSize:18];
    
    [self.contentView addSubview:_FourPic];
    [self.contentView addSubview:_FourLineLabel];
    [self.contentView addSubview:_FourBuyLabel];
    [self.contentView addSubview:_FourTextLabel];
//    [self.contentView addSubview:_FourPayStatusLabel];
    [self.contentView addSubview:_FourPriceLabel];
    [self.contentView addSubview:_FourTimeLabel];
}

-(void)configWithModel:(FourModel *)Model
{
    
    _FourTextLabel.text = Model.FourName;
    NSMutableAttributedString *PriceStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已报名:%ld人",(long)Model.FourBuyCount]];
    [PriceStr addAttribute:NSForegroundColorAttributeName value:kAppOrangeColor range:NSMakeRange(4, 1)];
    _FourBuyLabel.attributedText = PriceStr;
    NSMutableAttributedString *FourStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥:%@",Model.FourPrice]];
    [FourStr addAttribute:NSForegroundColorAttributeName value:kAppRedColor range:NSMakeRange(0, 2)];
    _FourPriceLabel.attributedText = FourStr;
    if ([Model.FourPhotoList isKindOfClass:[NSNull class]]) {
        _FourPic.image      = [UIImage imageNamed:@"哭脸.png"];
    }else{
        [_FourPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.FourPhotoList]] placeholderImage:nil];
    }
    NSMutableAttributedString *ZhuanFaStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已转发:%ld次",(long)Model.FourShareCount]];
    [ZhuanFaStr addAttribute:NSForegroundColorAttributeName value:kAppOrangeColor range:NSMakeRange(4, 1)];
    
    _FourTimeLabel.attributedText = ZhuanFaStr;
    _FourTimeLabel.font = [UIFont systemFontOfSize:17];

}


@end
