//
//  MyOrderVC.h
//  ShangKOrganization
//
//  Created by apple on 16/9/15.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderVC : UIViewController
@property(nonatomic,copy) NSString         *PayTit;
@property (nonatomic,assign) NSInteger num;
@property (nonatomic,strong)NSMutableArray *dataOneArray;
@property (nonatomic,strong)UITableView    *firstView;
@property (nonatomic,strong)NSMutableArray *dataFiveArray;
@property (nonatomic,strong)UITableView    *fiveView;
@end
