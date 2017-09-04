//
//  InformCellThird.m
//  ShangKOrganization
//
//  Created by apple on 16/12/15.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "InformCellThird.h"

@implementation InformCellThird
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _FourthQuesk      = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 80, 20)];
    _FourthQuesk.font = [UIFont boldSystemFontOfSize:15];
    _FourthInfo       = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FourthQuesk.frame)+20, 5, kScreenWidth - 120, 40)];
    _FourthInfo.font  = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:_FourthQuesk];
    [self.contentView addSubview:_FourthInfo];
}

@end
