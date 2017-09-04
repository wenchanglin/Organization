//
//  LoginVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"
#import "RetrievePasswordVC.h"
#import "AccountRegistrationVC.h"
#import "basicTextField.h"
#import "UITextField+Extension.h"
#import "RootVC.h"
#import "FbwManager.h"
#import <RongIMKit/RongIMKit.h>
#import "JPUSHService.h"
@interface LoginVC ()<RCIMUserInfoDataSource>
{
    basicTextField *_textField;
    NSString *_token;
}
@end

@implementation LoginVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    [self createView];
    self.view.backgroundColor = kAppBlackColor;
}

-(void)createView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/4.7)/2, kScreenHeight/7.5, kScreenWidth/4.7, kScreenWidth/4.7)];
    imageView.image = [UIImage imageNamed:@"Icon-60@3x副本Y.png"];
    UILabel *DuanLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/4.7)/2+(kScreenWidth/4.7-80)/2, CGRectGetMaxY(imageView.frame)+10, 80, 20)];
    DuanLabel.text = @"(机构端)";
    DuanLabel.textAlignment = NSTextAlignmentCenter;
    DuanLabel.font = [UIFont boldSystemFontOfSize:18];
    DuanLabel.textColor = kAppWhiteColor;
    NSArray *arr = @[@"请输入您的账号",@"请输入您的密码"];
    NSArray *PicArr = @[@"图层-47@2x_46.png",@"图层-46@2x.png"];
    for (int i=0; i<2; i++) {
        _textField                    = [[basicTextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(DuanLabel.frame)+20+i*60, kScreenWidth - 40, 40)];
        [_textField leftViewRectForBounds:CGRectMake(-20, 0, 20, 25)];
        _textField.backgroundColor    = kAppWhiteColor;
        [_textField setBorderStyle:UITextBorderStyleRoundedRect];
        _textField.layer.borderWidth  = 0.1;
        _textField.layer.cornerRadius = 20;
        _textField.tag                = 10+i;
        if (_textField.tag == 11) {
            _textField.secureTextEntry = YES;
        }
        _textField.enabled            = true;
        _textField.ex_heightToKeyboard = 0;
        _textField.ex_moveView = self.view;
        _textField.placeholder        = arr[i];
        _textField.layer.borderColor  = kAppWhiteColor.CGColor;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        UIImageView *PIc = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 25)];
        PIc.image = [UIImage imageNamed:PicArr[i]];
        _textField.leftView           = PIc;
        _textField.leftViewMode       = UITextFieldViewModeAlways;
        
        [self.view addSubview:_textField];
    }
    NSArray *TitAr = @[@"找回密码",@"免费注册"];
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20+(kScreenWidth-120)*i, CGRectGetMaxY(DuanLabel.frame)+130, 80, 20);
        button.tag = 10+i;
        button.backgroundColor = kAppClearColor;
        [button setTitle:TitAr[i] forState:UIControlStateNormal];
        [button setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(PersonIn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }
    UIButton *LoginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    LoginBtn.backgroundColor    = kAppBlueColor;
    LoginBtn.layer.borderWidth  = 0.1;
    LoginBtn.layer.cornerRadius = 20;
    LoginBtn.frame = CGRectMake(20, kScreenHeight/2+60, kScreenWidth-40, 40);
    [LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [LoginBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    [LoginBtn addTarget:self action:@selector(LoginBtG:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:imageView];
    [self.view addSubview:DuanLabel];
    [self.view addSubview:LoginBtn];
}

-(void)LoginBtG:(UIButton *)login
{
    UITextField *UserNameTextField     = [self.view viewWithTag:10];
    UITextField *UserPassWordTextField = [self.view viewWithTag:11];
    FbwManager *Manager =[FbwManager shareManager];
    NSLog(@"你妹%@",Manager.FirstIsLogin);
    NSLog(@"登录");
    __weak typeof(self) weakSelf = self;
    if (UserNameTextField.text.length  != 0) {
        if (UserPassWordTextField.text.length != 0) {
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userName":UserNameTextField.text,@"roleType":@"organization",@"password":UserPassWordTextField.text} url:UrL_Login success:^(id responseObject) {
                NSLog(@"我真的笑呵呵%@",responseObject);
                 NSLog(@"你真的好爽%@",[responseObject objectForKey:@"msg"]);
                if ([[responseObject objectForKey:@"msg"]isEqualToString:@"验证失败"]||[[responseObject objectForKey:@"msg"]isEqualToString:@"用户不存在"]||[[responseObject objectForKey:@"msg"]isEqualToString:@"您的账号异常，请联系客服人员"] || [[responseObject objectForKey:@"msg"]isEqualToString:@"您的账号正在审核"]||[[responseObject objectForKey:@"msg"]isEqualToString:@"您的账号已停用"]) {
                    [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"msg"]];
                }else{
//                    [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                    NSDictionary *RootDic = [responseObject objectForKey:@"data"];
                    RootVC *firsr = [[RootVC alloc]init];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    if ([Manager.FirstIsLogin isEqualToString:@"NO"]) {
                        if ([UserNameTextField.text isEqualToString:[defaults objectForKey:@"nickName"]]) {
                            [defaults setObject:@"YES"  forKey:@"isLogin"];
                            [defaults setObject:[RootDic objectForKey:@"id"] forKey:@"UserId"];
                            [defaults setObject:[RootDic objectForKey:@"nickName"] forKey:@"UserName"];
                            [defaults setObject:[RootDic objectForKey:@"username"] forKey:@"UinfoUser"];
                            [defaults synchronize];
                        }else{
                            [NSUserDefaults standardUserDefaults];
                            [defaults setObject:@"YES"  forKey:@"isLogin"];
                            [defaults setObject:[RootDic objectForKey:@"id"] forKey:@"UserId"];
                            if ([[RootDic objectForKey:@"nickName"] isKindOfClass:[NSNull class]]) {
                                [defaults setObject:@"" forKey:@"UserName"];
                            }else{
                                [defaults setObject:[RootDic objectForKey:@"nickName"] forKey:@"UserName"];
                            }
                            [defaults setObject:[RootDic objectForKey:@"username"] forKey:@"UinfoUser"];
                            [defaults synchronize];
                        }
                    }else{
                    [NSUserDefaults standardUserDefaults];
                    [defaults setObject:@"YES"  forKey:@"isLogin"];
                    [defaults setObject:[RootDic objectForKey:@"id"] forKey:@"UserId"];
                        if ([[RootDic objectForKey:@"nickName"] isKindOfClass:[NSNull class]]) {
                            [defaults setObject:@"" forKey:@"UserName"];
                        }else{
                            [defaults setObject:[RootDic objectForKey:@"nickName"] forKey:@"UserName"];
                        }
                    [defaults setObject:[RootDic objectForKey:@"username"] forKey:@"UinfoUser"];
                    [defaults synchronize];
                    }
                    if ([defaults objectForKey:@"UserId"] == nil || [[defaults objectForKey:@"UserId"] isKindOfClass:[NSNull class]]) {
                        [SVProgressHUD showErrorWithStatus:@"输入有误"];
                    }else{
                        Manager.UUserId = [defaults objectForKey:@"UserId"];
                        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":[defaults objectForKey:@"UserId"]} url:UrL_MyOrgDetails success:^(id responseObject) {
                            NSDictionary *rootD = [responseObject objectForKey:@"data"];
//                            NSLog(@"吉吉%@",responseObject);
//                            Manager.MyRecommendCode = rootD[@"userBase"][@"recommendCode"];
                            if ([rootD[@"userBase"][@"nickName"] isKindOfClass:[NSNull class]]) {
                                [defaults setObject:@"暂无公司名" forKey:@"CompanyName"];
                            }else{
                                
                                [defaults setObject:rootD[@"userBase"][@"nickName"] forKey:@"CompanyName"];
                            }
                            if ([[rootD objectForKey:@"businessLicense"] isKindOfClass:[NSNull class]]) {
                                [defaults setObject:@"" forKey:@"userInfoYingYe"];
                            }else{
                                [defaults setObject:[rootD objectForKey:@"businessLicense"] forKey:@"userInfoYingYe"];
                            }
                            if ([[rootD objectForKey:@"legalPersonIDCardOpposite"] isKindOfClass:[NSNull class]]) {
                                [defaults setObject:@"" forKey:@"SFZTheOtherSide"];
                            }else{
                                [defaults setObject:[rootD objectForKey:@"legalPersonIDCardOpposite"] forKey:@"SFZTheOtherSide"];
                            }
                            if ([[rootD objectForKey:@"legalPersonIDCardPositive"] isKindOfClass:[NSNull class]]) {
                                [defaults setObject:@"" forKey:@"PersonIDCardPositive"];
                            }else{
                                [defaults setObject:[rootD objectForKey:@"legalPersonIDCardPositive"] forKey:@"PersonIDCardPositive"];
                            }
                            if ([[rootD objectForKey:@"location"] isKindOfClass:[NSNull class]]) {
                                [defaults setObject:@"暂无地址" forKey:@"CompanyAddress"];
                            }else{
                                [defaults setObject:[rootD objectForKey:@"location"] forKey:@"CompanyAddress"];
                            }
//                            [defaults setObject:[rootD objectForKey:@"location"] forKey:@"CompanyAddress"];
                            if ([[rootD objectForKey:@"legalPersonName"] isKindOfClass:[NSNull class]]) {
                                [defaults setObject:@"暂无法人" forKey:@"CompanyPeople"];
                            }else{
                                [defaults setObject:[rootD objectForKey:@"legalPersonName"] forKey:@"CompanyPeople"];
                            }
                            [defaults setObject:rootD[@"userBase"][@"phone"] forKey:@"ManagerPhone"];
                            //                    NSLog(@"-=%@",[rootD objectForKey:@"location"]);
                            //                    NSLog(@"-==%@",rootD[@"userBase"][@"nickName"]);
                            [defaults synchronize];
                            [weakSelf getRongyunToken];
                        } failure:^(NSError *error) {
                        }];
                    }
                    
                    [UIView animateWithDuration:0.1 animations:^{
                        weakSelf.view.alpha = 0;
                    } completion:^(BOOL finished) {
                        [weakSelf getRongyunToken];
                        [JPUSHService setTags:nil alias:Manager.UUserId callbackSelector:nil object:nil];
                        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                        delegate.window.rootViewController = firsr;
                    }];
                }
            } failure:^(NSError *error) {
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入您的密码"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入您的账号"];
    }
}

