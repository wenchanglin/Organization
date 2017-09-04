//
//  RetrievePasswordVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "RetrievePasswordVC.h"
#import "AppDelegate.h"
#import "basicTextField.h"
@interface RetrievePasswordVC ()
@end

@implementation RetrievePasswordVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    self.view.backgroundColor = kAppBlackColor;
}

-(void)createNav
{
    UIButton *BackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    BackButton.frame = CGRectMake(20, 20, 30, 30);
    BackButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [BackButton setImage:[UIImage imageNamed:@"图层-45@2x.png"] forState:UIControlStateNormal];
    [BackButton addTarget:self action:@selector(klick:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/3-20)/2, CGRectGetMaxY(BackButton.frame)+20, kScreenWidth/3+20, 40)];
    label.text = @"找回密码";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:30];
    label.textColor = kAppWhiteColor;
    NSArray *arr = @[@"请输入您的手机号",@"请输入验证码",@"请输入新密码"];
    NSArray *PicArr = @[@"图层-47@2x_46.png",@"验证码@2x_73",@"图层-46@2x.png"];
    for (int i=0; i<3; i++) {
        basicTextField *textField       = [[basicTextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(BackButton.frame)+80+i*60, kScreenWidth - 40, 40)];
        [textField leftViewRectForBounds:CGRectMake(-20, 0, 20, 25)];
        textField.backgroundColor    = kAppWhiteColor;
        textField.tag = 100+i;
        [textField setBorderStyle:UITextBorderStyleRoundedRect];
        textField.layer.borderWidth  = 0.1;
        textField.layer.cornerRadius = 20;
        textField.enabled            = true;
        textField.placeholder        = arr[i];
        if (textField.tag == 101) {
            self.authCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(textField.frame)-90, 0, 90, 40)];
            [self.authCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            self.authCodeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            self.authCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.authCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            self.authCodeBtn.backgroundColor = kAppGrayColor;
            self.authCodeBtn.layer.cornerRadius = 17;
            self.authCodeBtn.layer.masksToBounds = YES;
            [self.authCodeBtn addTarget:self action:@selector(openCountdown) forControlEvents:UIControlEventTouchUpInside];
            textField.rightView      = self.authCodeBtn;
            textField.rightViewMode  = UITextFieldViewModeAlways;
        }
        textField.layer.borderColor  = kAppWhiteColor.CGColor;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        UIImageView *PIc = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 25)];
        PIc.image = [UIImage imageNamed:PicArr[i]];
        textField.leftView           = PIc;
        textField.leftViewMode       = UITextFieldViewModeAlways;
        
        [self.view addSubview:textField];
    }
    UIButton *LoginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    LoginBtn.backgroundColor    = kAppBlueColor;
    LoginBtn.layer.borderWidth  = 0.1;
    LoginBtn.layer.cornerRadius = 20;
    LoginBtn.frame = CGRectMake(20, kScreenHeight/2+60, kScreenWidth-40, 40);
    [LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [LoginBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    [LoginBtn addTarget:self action:@selector(LoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:BackButton];
    [self.view addSubview:label];
    [self.view addSubview:LoginBtn];
}

// 开启倒计时效果
-(void)openCountdown{
    NSLog(@"吓死宝宝了");
    __block NSInteger time = 59; //倒计时时间
    UITextField *textField         = [self.view viewWithTag:100];
    if (textField.text.length != 0) {
        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"phone":textField.text} url:UrL_SendYanZhengMa success:^(id responseObject) {
            if ([[responseObject objectForKey:@"msg"]isEqualToString:@"1分钟内不能重复发送"]) {
                [SVProgressHUD showErrorWithStatus:@"1分钟内不能重复发送"];
            }
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(time <= 0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置按钮的样式
                        [self.authCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                        [self.authCodeBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
                        self.authCodeBtn.userInteractionEnabled = YES;
                    });
                }else{
                    int seconds = time % 60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //设置按钮显示读秒效果
                        [self.authCodeBtn setTitle:[NSString stringWithFormat:@"(%.2d)S", seconds] forState:UIControlStateNormal];
                        [self.authCodeBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
                        self.authCodeBtn.userInteractionEnabled = NO;
                    });
                    time--;
                }
            });
            dispatch_resume(_timer);
        } failure:^(NSError *error) {
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
    }
}

-(void)LoginBtn:(UIButton *)loginBtn
{
    NSLog(@"登录");
    UITextField *PhoneTextField       = [self.view viewWithTag:100];
    UITextField *ValidCodeTextField   = [self.view viewWithTag:101];
    UITextField *NewPasswordTextField = [self.view viewWithTag:102];
    NSLog(@"电话%@",PhoneTextField.text);
    NSLog(@"验证码%@",ValidCodeTextField.text);
    NSLog(@"新密码%@",NewPasswordTextField.text);
    NSString *mobileRegex = @"[1][34578][0-9]{9}";
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    if (PhoneTextField.text.length != 0 || ValidCodeTextField.text.length != 0 || NewPasswordTextField.text.length != 0) {
        if (NewPasswordTextField.text.length > 5) {
            if ([mobilePredicate evaluateWithObject:PhoneTextField.text]) {
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"phone":PhoneTextField.text,@"validCode":ValidCodeTextField.text,@"password":NewPasswordTextField.text,@"roleType":@"organization"} url:UrL_NewPhonePassWord success:^(id responseObject) {
                    if ([[responseObject objectForKey:@"msg"]isEqualToString:@"验证码不正确"]||[[responseObject objectForKey:@"msg"]isEqualToString:@"无效验证码"]) {
                        [SVProgressHUD showErrorWithStatus:@"验证码不正确"];
                    }else{
                        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                } failure:^(NSError *error) {
                }];
            }else{
                [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入六位以上密码"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请检查是否有漏输入的选项"];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//-(void)Tap:(UITapGestureRecognizer *)Tap
//{
//    NSLog(@"获取验证码");
//    UITextField *PhoneTectField = [self.view viewWithTag:100];
//    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"phone":PhoneTectField.text} url:UrL_SendYanZhengMa success:^(id responseObject) {
//        NSDictionary *rootDic = responseObject;
//        NSLog(@"%@",rootDic);
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
//    } failure:^(NSError *error) {
//    }];
//
//}

-(void)klick:(UIButton *)ck
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

