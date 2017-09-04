//
//  StudentPeopleModel.m
//  ShangKOrganization
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "StudentPeopleModel.h"

@implementation StudentPeopleModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if (dic[@"userInfoBase"][@"nickName"])       {
        [self setStudentPeopleName:dic[@"userInfoBase"][@"nickName"]];
    }
    if (dic[@"userInfoBase"][@"phone"])       {
        [self setStudentPeoplePhone:dic[@"userInfoBase"][@"phone"]];
    }
    if (dic[@"userInfoBase"][@"id"])       {
        [self setStudentPeopleId:dic[@"userInfoBase"][@"id"]];
    }
    if (dic[@"userInfoBase"][@"createTime"])       {
        [self setStudentPeopleCreateTime:dic[@"userInfoBase"][@"createTime"]];
    }
    if (dic[@"userInfoBase"][@"userPhotoHead"])       {
        [self setStudentPeopleUserPhotoHead:dic[@"userInfoBase"][@"userPhotoHead"]];
    }
}

-(void)SetLuRuStudent:(NSDictionary *)Dic
{
    if ([Dic objectForKey:@"nickName"])       {
        [self setStudentPeopleName:[Dic objectForKey:@"nickName"]];
    }
    if ([Dic objectForKey:@"phone"])       {
        [self setStudentPeoplePhone:[Dic objectForKey:@"phone"]];
    }
    if ([Dic objectForKey:@"id"])       {
        [self setStudentPeopleId:[Dic objectForKey:@"id"]];
    }
    if ([Dic objectForKey:@"createTime"])       {
        [self setStudentPeopleCreateTime:[Dic objectForKey:@"createTime"]];
    }
    if ([[Dic objectForKey:@"userPhotoHead"] isKindOfClass:[NSNull class]]) {
        
    }else{
        [self setStudentPeopleUserPhotoHead:[Dic objectForKey:@"userPhotoHead"]];
    }
}
@end
