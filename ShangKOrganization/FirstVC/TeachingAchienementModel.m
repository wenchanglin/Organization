//
//  TeachingAchienementModel.m
//  ShangKOrganization
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "TeachingAchienementModel.h"

@implementation TeachingAchienementModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setWithDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"id"]) {
        [self setAchienementId:[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"name"]) {
        [self setAchienementName:[dic objectForKey:@"name"]];
    }
    if ([dic objectForKey:@"headPhoto"]) {
        [self setAchienementHeadPhoto:[dic objectForKey:@"headPhoto"]];
    }
    if ([dic objectForKey:@"items"]) {
        [self setModelArray:[dic objectForKey:@"items"]];
//        NSLog(@"0=--0=-%@",[dic objectForKey:@"items"]);
    }

}

@end
