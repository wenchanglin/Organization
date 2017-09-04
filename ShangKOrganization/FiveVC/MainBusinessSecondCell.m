//
//  MainBusinessSecondCell.m
//  ShangKOrganization
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MainBusinessSecondCell.h"

@implementation MainBusinessSecondCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _SecondAlerdayChoose = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100)/2, 10, 100, 20)];
    _SecondAlerdayChoose.text = @"未选";
    _SecondAlerdayChoose.textAlignment = NSTextAlignmentCenter;
    _SecondAlerdayChoose.font = [UIFont systemFontOfSize:15];
    _SecondAlerdayChoose.textColor = kAppBlackColor;
    _SecondAlerdayLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, kScreenWidth, 1)];
    _SecondAlerdayLine.textColor = kAppLineColor;
    
    [self.contentView addSubview:_SecondAlerdayChoose];
    [self.contentView addSubview:_SecondAlerdayLine];
}

-(void)configWithModel:(MainBusinessModel *)Model
{
//    _SecondAlerdayChoose.text = Model.BusinessName;
}

@end
