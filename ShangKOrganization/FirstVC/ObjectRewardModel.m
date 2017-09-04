//
//  ObjectRewardModel.m
//  ShangKOrganization
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ObjectRewardModel.h"

@implementation ObjectRewardModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"contactName"])       {
        [self setObjectRewardContactName:[dic objectForKey:@"contactName"]];
    }
    if ([dic objectForKey:@"sumPrice"])       {
        [self setObjectRewardSumPrice:[dic objectForKey:@"sumPrice"]];
        NSLog(@"不知道啥钱%@",[dic objectForKey:@"sumPrice"]);
    }
    if ([dic objectForKey:@"guideDetail"])       {
        [self setObjectRewardGuideDetail:[dic objectForKey:@"guideDetail"]];
        NSLog(@"不知道啥钱er%@",[dic objectForKey:@"guideDetail"]);
    }
}

-(void)serDict:(NSDictionary *)dic
{
    NSLog(@"是不是空%@",dic);
    if ([[dic objectForKey:@"nickName"] isKindOfClass:[NSNull class]])       {
        [self setObjectRewardNickName:@"暂无昵称"];
    }else{
        [self setObjectRewardNickName:[dic objectForKey:@"nickName"]];
        NSLog(@"%@",[dic objectForKey:@"nickName"]);
    }
    if ([[dic objectForKey:@"createTime"]isKindOfClass:[NSNull class]])       {
        [self setObjectRewardCreateTime:@"暂无时间"];
    }else{
        [self setObjectRewardCreateTime:[dic objectForKey:@"createTime"]];
    }
}

-(void)setBuyCourseDic:(NSDictionary *)CourseDic
{
    if ([CourseDic objectForKey:@"name"]) {
        [self setObjectRewardCourseName:[CourseDic objectForKey:@"name"]];
    }
}

-(void)setBuyDic:(NSDictionary *)dict
{
    if ([dict objectForKey:@"nickName"])       {
        [self setObjectRewardBuyNickName:[dict objectForKey:@"nickName"]];
        NSLog(@"教师%@",[dict objectForKey:@"nickName"]);
    }
    if ([dict objectForKey:@"createTime"])       {
        [self setObjectRewardBuyCreateTime:[dict objectForKey:@"createTime"]];
    }
}
@end
