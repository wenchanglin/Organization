//
//  EventDetailsModel.m
//  ShangKOrganization
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EventDetailsModel.h"

@implementation EventDetailsModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([[dic objectForKey:@"photoList"]isKindOfClass:[NSNull class]]||[dic objectForKey:@"photoList"] == nil)       {

    }else{
        [self setDetailsPhotoList:[dic objectForKey:@"photoList"]];
    }
    if ([dic objectForKey:@"name"])     {
        [self setDetailsName:[dic objectForKey:@"name"]];
        NSLog(@"姓名%@",[dic objectForKey:@"name"]);
    }
    if ([dic objectForKey:@"price"])    {
        [self setDetailsPrice:[dic objectForKey:@"price"]];
    }
    if ([dic objectForKey:@"buyCount"]) {
//         NSLog(@"1");
//    }else{
       [self setDetailsBuyCount:[[dic objectForKey:@"buyCount"]integerValue]];
    }
    if ([dic objectForKey:@"avgScore"])    {
        [self setDetailsScore:[dic objectForKey:@"avgScore"]];
        NSLog(@"JJJ%ld",(long)[dic objectForKey:@"avgScore"]);
    }
    if ([dic objectForKey:@"id"])       {
        [self setDetailsId:[dic objectForKey:@"id"]];
    }
}
@end
