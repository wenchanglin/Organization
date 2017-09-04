//
//  ZhengWenTableViewCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/9.
//  Copyright © 2016年 Fbw. All rights reserved.
//
#import "ZhengWenTableViewCell.h"


@implementation ZhengWenTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _activityHome = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 60, 30)];
    [self.contentView addSubview:_activityHome];
    _activityHome.font = [UIFont systemFontOfSize:14];
    _activityHome.text =@"展示图片";
    _activitySecondHome = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_activityHome.frame)+5, 20,[UIScreen mainScreen].bounds.size.width-20, 30)];
    [self.contentView addSubview:_activitySecondHome];
    _activitySecondHome.text = @"(此处为缩略图,展示时为原图长度)";
    _activitySecondHome.textColor = [UIColor lightGrayColor];
    _activitySecondHome.font = [UIFont systemFontOfSize:14];
    _firstButton = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_activitySecondHome.frame)+10, 160, 160)];
    [self.contentView addSubview:_firstButton];
    [_firstButton setBackgroundImage:[UIImage imageNamed:@"矩形-2-拷贝@2x.png"] forState:UIControlStateNormal];
    _firstButton.backgroundColor = [UIColor cyanColor];
    _firstLineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _firstLineButton.frame = CGRectMake(15, CGRectGetMaxY(_firstButton.frame)+10, kScreenWidth-30, 120);
    _firstLineButton.layer.borderWidth = 1;
    _firstLineButton.layer.borderColor = kAppLineColor.CGColor;
    _firstTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 6, kScreenWidth-40, 120)];
    _firstTextView.font = [UIFont systemFontOfSize:15];
    [_firstLineButton addSubview:_firstTextView];
    _firstTextView.backgroundColor = kAppWhiteColor;
    _activityName = [[UILabel alloc]initWithFrame:CGRectMake(6, 7, 150, 30)];
    [_firstLineButton addSubview:_activityName];
    _FirstLabelNum = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-125, 90, 100, 20)];
    _FirstLabelNum.textAlignment = NSTextAlignmentCenter;
    _FirstLabelNum.font = [UIFont systemFontOfSize:16];
    _FirstLabelNum.text = @"0/100";
    [_firstTextView addSubview:_FirstLabelNum];
    _activityName.text = @"请输入文字...";
    _activityName.font = [UIFont systemFontOfSize:15];
    _activityName.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_firstLineButton];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_firstTextView resignFirstResponder];
}


@end
