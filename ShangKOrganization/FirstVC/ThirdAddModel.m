//
//  ThirdAddModel.m
//  ShangKOrganization
//
//  Created by apple on 16/11/3.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ThirdAddModel.h"

@implementation ThirdAddModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"name"])       {
        [self setThirdAddName:[dic objectForKey:@"name"]];
    }
    if ([dic objectForKey:@"price"]) {
        [self setThirdAddPrice:[dic objectForKey:@"price"]];
    }
    if ([dic objectForKey:@"photoList"]) {
        [self setThirdAddPhotoList:[dic objectForKey:@"photoList"]];
    }
    if ([dic objectForKey:@"buyCount"]) {
        //[self setFourBuyCount:[[dic objectForKey:@"buyCount"]integerValue]];
    }
    if ([dic objectForKey:@"id"]) {
        [self setThirdAddId:[dic objectForKey:@"id"]];
        //        NSLog(@"%@",[dic objectForKey:@"id"]);
    }
}

@end
