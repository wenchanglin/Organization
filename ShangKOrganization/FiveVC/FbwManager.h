//
//  FbwManager.h
//  ShangKOrganization
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FbwManager : NSObject

@property (nonatomic,copy) NSString    *UUserId;
@property (nonatomic,copy) NSString    *AddressTit;
@property (nonatomic,copy) NSString    *CompanyAddress;
@property (nonatomic,copy) NSString    *FixUserInfoName;
@property (nonatomic,copy) NSData      *FixUserInfoPhotoUrl;
@property (nonatomic,assign)NSInteger  JianTYeMian;
@property (nonatomic,assign)NSInteger  FixSex;
@property (nonatomic,assign)float      LocationLongitude;
@property (nonatomic,assign)float      LocationLatitude;
@property (nonatomic,assign)NSInteger  isBuy;
@property (nonatomic,assign)BOOL       isLogin;
@property (nonatomic,copy) NSString    *TeacherId;//管理员
@property (nonatomic,copy) NSString    *UserAddAdminId;//自主创建
@property (nonatomic,copy) NSString    *UserAddAdminName;//自主创建
@property (nonatomic,copy) NSString    *TeacherNAme;
@property (nonatomic,assign)BOOL       isAdmintor;
@property (nonatomic,assign)NSInteger  WanShanXinYeMian;
@property(nonatomic,copy)  NSString    *IsZiJiJianQunId;
@property(nonatomic,copy)  NSString    *IsZiJiJianQunName;
@property(nonatomic,copy)  NSString    *CouldYes;

@property (nonatomic,strong)NSMutableArray *TeacherArray;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *AddActivityModelArray;
@property(nonatomic,copy) NSString      *FirstIsLogin;
@property (nonatomic,assign)NSInteger   IsListPulling;
@property (nonatomic,assign)NSInteger   PullPage;


+(instancetype)shareManager;
@end
