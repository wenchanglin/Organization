//
//  EveryAchievementModel.m
//  ShangKOrganization
//
//  Created by apple on 16/10/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EveryAchievementModel.h"

@implementation EveryAchievementModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setWithDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"content"]) {
        [self setAchievementContent:[dic objectForKey:@"content"]];
        NSLog(@"%@",[dic objectForKey:@"content"]);
    }
}
@end
