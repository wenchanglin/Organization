//
//  SecondModel.h
//  ShangKOrganization
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondModel : NSObject
@property(nonatomic,copy) NSString *SecondChatGroupPhotoUrl;
@property(nonatomic,copy) NSString *SecondName;
@property(nonatomic,copy) NSString *SecondCreateTime;
@property(nonatomic,copy) NSString *SecondCreateUserId;
@property(nonatomic,copy) NSString *SecondId;
@property(nonatomic,copy) NSString *SecondIntro;

-(void)setDic:(NSDictionary *)dic;
@end
