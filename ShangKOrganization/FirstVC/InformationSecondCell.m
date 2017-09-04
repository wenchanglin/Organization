//
//  InformationSecondCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "InformationSecondCell.h"
@implementation InformationSecondCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _SecondTit       = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth, 20)];
    _SecondTit.text  = @"请上传营业执照或手持身份证照（2选1）";
    _SecondTit.font  = [UIFont boldSystemFontOfSize:15];
    
    [self.contentView addSubview:_SecondTit];
}
@end
