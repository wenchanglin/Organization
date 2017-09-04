//
//  FourModel.m
//  ShangKOrganization
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FourModel.h"

@implementation FourModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"name"])       {
        [self setFourName:[dic objectForKey:@"name"]];
    }
    if ([dic objectForKey:@"price"]) {
        [self setFourPrice:[dic objectForKey:@"price"]];
    }
    if ([dic objectForKey:@"photoList"]) {
        [self setFourPhotoList:[dic objectForKey:@"photoList"]];
    }
    if ([[dic objectForKey:@"buyCount"]integerValue]) {
        [self setFourBuyCount:[[dic objectForKey:@"buyCount"]integerValue]];
    }
    if ([[dic objectForKey:@"payStatus"]integerValue]) {
        [self setFourPayStatus:[[dic objectForKey:@"payStatus"]integerValue]];
        NSLog(@"炸裂买了么%ld",[[dic objectForKey:@"payStatus"]integerValue]);
    }
    if ([[dic objectForKey:@"shareCount"]integerValue]) {
        [self setFourShareCount:[[dic objectForKey:@"shareCount"]integerValue]];
    }
    if ([dic objectForKey:@"id"]) {
        [self setFourId:[dic objectForKey:@"id"]];
//        NSLog(@"%@",[dic objectForKey:@"id"]);
    }
}

-(void)setTDic:(NSDictionary *)Dict
{
    if ([Dict objectForKey:@"location"]) {
        [self setFourPhotoList:[Dict objectForKey:@"location"]];
    }
}
@end
