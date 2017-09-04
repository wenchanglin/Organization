//
//  TransferRecordCell.h
//  ShangKOrganization
//
//  Created by apple on 16/12/12.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransferRecordModel.h"
@interface TransferRecordCell : UITableViewCell
@property (nonatomic,strong)UILabel *TransferRecordPeople;
@property (nonatomic,strong)UILabel *TransferRecordTime;
@property (nonatomic,strong)UILabel *TransferRecordMoney;

-(void)configWith:(TransferRecordModel *)Model;
@end
