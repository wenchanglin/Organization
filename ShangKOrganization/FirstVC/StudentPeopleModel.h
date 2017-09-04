//
//  StudentPeopleModel.h
//  ShangKOrganization
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentPeopleModel : NSObject
@property(nonatomic,copy) NSString *StudentPeopleName;
@property(nonatomic,copy) NSString *StudentPeoplePhone;
@property(nonatomic,copy) NSString *StudentPeopleCreateTime;
@property(nonatomic,copy) NSString *StudentPeopleId;
@property(nonatomic,copy) NSString *StudentPeopleUserPhotoHead;

-(void)setDic:(NSDictionary *)dic;
-(void)SetLuRuStudent:(NSDictionary *)Dic;
@end
