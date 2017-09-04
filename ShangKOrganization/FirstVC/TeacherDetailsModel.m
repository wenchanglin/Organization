//
//  TeacherDetailsModel.m
//  ShangKOrganization
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "TeacherDetailsModel.h"

@implementation TeacherDetailsModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"id"]) {
        [self setTeacherDetailsId:[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"name"]) {
        [self setTeacherDetailsName:[dic objectForKey:@"name"]];
    }
    if ([dic objectForKey:@"price"]) {
        [self setTeacherDetailsPrice:[dic objectForKey:@"price"]];
    }
    if ([dic objectForKey:@"createTime"]) {
        [self setTeacherDetailsCreateTime:[dic objectForKey:@"createTime"]];
    }
    if ([dic objectForKey:@"photoList"]) {
        [self setTeacherDetailsPicPhoto:[dic objectForKey:@"photoList"]];
        NSLog(@"%@",[dic objectForKey:@"photoList"]);
    }
    if ([[dic objectForKey:@"submitCount"]integerValue]) {
        [self setTeacherDetailsSubmitCount:[[dic objectForKey:@"submitCount"]integerValue]];
    }
    if ([[dic objectForKey:@"buyCount"]integerValue]) {
        [self setTeacherDetailsBuyCount:[[dic objectForKey:@"buyCount"]integerValue]];
    }

}

-(void)setdic:(NSDictionary *)DICT
{
    if ([DICT objectForKey:@"location"]) {
        [self setTeacherDetailsPicPhoto:[DICT objectForKey:@"location"]];
        NSLog(@"%@",[DICT objectForKey:@"location"]);
    }
}
@end
