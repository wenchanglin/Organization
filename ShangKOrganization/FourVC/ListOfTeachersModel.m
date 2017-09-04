//
//  ListOfTeachersModel.m
//  ShangKOrganization
//
//  Created by apple on 16/10/17.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ListOfTeachersModel.h"

@implementation ListOfTeachersModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"nickName"])       {
        [self setListOfTeacherNickName:[dic objectForKey:@"nickName"]];
    }
    if ([dic objectForKey:@"userPhotoHead"]) {
        [self setListOfTeacherUserPhotoHead:[dic objectForKey:@"userPhotoHead"]];
    }
    if ([dic objectForKey:@"id"]) {
        [self setListOfTeacherId:[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"age"]) {
        [self setListOfTeacherAge:[dic objectForKey:@"age"]];
    }
}
@end
