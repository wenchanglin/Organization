//
//  TeacherManagerModel.m
//  ShangKOrganization
//
//  Created by apple on 16/10/17.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "TeacherManagerModel.h"

@implementation TeacherManagerModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if (dic[@"userInfoBase"][@"nickName"])       {
        [self setTeacherManagerNickName:dic[@"userInfoBase"][@"nickName"]];
        NSLog(@"tttt%@",dic[@"userInfoBase"][@"nickName"]);
    }
    if (dic[@"userInfoBase"][@"userPhotoHead"]) {
        [self setTeacherManagerUserPhotoHead:dic[@"userInfoBase"][@"userPhotoHead"]];
        NSLog(@"看看图片哈%@",dic[@"userInfoBase"][@"userPhotoHead"]);
    }
    if ([dic[@"userInfoBase"][@"sex"]integerValue]) {
        [self setTeacherManagerSex:[dic[@"userInfoBase"][@"sex"]integerValue]];
    }
    if ([dic objectForKey:@"courseCount"]) {
        [self setTeacherManagerCourseCount:[[dic objectForKey:@"courseCount"]integerValue]];
    }
    if (dic[@"userInfoBase"][@"id"]) {
        [self setTeacherManagerId:dic[@"userInfoBase"][@"id"]];
        NSLog(@"ID%@",dic[@"userInfoBase"][@"id"]);
    }
    if ([dic objectForKey:@"userInfoBase"]) {
        [self setTeacherManagerDict:[dic objectForKey:@"userInfoBase"]];
    }
}
@end
