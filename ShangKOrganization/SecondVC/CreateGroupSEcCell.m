//
//  CreateGroupSEcCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "CreateGroupSEcCell.h"
@implementation CreateGroupSEcCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _GroupSecRow = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 60, 20)];
    _GroupSecRow.text = @"群名称";
    _GroupSecRow.font = [UIFont systemFontOfSize:15];
    _GroupInfoRow = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-110, 15, 100, 20)];
    _GroupInfoRow.placeholder= @"请输入群名称";
    _GroupInfoRow.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:_GroupSecRow];
    [self.contentView addSubview:_GroupInfoRow];
}
@end
