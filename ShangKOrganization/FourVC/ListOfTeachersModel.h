//
//  ListOfTeachersModel.h
//  ShangKOrganization
//
//  Created by apple on 16/10/17.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListOfTeachersModel : NSObject
@property(nonatomic,copy) NSString *ListOfTeacherNickName;
@property(nonatomic,copy) NSString *ListOfTeacherUserPhotoHead;
@property(nonatomic,copy) NSString *ListOfTeacherId;
@property(nonatomic,copy) NSString *ListOfTeacherAge;
-(void)setDic:(NSDictionary *)dic;
@end
