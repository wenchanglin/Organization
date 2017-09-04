//
//  FriendDanChatModel.m
//  ShangKOrganization
//
//  Created by apple on 16/11/16.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FriendDanChatModel.h"

@implementation FriendDanChatModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"createTime"]) {
        [self setFriendDanChatCreateTime:[dic objectForKey:@"createTime"]];
    }
    if ([dic objectForKey:@"fkFriendUserId"]) {
        [self setFriendDanChatId:[dic objectForKey:@"fkFriendUserId"]];
        NSLog(@"让我看看那你%@",[dic objectForKey:@"fkFriendUserId"]);
    }
    if (dic[@"userInfoBase"][@"nickName"]) {//nickName
        [self setFriendDanChatNickName:dic[@"userInfoBase"][@"nickName"]];
        NSLog(@"%@",dic[@"userInfoBase"][@"nickName"]);
    }
    if (dic[@"userInfoBase"][@"userPhotoHead"]) {
        if ([dic[@"userInfoBase"][@"userPhotoHead"] isKindOfClass:[NSNull class]]) {
            [self setFriendDanChatUserPhotoHead:@""];
        }else{
          [self setFriendDanChatUserPhotoHead:dic[@"userInfoBase"][@"userPhotoHead"]];
        }
    }
}
@end
