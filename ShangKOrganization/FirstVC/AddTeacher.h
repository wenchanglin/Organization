//
//  AddTeacher.h
//  ShangKOrganization
//
//  Created by apple on 16/9/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTeacher : UIViewController
@property(nonatomic,copy) NSString *NAvTit;
@property (nonatomic,strong)NSDictionary *TeacherInfoDic;
@property(nonatomic,copy)   NSString  *TeacherOverName;
@property(nonatomic,copy)   NSString  *TeacherOverId;
@property(nonatomic,copy)   NSString  *PhotoHead;
@property(nonatomic,copy)   NSData    *PhotoHeadData;
@end
