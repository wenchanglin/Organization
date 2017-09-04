//
//  TeacherDetailsVC.h
//  ShangKOrganization
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherDetailsVC : UIViewController
@property(nonatomic,copy)   NSString  *TeacherDeName;
@property(nonatomic,copy)   NSString  *TeacherDePhoto;
@property(nonatomic,copy)   NSString  *TeacherDeId;
@property(nonatomic,assign) NSInteger TeacherDeSex;
@property(nonatomic,assign) NSInteger TeacherDeObjeceNum;
@property (nonatomic,strong)NSDictionary *TeacherDeDict;
@end
