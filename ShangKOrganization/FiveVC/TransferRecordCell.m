//
//  TransferRecordCell.m
//  ShangKOrganization
//
//  Created by apple on 16/12/12.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "TransferRecordCell.h"

@implementation TransferRecordCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _TransferRecordPeople = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth/2, 20)];
    _TransferRecordPeople.font =[UIFont boldSystemFontOfSize:17];
    _TransferRecordTime = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_TransferRecordPeople.frame)+15, kScreenWidth/2, 15)];
    _TransferRecordTime.font =[UIFont systemFontOfSize:14];
    _TransferRecordMoney = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-80, 25, 70, 20)];
    _TransferRecordMoney.textColor = kAppOrangeColor;
    _TransferRecordMoney.font = [UIFont boldSystemFontOfSize:17];
    _TransferRecordMoney.textAlignment = NSTextAlignmentCenter;
    
//    [self.contentView addSubview:_TransferRecordPeople];
    [self.contentView addSubview:_TransferRecordTime];
    [self.contentView addSubview:_TransferRecordMoney];
    
}

-(void)configWith:(TransferRecordModel *)Model
{
    NSString * timeStampString = Model.TransferRecordCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _TransferRecordTime.text = [NSString stringWithFormat:@"%@",time];
    _TransferRecordMoney.text = [NSString stringWithFormat:@"+%@",Model.TransferRecordMoney];
    
}

@end
