//
//  ActivityRewardModel.h
//  ShangKOrganization
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityRewardModel : NSObject
@property(nonatomic,copy) NSString *ActivityRewardCreateTime;
@property(nonatomic,copy) NSString *ActivityRewardId;
@property (nonatomic,assign)NSInteger ActivityRewardType;
@property (nonatomic,copy)NSString  *ActivityIncome;

-(void)setDic:(NSDictionary *)dic;
@end
