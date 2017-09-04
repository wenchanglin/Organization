//
//  LuRuStudentModel.h
//  ShangKOrganization
//
//  Created by apple on 16/12/16.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LuRuStudentModel : NSObject
@property(nonatomic,copy) NSString *LuRuStudentName;
@property(nonatomic,copy) NSString *LuRuStudentPhone;
@property(nonatomic,copy) NSString *LuRuStudentCreateTime;
@property(nonatomic,copy) NSString *LuRuStudentId;
@property(nonatomic,copy) NSString *LuRuStudentUserPhotoHead;

-(void)setDic:(NSDictionary *)dic;
@end
