//
//  CreateGroupFourCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "CreateGroupFourCell.h"
@implementation CreateGroupFourCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _GroupFourRow = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 60, 20)];
    _GroupFourRow.text = @"群管理";
    _GroupFourRow.font = [UIFont systemFontOfSize:15];
    _GroupFourInfoRow = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-110, 20, 100, 20)];
    _GroupFourInfoRow.placeholder= @"请选择群管理";
    _GroupFourInfoRow.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:_GroupFourRow];
    //[self.contentView addSubview:_GroupFourInfoRow];
}
@end
