//
//  InformationThirdCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "InformationThirdCell.h"
@implementation InformationThirdCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _ThirdTit       = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    _ThirdTit.text  = @"资料补充";
    _ThirdTit.font  = [UIFont boldSystemFontOfSize:15];
    
    [self.contentView addSubview:_ThirdTit];
}
@end
