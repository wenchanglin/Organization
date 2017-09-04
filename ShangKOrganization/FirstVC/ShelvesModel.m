//
//  ShelvesModel.m
//  ShangKOrganization
//
//  Created by apple on 16/11/2.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ShelvesModel.h"

@implementation ShelvesModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"name"])       {
        [self setShelvesName:[dic objectForKey:@"name"]];
    }
    if ([dic objectForKey:@"price"]) {
        [self setShelvesPrice:[dic objectForKey:@"price"]];
    }
    if ([dic objectForKey:@"photoList"]) {
        [self setShelvesPhotoList:[dic objectForKey:@"photoList"]];
    }
    if ([dic objectForKey:@"buyCount"]) {
        [self setShelvesBuyCount:[[dic objectForKey:@"buyCount"]integerValue]];
    }
    if ([dic objectForKey:@"shareCount"]) {
        [self setShelvesShareCount:[[dic objectForKey:@"shareCount"]integerValue]];
    }
    if ([dic objectForKey:@"id"]) {
        [self setShelvesId:[dic objectForKey:@"id"]];
        //        NSLog(@"%@",[dic objectForKey:@"id"]);
    }
}

-(void)setTDic:(NSDictionary *)Dict
{
    if ([Dict objectForKey:@"location"]) {
        [self setShelvesPhotoList:[Dict objectForKey:@"location"]];
    }
}
@end
