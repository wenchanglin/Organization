//
//  EventDetailsCell.m
//  ShangKOrganization
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EventDetailsCell.h"

@implementation EventDetailsCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _DetailsImage       = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    _DetailsImage.image = [UIImage imageNamed:@"图层-68@2x.png"];
    _DetailsName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_DetailsImage.frame)+10, 20, 150, 20)];
    _DetailsName.font   = [UIFont boldSystemFontOfSize:16];
    _DetailsPrice       = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_DetailsImage.frame)+10, CGRectGetMaxY(_DetailsName.frame)+10, 100, 20)];
    _DetailsPrice.textColor = kAppRedColor;
    _DetailsPrice.font  = [UIFont systemFontOfSize:15];
    _DetailsBuyCount    = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_DetailsImage.frame)+10, CGRectGetMaxY(_DetailsPrice.frame)+10, kScreenWidth/3.5, 20)];
    _DetailsBuyCount.font = [UIFont systemFontOfSize:15];
    _DetailsScore       = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_DetailsBuyCount.frame)+10, CGRectGetMaxY(_DetailsPrice.frame)+10, 80, 20)];
    _DetailsScore.font  = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:_DetailsImage];
    [self.contentView addSubview:_DetailsName];
    [self.contentView addSubview:_DetailsPrice];
    [self.contentView addSubview:_DetailsBuyCount];
    [self.contentView addSubview:_DetailsScore];
}

-(void)configWithMoedl:(EventDetailsModel *)Model
{
    _DetailsPrice.text = [NSString stringWithFormat:@"¥%@",Model.DetailsPrice];
    _DetailsName.text = Model.DetailsName;
    NSMutableAttributedString *AttbuteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld人已购买",(long)Model.DetailsBuyCount]];
    [AttbuteStr addAttribute:NSForegroundColorAttributeName value:kAppOrangeColor range:NSMakeRange(0, 1)];
    NSMutableAttributedString *BttbuteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@分",Model.DetailsScore]];
    [BttbuteStr addAttribute:NSForegroundColorAttributeName value:kAppOrangeColor range:NSMakeRange(0, 1)];
    _DetailsBuyCount.attributedText = AttbuteStr;
    _DetailsScore.attributedText    = BttbuteStr;
    
    //[_DetailsImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:nil];integerValue
}

@end
