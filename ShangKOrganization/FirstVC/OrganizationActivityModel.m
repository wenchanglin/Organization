//
//  OrganizationActivityModel.m
//  ShangKOrganization
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "OrganizationActivityModel.h"

@implementation OrganizationActivityModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"id"]) {
        [self setActivityId:[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"name"]) {
        [self setActivityName:[dic objectForKey:@"name"]];
        NSLog(@"%@",[dic objectForKey:@"name"]);
    }
    if ([dic objectForKey:@"content"]) {
        [self setActivityContent:[dic objectForKey:@"content"]];
//        NSLog(@"%@",[dic objectForKey:@"content"]);
    }
    if ([dic objectForKey:@"createTime"]) {
        [self setActivityTime:[dic objectForKey:@"createTime"]];
    }
    if ([dic objectForKey:@"photoUrl"]) {
        [self setActivityPhoto:[dic objectForKey:@"photoUrl"]];
//        NSLog(@"%@",[dic objectForKey:@"photoUrl"]);
    }
    if ([[dic objectForKey:@"shareCount"]integerValue]) {
        [self setActivityShareCount:[[dic objectForKey:@"shareCount"]integerValue]];
    }
    if ([[dic objectForKey:@"payStatus"]integerValue]) {
        [self setActivityPayStatus:[[dic objectForKey:@"payStatus"]integerValue]];
    }
}

-(void)setTDic:(NSDictionary *)Dict
{
    if ([Dict  isKindOfClass:[NSNull class]]) {
        [self setActivityShareIncome:@"0"];
    }else{
      [self setActivityShareIncome:[Dict objectForKey:@"shareIncome"]];
        [self setActivityMaxCount:[Dict objectForKey:@"maxCount"]];
    }
    
}
@end
