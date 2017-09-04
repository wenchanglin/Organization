//
//  CompanyFirCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "CompanyFirCell.h"
@implementation CompanyFirCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _TitLAbel      = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 100, 20)];
    _TitLAbel.font = [UIFont systemFontOfSize:17];
    _TitLAbel.text = @"机构LOGO";
    _ImaPic        = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-70, 10, 60, 60)];
    
    
    [self.contentView addSubview:_TitLAbel];
//    [self.contentView addSubview:_ImaPic];
}

@end
