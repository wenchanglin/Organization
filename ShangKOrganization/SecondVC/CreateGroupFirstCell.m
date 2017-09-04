//
//  CreateGroupFirstCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "CreateGroupFirstCell.h"
@implementation CreateGroupFirstCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _GroupFirstRow = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 60, 20)];
    _GroupFirstRow.text = @"群头像";
    _GroupFirstRow.font = [UIFont systemFontOfSize:15];
    _GroupFirstPic = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-80, 10, 50, 50)];
    _GroupFirstPic.layer.cornerRadius = 25;
    _GroupFirstPic.layer.masksToBounds = YES;
    
    [self.contentView addSubview:_GroupFirstRow];
//    [self.contentView addSubview:_GroupFirstPic];
}
@end
