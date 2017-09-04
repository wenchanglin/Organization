//
//  MyVideosModel.m
//  ShangKOrganization
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyVideosModel.h"

@implementation MyVideosModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"name"])       {
        [self setMyVideosName:[dic objectForKey:@"name"]];
    }
    if ([dic objectForKey:@"createTime"]) {
        [self setMyVideosCreateime:[dic objectForKey:@"createTime"]];
    }
    if ([dic objectForKey:@"photoUrl"]) {
        [self setMyVideosPhotoUrl:[dic objectForKey:@"photoUrl"]];
    }
    if ([dic objectForKey:@"price"]) {
        [self setMyVideosPrice:[dic objectForKey:@"price"]];
    }
    if ([dic objectForKey:@"id"]) {
        [self setMyVideosId:[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"fkVideoUserId"]) {
        [self setMyVideosFkVideoUserId:[dic objectForKey:@"fkVideoUserId"]];
    }
    if ([dic objectForKey:@"sellCount"]) {
        [self setMyVideosSellCount:[dic objectForKey:@"sellCount"]];
    }
}
@end
