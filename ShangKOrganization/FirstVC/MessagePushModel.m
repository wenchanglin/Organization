//
//  MessagePushModel.m
//  ShangKOrganization
//
//  Created by apple on 16/11/3.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MessagePushModel.h"

@implementation MessagePushModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"title"]) {
        [self setPushMessageTitle:[dic objectForKey:@"title"]];
        NSLog(@"哈哈%@",[dic objectForKey:@"title"]);
    }
    if ([dic objectForKey:@"createTime"]) {
        [self setPushMessageCreateTime:[dic objectForKey:@"createTime"]];
    }
    if ([dic objectForKey:@"id"]) {
        [self setPushMessageId:[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"fkOrgNotice"]) {
        [self setPushMessageFkOrgNotice:[dic objectForKey:@"fkOrgNotice"]];
        NSLog(@"%@",[dic objectForKey:@"fkOrgNotice"]);
    }
}
@end
