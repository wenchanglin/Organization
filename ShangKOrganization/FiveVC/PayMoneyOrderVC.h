//
//  PayMoneyOrderVC.h
//  ShangKOrganization
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayMoneyOrderVC : UIViewController
@property(nonatomic,assign) double SumPrice;
@property(nonatomic,copy) NSString *OrderId;
@property(nonatomic,copy) NSString *PayMoneyChoose;
@end