#pragma mark - 获取融云token
//获取融云token
- (void)getRongyunToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@..%@.",[defaults objectForKey:@"UserId"],[defaults objectForKey:@"UserName"]);
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":[defaults objectForKey:@"UserId"],@"name":[defaults objectForKey:@"UserName"],@"portraitUri":@""} url:UrL_GetRongYunToken success:^(id responseObject) {
//        NSLog(@"网址%@",UrL_GetRongYunToken);
//         [[RCIM sharedRCIM] initWithAppKey:@"3argexb6re2le"];
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        _token = RootDic[@"token"];//获取返回的token
        NSLog(@"token%@",_token);
        [[RCIM sharedRCIM] initWithAppKey:@"ik1qhw091hubp"];
//        NSString *token = responseObject[@"data"][@"token"];
        [[RCIM sharedRCIM] connectWithToken:_token success:^(NSString *userId) {
            [[RCIM sharedRCIM] setUserInfoDataSource:self];
            NSLog(@"Login successfully with userId: %@.", userId);
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
            [SVProgressHUD showErrorWithStatus:@"融云连接失败，请重新打开App"];
        } tokenIncorrect:^{
            NSLog(@"token错误");
        }];    } failure:^(NSError *error) {
        }];
//        //初始化融云
//        [[RCIM sharedRCIM] initWithAppKey:@"3argexb6re2le"];
////        [[RCIMClient sharedRCIMClient]initWithAppKey:@"3argexb6re2le"];//mgb7ka1nbmxug
//        [[RCIM sharedRCIM] connectWithToken:_token success:^(NSString *userId) {
//            //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
//            [[RCIM sharedRCIM] setUserInfoDataSource:self];
//            NSLog(@"Login successfully with userId: %@.", userId);
//            
//        } error:^(RCConnectErrorCode status) {
//            NSLog(@"login error status: %ld.", (long)status);
//        } tokenIncorrect:^{
//            NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
//        }];
//    } failure:^(NSError *error) {
//    }];
}

/**
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
//- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    //此处为了演示写了一个用户信息
//    if ([@"db86c469-21a7-4039-916f-22447b985bd8" isEqual:userId]) {
//        RCUserInfo *user = [[RCUserInfo alloc]init];
//        user.userId = @"db86c469-21a7-4039-916f-22447b985bd8";//[defaults objectForKey:@"UserId"];
//        user.name = [defaults objectForKey:@"UserName"];
//        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
//        
//        return completion(user);
//    }else if([@"2" isEqual:userId]) {
//        RCUserInfo *user = [[RCUserInfo alloc]init];
//        user.userId = @"2";
//        user.name = @"测试2";
//        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
//        return completion(user);
//    }
//}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)PersonIn:(UIButton *)PBtn
{
    if (PBtn.tag == 10) {
        RetrievePasswordVC *pass = [[RetrievePasswordVC alloc]init];
        NSLog(@"找回密码");
        
        [self.navigationController pushViewController:pass animated:YES];
    }else{
        AccountRegistrationVC *regist = [[AccountRegistrationVC alloc]init];
        NSLog(@"免费注册");
        [self.navigationController pushViewController:regist animated:YES];
    }
}

@end
