//
//  LunBoPicTableViewCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/9.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "LunBoPicTableViewCell.h"

@implementation LunBoPicTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    for (int i=0; i<2; i++) {
        _picBtn = [[UIButton alloc]initWithFrame:CGRectMake(15+i*(kScreenWidth/2-20), 20, kScreenWidth/2-30, kScreenWidth/2-30)];
        _picBtn.tag =10+i;
        if (_picBtn.tag == 10) {
            
            [_picBtn setBackgroundImage:[UIImage imageNamed:@"图层-59@2x_3.png"] forState:UIControlStateNormal];
        }else {
         [_picBtn setBackgroundImage:[UIImage imageNamed:@"矩形-2-拷贝@2x.png"] forState:UIControlStateNormal];
        }
        _picBtn.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_picBtn];
    [_picBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
  
    
}
-(void)btnClick:(UIButton *)button
{
    NSLog(@"buton.tag:%zd",button.tag);
}

@end
