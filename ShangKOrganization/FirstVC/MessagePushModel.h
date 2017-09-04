//
//  MessagePushModel.h
//  ShangKOrganization
//
//  Created by apple on 16/11/3.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessagePushModel : NSObject
@property(nonatomic,copy) NSString *PushMessageTitle;
@property(nonatomic,copy) NSString *PushMessageCreateTime;
@property(nonatomic,copy) NSString *PushMessageId;
@property(nonatomic,copy) NSString *PushMessageFkOrgNotice;

-(void)setDic:(NSDictionary *)dic;
@end
