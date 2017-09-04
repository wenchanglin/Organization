//
//  CompanyProfileSecondCell.m
//  ShangKOrganization
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "CompanyProfileSecondCell.h"

@implementation CompanyProfileSecondCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _CompanyProfileSecondActivityHome = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 60, 30)];
    [self.contentView addSubview:_CompanyProfileSecondActivityHome];
    _CompanyProfileSecondActivityHome.font = [UIFont systemFontOfSize:14];
    _CompanyProfileSecondActivityHome.text = @"段落二";
    _CompanyProfileSecondActivitySecondHome = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_CompanyProfileSecondActivitySecondHome.frame)+60, 20,[UIScreen mainScreen].bounds.size.width-20, 30)];
    [self.contentView addSubview:_CompanyProfileSecondActivitySecondHome];
    _CompanyProfileSecondActivitySecondHome.text = @"(只能上传一张图片哦)";
    _CompanyProfileSecondActivitySecondHome.textColor = [UIColor lightGrayColor];
    _CompanyProfileSecondActivitySecondHome.font = [UIFont systemFontOfSize:14];
    _CompanyProfileSecondFirstButton = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_CompanyProfileSecondActivitySecondHome.frame)+10, 160, 160)];
    [self.contentView addSubview:_CompanyProfileSecondFirstButton];
    [_CompanyProfileSecondFirstButton setBackgroundImage:[UIImage imageNamed:@"矩形-2-拷贝@2x.png"] forState:UIControlStateNormal];
    _CompanyProfileSecondFirstButton.backgroundColor = [UIColor cyanColor];
    
    _CompanyProfileSecondFirstTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_CompanyProfileSecondFirstButton.frame)+10, [UIScreen mainScreen].bounds.size.width-30, 120)];
    _CompanyProfileSecondFirstTextView.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_CompanyProfileSecondFirstTextView];
    _CompanyProfileSecondFirstTextView.backgroundColor = kAppWhiteColor;
    _CompanyProfileSecondActivityName = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(_CompanyProfileSecondFirstButton.frame)+8, 120, 30)];
    [self.contentView addSubview:_CompanyProfileSecondActivityName];
    _CompanyProfileSecondActivityName.text = @"请输入文字...";
    _CompanyProfileSecondActivityName.font = [UIFont systemFontOfSize:15];
    _CompanyProfileSecondActivityName.textColor = [UIColor lightGrayColor];
}
@end
