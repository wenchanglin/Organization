//
//  CompanyProfileThirdCell.m
//  ShangKOrganization
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "CompanyProfileThirdCell.h"

@implementation CompanyProfileThirdCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _CompanyProfileThirdActivityHome = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 60, 30)];
    [self.contentView addSubview:_CompanyProfileThirdActivityHome];
    _CompanyProfileThirdActivityHome.font = [UIFont systemFontOfSize:14];
    _CompanyProfileThirdActivityHome.text = @"段落三";
    _CompanyProfileThirdActivitySecondHome = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_CompanyProfileThirdActivitySecondHome.frame)+60, 20,[UIScreen mainScreen].bounds.size.width-20, 30)];
    [self.contentView addSubview:_CompanyProfileThirdActivitySecondHome];
    _CompanyProfileThirdActivitySecondHome.text = @"(只能上传一张图片哦)";
    _CompanyProfileThirdActivitySecondHome.textColor = [UIColor lightGrayColor];
    _CompanyProfileThirdActivitySecondHome.font = [UIFont systemFontOfSize:14];
    _CompanyProfileThirdFirstButton = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_CompanyProfileThirdActivitySecondHome.frame)+10, 160, 160)];
    [self.contentView addSubview:_CompanyProfileThirdFirstButton];
    [_CompanyProfileThirdFirstButton setBackgroundImage:[UIImage imageNamed:@"矩形-2-拷贝@2x.png"] forState:UIControlStateNormal];
    _CompanyProfileThirdFirstButton.backgroundColor = [UIColor cyanColor];
    
    _CompanyProfileThirdFirstTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_CompanyProfileThirdFirstButton.frame)+10, [UIScreen mainScreen].bounds.size.width-30, 120)];
    _CompanyProfileThirdFirstTextView.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_CompanyProfileThirdFirstTextView];
    _CompanyProfileThirdFirstTextView.backgroundColor = kAppWhiteColor;
    _CompanyProfileThirdActivityName = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(_CompanyProfileThirdFirstButton.frame)+8, 120, 30)];
    [self.contentView addSubview:_CompanyProfileThirdActivityName];
    _CompanyProfileThirdActivityName.text = @"请输入文字...";
    _CompanyProfileThirdActivityName.font = [UIFont systemFontOfSize:15];
    _CompanyProfileThirdActivityName.textColor = [UIColor lightGrayColor];
}
@end
