//
//  TransferRecordModel.m
//  ShangKOrganization
//
//  Created by apple on 16/12/12.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "TransferRecordModel.h"

@implementation TransferRecordModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"money"]) {
        [self setTransferRecordMoney:[dic objectForKey:@"money"]];
    }
    if ([[dic objectForKey:@"status"]integerValue]) {
        [self setTransferRecordStatus:[[dic objectForKey:@"status"]integerValue]];
    }
}

-(void)setPeople:(NSDictionary *)dic
{
    if ([dic objectForKey:@"nickName"]) {
        [self setTransferRecordPeople:[dic objectForKey:@"nickName"]];
    }
    if ([dic objectForKey:@"createTime"]) {
        [self setTransferRecordCreateTime:[dic objectForKey:@"createTime"]];
    }
}

@end
