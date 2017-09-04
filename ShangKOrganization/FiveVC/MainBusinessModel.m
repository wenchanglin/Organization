//
//  MainBusinessModel.m
//  ShangKOrganization
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MainBusinessModel.h"

@implementation MainBusinessModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setWithDic:(NSDictionary *)Dict
{
    if ([Dict objectForKey:@"name"])       {
        [self setBusinessName:[Dict objectForKey:@"name"]];
//        NSLog(@"分类名字%@",[Dict objectForKey:@"name"]);
    }
    if ([Dict objectForKey:@"id"])       {
        [self setBusinessId:[Dict objectForKey:@"id"]];
    }
    if ([[Dict objectForKey:@"isHad"] isKindOfClass:[NSNull class]])  {

    }else{
        [self setBusinessIsHad:[[Dict objectForKey:@"isHad"]integerValue]];
//        NSLog(@"是否%ld",[[Dict objectForKey:@"isHad"]integerValue]);
    }
}
@end
