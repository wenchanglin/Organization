//
//  ObjectRewardCell.m
//  ShangKOrganization
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ObjectRewardCell.h"

@implementation ObjectRewardCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _ObjectRewardName = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 20)];
    _ObjectRewardName.font = [UIFont boldSystemFontOfSize:15];
    
    _ObjectRewardPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_ObjectRewardName.frame)+10, 120, 20)];
    _ObjectRewardPrice.font = [UIFont boldSystemFontOfSize:15];
    
    _ObjectRewardTuiJianPrice = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ObjectRewardPrice.frame)+10, CGRectGetMaxY(_ObjectRewardName.frame)+10, 120, 20)];
    _ObjectRewardTuiJianPrice.font = [UIFont boldSystemFontOfSize:15];
    
    _ObjectRewardTuiGuangPeople = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_ObjectRewardTuiJianPrice.frame)+10, 120, 20)];
    _ObjectRewardTuiGuangPeople.font = [UIFont boldSystemFontOfSize:15];
    
    _ObjectRewardHuoJiangTime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ObjectRewardTuiGuangPeople.frame)+10, CGRectGetMaxY(_ObjectRewardTuiJianPrice.frame)+10, kScreenWidth-140, 20)];
    _ObjectRewardHuoJiangTime.font = [UIFont boldSystemFontOfSize:15];
    
    _ObjectRewardBuyPeople = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_ObjectRewardTuiGuangPeople.frame)+10, 120, 20)];
    _ObjectRewardBuyPeople.font = [UIFont boldSystemFontOfSize:15];
   
    _ObjectRewardBuyTime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ObjectRewardBuyPeople.frame)+10, CGRectGetMaxY(_ObjectRewardHuoJiangTime.frame)+10, kScreenWidth-140, 20)];
    _ObjectRewardBuyTime.font = [UIFont boldSystemFontOfSize:15];
    
    _ObjectRewardGetPrice = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-130, CGRectGetMaxY(_ObjectRewardBuyTime.frame)+10, 120, 20)];
    _ObjectRewardGetPrice.font = [UIFont boldSystemFontOfSize:15];
    _ObjectRewardGetPrice.textColor = kAppOrangeColor;
    
    [self.contentView addSubview:_ObjectRewardName];
    [self.contentView addSubview:_ObjectRewardPrice];
    [self.contentView addSubview:_ObjectRewardTuiJianPrice];
    [self.contentView addSubview:_ObjectRewardTuiGuangPeople];
    [self.contentView addSubview:_ObjectRewardHuoJiangTime];
    [self.contentView addSubview:_ObjectRewardBuyPeople];
    [self.contentView addSubview:_ObjectRewardBuyTime];
    [self.contentView addSubview:_ObjectRewardGetPrice];
}

-(void)configWithMoDel:(ObjectRewardModel *)Model
{
    _ObjectRewardGetPrice.text = [NSString stringWithFormat:@"获得奖励:¥%@",Model.ObjectRewardSumPrice];
    _ObjectRewardName.text =  [NSString stringWithFormat:@"课程名称:%@",Model.ObjectRewardCourseName];
    _ObjectRewardPrice.text = [NSString stringWithFormat:@"课程价格:%@",Model.ObjectRewardSumPrice];//,Model.ObjectRewardSumPrice
    _ObjectRewardTuiJianPrice.text = @"推荐奖励:暂为空";
    _ObjectRewardTuiGuangPeople.text = [NSString stringWithFormat:@"推广人:%@",Model.ObjectRewardContactName];
    NSString * timeStampString = Model.ObjectRewardCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _ObjectRewardHuoJiangTime.text = [NSString stringWithFormat:@"获奖时间:%@",time];
     _ObjectRewardBuyPeople.text = [NSString stringWithFormat:@"购买人:%@",Model.ObjectRewardBuyNickName];
    NSString * timeStampString1 = Model.ObjectRewardBuyCreateTime;
    NSTimeInterval _interval1=[timeStampString1 doubleValue] / 1000.0;
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:_interval1];
    NSDateFormatter *objDateformat1 = [[NSDateFormatter alloc] init];
    [objDateformat1 setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time1 = [objDateformat stringFromDate: date1];
    _ObjectRewardBuyTime.text = [NSString stringWithFormat:@"购买时间:%@",time1];
    
}
@end
