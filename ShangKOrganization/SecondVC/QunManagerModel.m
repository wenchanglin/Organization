//
//  QunManagerModel.m
//  ShangKOrganization
//
//  Created by apple on 17/1/9.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import "QunManagerModel.h"

@implementation QunManagerModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if (dic[@"userInfoBase"][@"nickName"])       {
        [self setQunManagerNickName:dic[@"userInfoBase"][@"nickName"]];
        NSLog(@"tttt%@",dic[@"userInfoBase"][@"nickName"]);
    }
    if (dic[@"userInfoBase"][@"userPhotoHead"]) {
        [self setQunManagerUserPhotoHead:dic[@"userInfoBase"][@"userPhotoHead"]];
        NSLog(@"看看图片哈%@",dic[@"userInfoBase"][@"userPhotoHead"]);
    }
    if ([dic[@"userInfoBase"][@"sex"]integerValue]) {
        [self setQunManagerSex:[dic[@"userInfoBase"][@"sex"]integerValue]];
    }
    if ([dic objectForKey:@"courseCount"]) {
        [self setQunManagerCourseCount:[[dic objectForKey:@"courseCount"]integerValue]];
    }
    if (dic[@"userInfoBase"][@"id"]) {
        [self setQunManagerId:dic[@"userInfoBase"][@"id"]];
        NSLog(@"ID%@",dic[@"userInfoBase"][@"id"]);
    }
    if ([dic objectForKey:@"userInfoBase"]) {
        [self setQunManagerDict:[dic objectForKey:@"userInfoBase"]];
    }
}
@end
