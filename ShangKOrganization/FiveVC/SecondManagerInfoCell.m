//
//  SecondManagerInfoCell.m
//  ShangKOrganization
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SecondManagerInfoCell.h"

@implementation SecondManagerInfoCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _SecTitleLabel        = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, 80, 20)];
    _SecTitleLabel.font   = [UIFont systemFontOfSize:17];
    _SecInfoLabel         = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-120, 35, 110, 20)];
    _SecInfoLabel.font    = [UIFont systemFontOfSize:17];
    _SecInfoLabel.textAlignment = NSTextAlignmentRight;
    _SecThirdTitle        = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, 80, 20)];
    _SecThirdTitle.font   = [UIFont systemFontOfSize:17];
    _SecInfo = [[UILabel alloc]initWithFrame:CGRectMake(25, 25, kScreenWidth - 35, 15)];
    _SecInfo.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    [self.contentView addSubview:_SecTitleLabel];
    [self.contentView addSubview:_SecInfoLabel];
    [self.contentView addSubview:_SecThirdTitle];
    [self.contentView addSubview:_SecInfo];
//    [self.contentView addSubview:_activityName];
}

@end
