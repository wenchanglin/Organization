//
//  InformationFirstCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "InformationFirstCell.h"
@implementation InformationFirstCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _FirstQuesk      = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 80, 20)];
    _FirstQuesk.font = [UIFont boldSystemFontOfSize:15];
    _FirstInfo       = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FirstQuesk.frame)+20, 5, kScreenWidth - 170, 40)];
    _FirstInfo.font  = [UIFont systemFontOfSize:15];
    _imageV          = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FirstInfo.frame)+10, 0, 30, 30)];
    
    [self.contentView addSubview:_FirstQuesk];
    [self.contentView addSubview:_FirstInfo];
}
@end
