//
//  AddTeachCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "AddTeachCell.h"
@implementation AddTeachCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _FouractivityHome = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 60, 30)];
    [self.contentView addSubview:_FouractivityHome];
    _FouractivityHome.font = [UIFont systemFontOfSize:14];
    _FouractivityHome.text =@"段落一";
    _FouractivityHome = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FouractivityHome.frame)+5, 20,[UIScreen mainScreen].bounds.size.width-20, 30)];
    [self.contentView addSubview:_FouractivityHome];
    _FouractivityHome.text = @"(只能上传一张图片哦)";
    _FouractivityHome.textColor = [UIColor lightGrayColor];
    _FouractivityHome.font = [UIFont systemFontOfSize:14];
    _FourButton = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_FouractivityHome.frame)+10, 160, 160)];
    [self.contentView addSubview:_FourButton];
    [_FourButton setBackgroundImage:[UIImage imageNamed:@"矩形-2-拷贝@2x.png"] forState:UIControlStateNormal];
    _FourButton.backgroundColor = [UIColor cyanColor];
    _FourLineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _FourLineButton.frame = CGRectMake(15, CGRectGetMaxY(_FourButton.frame)+10, kScreenWidth-30, 120);
    _FourLineButton.layer.borderWidth = 1;
    _FourLineButton.layer.borderColor = kAppLineColor.CGColor;
    _FourTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 6, kScreenWidth-40, 120)];
    
    [_FourLineButton addSubview:_FourTextView];
    _FourTextView.backgroundColor = kAppWhiteColor;
    _FouractivityName = [[UILabel alloc]initWithFrame:CGRectMake(6, 7, 150, 30)];
    [_FourLineButton addSubview:_FouractivityName];
    _FouractivityName.text = @"请输入文字...";
    _FouractivityName.font = [UIFont systemFontOfSize:15];
    _FouractivityName.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_FourLineButton];
    
    _FiveView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_FourLineButton.frame)+10, [UIScreen mainScreen].bounds.size.width, 1)];
        [self.contentView addSubview:_FiveView];
    _FiveView.backgroundColor = kAppLineColor;
    _FiveActivity = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_FiveView.frame)+10, 60, 30)];
        [self.contentView addSubview:_FiveActivity];
    _FiveActivity.font = [UIFont systemFontOfSize:15];
    _FiveActivity.text =@"段落二";
    _FiveActivityDetail = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FiveActivity.frame)+5, CGRectGetMaxY(_FiveView.frame)+10, 160, 30)];
    [self.contentView addSubview:_FiveActivityDetail];
    _FiveActivityDetail.font = [UIFont systemFontOfSize:14];
    _FiveActivityDetail.textColor = [UIColor lightGrayColor];
    _FiveActivityDetail.text =@"(只能上传一张图片哦)";
    _FiveButton = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_FiveActivityDetail.frame)+10, 160, 160)];
    [_FiveButton setBackgroundImage:[UIImage imageNamed:@"矩形-2-拷贝@2x.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_FiveButton];
    _FiveLineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _FiveLineButton.frame = CGRectMake(15, CGRectGetMaxY(_FiveButton.frame)+10, kScreenWidth-30, 120);
    _FiveLineButton.layer.borderWidth = 1;
    _FiveLineButton.layer.borderColor = kAppLineColor.CGColor;
    _FiveTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 6, kScreenWidth-40, 120)];
        [_FiveLineButton addSubview:_FiveTextView];
    _FiveTextView.backgroundColor = kAppWhiteColor;
    _FiveName = [[UILabel alloc]initWithFrame:CGRectMake(6, 7, 150, 30)];
        [_FiveLineButton addSubview:_FiveName];
    _FiveName.text = @"请输入文字...";
    _FiveName.font = [UIFont systemFontOfSize:15];
    _FiveName.textColor = [UIColor lightGrayColor];

    [self.contentView addSubview:_FiveLineButton];
}
@end
