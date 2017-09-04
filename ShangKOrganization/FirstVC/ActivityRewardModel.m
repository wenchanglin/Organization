//
//  ActivityRewardModel.m
//  ShangKOrganization
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ActivityRewardModel.h"

@implementation ActivityRewardModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"createTime"])       {
        [self setActivityRewardCreateTime:[dic objectForKey:@"createTime"]];
    }
    if ([dic objectForKey:@"id"])       {
        [self setActivityRewardId:[dic objectForKey:@"id"]];
    }
    if ([[dic objectForKey:@"type"]integerValue])       {
        [self setActivityRewardType:[[dic objectForKey:@"type"]integerValue]];
//        NSLog(@"爆炸吧%ld",[[dic objectForKey:@"type"]integerValue]);
    }
    if ([[dic objectForKey:@"income"] isKindOfClass:[NSNull class]])       {
        
        //        NSLog(@"爆炸吧%ld",[[dic objectForKey:@"type"]integerValue]);
        [self setActivityIncome:@"暂无奖励"];
    }else{
       [self setActivityIncome:[dic objectForKey:@"income"]];
    }
}
@end
