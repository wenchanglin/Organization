//
//  ManagerUserInfoVC.h
//  ShangKOrganization
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagerUserInfoVC : UIViewController
@property(nonatomic,copy) NSString *UserNickName;
@property(nonatomic,copy) NSString *UserInfoIntro;
@property(nonatomic,assign) NSInteger UserSex;
@property(nonatomic,assign) NSInteger UserAge;
@property(nonatomic,copy) NSString *UserPhone;
@end
