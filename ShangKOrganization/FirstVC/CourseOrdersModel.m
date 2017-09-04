//
//  CourseOrdersModel.m
//  ShangKOrganization
//
//  Created by apple on 16/10/17.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "CourseOrdersModel.h"

@implementation CourseOrdersModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if (dic[@"course"][@"name"]) {
        [self setCourseOrderName:dic[@"course"][@"name"]];
    }
    if (dic[@"course"][@"photoList"]) {
        [self setCourseOrderContactPhotoList:dic[@"course"][@"photoList"]];
    }
    if ([dic objectForKey:@"contactName"]) {
        [self setCourseOrderContactName: [dic objectForKey:@"contactName"]];
    }
    if ([dic objectForKey:@"contactPhone"]) {
        [self setCourseOrderContactPhone:[dic objectForKey:@"contactPhone"]];
    }
    if ([dic objectForKey:@"createTime"]) {
        [self setCourseOrderCreateTime:  [dic objectForKey:@"createTime"]];
    }
    if ([dic objectForKey:@"refundReason"]) {
        [self setCourseOrderContactRefundReason:[dic objectForKey:@"refundReason"]];
    }
}
@end
