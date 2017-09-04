//
//  CourseOrdersModel.h
//  ShangKOrganization
//
//  Created by apple on 16/10/17.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseOrdersModel : NSObject
@property(nonatomic,copy) NSString *CourseOrderName;
@property(nonatomic,copy) NSString *CourseOrderContactName;
@property(nonatomic,copy) NSString *CourseOrderContactPhone;
@property(nonatomic,copy) NSString *CourseOrderCreateTime;
@property(nonatomic,copy) NSString *CourseOrderContactPhotoList;
@property(nonatomic,copy) NSString *CourseOrderContactRefundReason;

-(void)setDic:(NSDictionary *)dic;
@end
