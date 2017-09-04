//
//  TransferRecordModel.h
//  ShangKOrganization
//
//  Created by apple on 16/12/12.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransferRecordModel : NSObject
@property(nonatomic,copy) NSString *TransferRecordCreateTime;
@property(nonatomic,copy) NSString *TransferRecordMoney;
@property(nonatomic,copy) NSString *TransferRecordPeople;
@property (nonatomic,assign)NSInteger TransferRecordStatus;

-(void)setDic:(NSDictionary *)dic;
-(void)setPeople:(NSDictionary *)dic;
@end
