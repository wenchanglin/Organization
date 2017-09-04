//
//  AddStudentModel.h
//  ShangKOrganization
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddStudentModel : NSObject
@property(nonatomic,copy) NSString *AddStudentPic;
@property(nonatomic,copy) NSString *AddStudentName;
@property(nonatomic,copy) NSString *AddStudentId;

-(void)setDic:(NSDictionary *)Dic;
@end
