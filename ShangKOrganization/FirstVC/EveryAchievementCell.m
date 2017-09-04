//
//  EveryAchievementCell.m
//  ShangKOrganization
//
//  Created by apple on 16/12/4.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EveryAchievementCell.h"

@implementation EveryAchievementCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _FirstImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-100)];
    _FirstLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth, 20)];
    _FirstLabel.font = [UIFont systemFontOfSize:17];
    
    _SecondImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-100)];
    _SecondLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth, 20)];
    _SecondLabel.font = [UIFont systemFontOfSize:17];
}
@end
