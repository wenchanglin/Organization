//
//  TeacherDetailsModel.h
//  ShangKOrganization
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherDetailsModel : NSObject
@property (nonatomic,copy)NSString *TeacherDetailsPicPhoto;
@property(nonatomic,copy) NSString *TeacherDetailsName;
@property(nonatomic,copy) NSString *TeacherDetailsId;
@property(nonatomic,copy) NSString *TeacherDetailsPrice;
@property(nonatomic,assign) NSInteger TeacherDetailsSubmitCount;
@property(nonatomic,assign) NSInteger TeacherDetailsBuyCount;
@property(nonatomic,copy) NSString *TeacherDetailsCreateTime;

-(void)setDic:(NSDictionary *)dic;
-(void)setdic:(NSDictionary *)DICT;
@end
