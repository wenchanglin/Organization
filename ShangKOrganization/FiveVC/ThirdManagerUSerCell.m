//
//  ThirdManagerUSerCell.m
//  ShangKOrganization
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ThirdManagerUSerCell.h"

@implementation ThirdManagerUSerCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _PersonLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, 80, 20)];
    _PersonLabel.text = @"个人简介";
    _PersonLabel.font   = [UIFont systemFontOfSize:17];
    _SecPerson = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_PersonLabel.frame)+10, [UIScreen mainScreen].bounds.size.width-30, 110)];
    _SecPerson.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_SecPerson];
    _SecPerson.backgroundColor = kAppWhiteColor;
    _activityName = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(_PersonLabel.frame)+8, 120, 30)];
    
    _activityName.text = @"请输入个人简介...";
    _activityName.font = [UIFont systemFontOfSize:15];
    _activityName.textColor = [UIColor lightGrayColor];
    
    
    [self.contentView addSubview:_SecPerson];
    [self.contentView addSubview:_PersonLabel];
//    [self.contentView addSubview:_activityName];
}
@end
