//
//  MainBusinessCell.m
//  ShangKOrganization
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MainBusinessCell.h"

@implementation MainBusinessCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _AlerdayChoose = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100)/2, 10, 100, 20)];
    _AlerdayChoose.text = @"已选";
    _AlerdayChoose.textAlignment = NSTextAlignmentCenter;
    _AlerdayChoose.font = [UIFont systemFontOfSize:15];
    _AlerdayChoose.textColor = kAppBlackColor;
    _AlerdayLine = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_AlerdayChoose.frame)+10, kScreenWidth, 4)];
    _AlerdayLine.textColor = kAppRedColor;
    
    [self.contentView addSubview:_AlerdayChoose];
    [self.contentView addSubview:_AlerdayLine];
}

-(void)configWithModel:(MainBusinessModel *)Model
{
//    _SecondAlerdayChoose.text = Model.BusinessName;
}
@end
