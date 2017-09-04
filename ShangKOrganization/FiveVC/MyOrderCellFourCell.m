//
//  MyOrderCellFourCell.m
//  ShangKOrganization
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyOrderCellFourCell.h"

@implementation MyOrderCellFourCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
//
//    _SpHEjiTitle      = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
//    _SpHEjiTitle.adjustsFontSizeToFitWidth = YES;
//    _SpHEjiTitle.font = [UIFont systemFontOfSize:16];
    
//    [self.contentView addSubview:_SpHEjiTitle];
}


/**
 UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 deleteBtn.layer.borderColor = kAppLineColor.CGColor;
 deleteBtn.layer.borderWidth = 1;
 deleteBtn.tag = indexPath.section;
 [deleteBtn setTitle:@"删除订单" forState:UIControlStateNormal];
 deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
 [deleteBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
 [deleteBtn addTarget:self action:@selector(Btn:) forControlEvents:UIControlEventTouchUpInside];
 deleteBtn.frame = CGRectMake(kScreenWidth - 160, CGRectGetMaxY(cell.SpHEjiTitle.frame)+10, 65, 40);
 UIButton *modifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 [modifyBtn setTitle:@"支付" forState:UIControlStateNormal];
 modifyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
 [modifyBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
 modifyBtn.layer.borderColor = kAppLineColor.CGColor;
 modifyBtn.tag = indexPath.section;
 modifyBtn.layer.borderWidth = 1;
 modifyBtn.frame = CGRectMake(kScreenWidth - 90, CGRectGetMaxY(cell.SpHEjiTitle.frame)+10, 65, 40);
 [modifyBtn addTarget:self action:@selector(Bt:) forControlEvents:UIControlEventTouchUpInside];
 cell.DaiFuTitle.text   = @"待付款";
 
 [cell.contentView addSubview:cell.SpHEjiTitle];
 [cell.contentView addSubview:deleteBtn];
 [cell.contentView addSubview:modifyBtn];
 */
@end
