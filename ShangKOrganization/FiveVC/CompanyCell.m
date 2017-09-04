//
//  CompanyCell.m
//  ShangKOrganization
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "CompanyCell.h"

@implementation CompanyCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _HeadPic           = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-80, 10, 70, 70)];
    _TitleLabel        = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, 80, 20)];
    _TitleLabel.font   = [UIFont systemFontOfSize:17];
    _InfoLabel         = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-130, 35, 120, 20)];
    _InfoLabel.font    = [UIFont systemFontOfSize:17];
    _InfoLabel.textAlignment = NSTextAlignmentRight;
    
    
    [self.contentView addSubview:_TitleLabel];
    [self.contentView addSubview:_HeadPic];
    [self.contentView addSubview:_InfoLabel];
}

@end
