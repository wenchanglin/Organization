//
//  TeacherManagerModel.h
//  ShangKOrganization
//
//  Created by apple on 16/10/17.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherManagerModel : NSObject
@property(nonatomic,copy)   NSString *TeacherManagerNickName;
@property(nonatomic,copy)   NSString *TeacherManagerId;
@property(nonatomic,copy)   NSString *TeacherManagerUserPhotoHead;
@property(nonatomic,assign) NSInteger TeacherManagerCourseCount;
@property(nonatomic,assign) NSInteger TeacherManagerSex;
@property (nonatomic,strong)NSDictionary *TeacherManagerDict;
-(void)setDic:(NSDictionary *)dic;
@end
