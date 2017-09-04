//
//  AccountRegistrationVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "AccountRegistrationVC.h"
#import "AppDelegate.h"
#import "PerfectInformationVC.h"
#import "basicTextField.h"
#import "UITextField+Extension.h"
#import "RegistrationAgreementVC.h"

@interface AccountRegistrationVC ()
{
    basicTextField *_textField;
}
@end

@implementation AccountRegistrationVC
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
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/4.7)/2, kScreenHeight/7.5, kScreenWidth/4.7, kScreenWidth/4.7)];
    imageView.image = [UIImage imageNamed:@"Icon-60@3x副本Y.png"];
    UILabel *DuanLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/4.7)/2+(kScreenWidth/4.7-80)/2, CGRectGetMaxY(imageView.frame)+10, 80, 20)];
    DuanLabel.text = @"(机构端)";
    DuanLabel.textAlignment = NSTextAlignmentCenter;
    DuanLabel.font = [UIFont boldSystemFontOfSize:18];
    DuanLabel.textColor = kAppWhiteColor;
    NSArray *arr = @[@"请输入您的手机号",@"请输入验证码",@"请输入您的密码"];
    NSArray *PicArr = @[@"图层-47@2x_46.png",@"验证码@2x_73",@"图层-46@2x.png"];
    for (int i=0; i<3; i++) {
        _textField       = [[basicTextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(DuanLabel.frame)+20+i*60, kScreenWidth - 40, 40)];
        [_textField leftViewRectForBounds:CGRectMake(-20, 0, 25, 25)];
        _textField.backgroundColor    = kAppWhiteColor;
        _textField.tag = 100+i;
        [_textField setBorderStyle:UITextBorderStyleRoundedRect];
        _textField.layer.borderWidth  = 0.1;
        _textField.layer.cornerRadius = 20;
        _textField.enabled            = true;
        _textField.ex_heightToKeyboard = 0;
        _textField.ex_moveView = self.view;
        _textField.placeholder        = arr[i];
        if (_textField.tag == 101) {
            self.authCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_textField.frame)-100, 0, 100, 40)];
            [self.authCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            self.authCodeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            self.authCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.authCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            self.authCodeBtn.backgroundColor = kAppGrayColor;
            self.authCodeBtn.layer.cornerRadius = 17;
            self.authCodeBtn.layer.masksToBounds = YES;
            [self.authCodeBtn addTarget:self action:@selector(openCountdown) forControlEvents:UIControlEventTouchUpInside];
//            imageV.userInteractionEnabled = YES;
//            [imageV addGestureRecognizer:Tap];
            _textField.rightView      = self.authCodeBtn;
            _textField.rightViewMode  = UITextFieldViewModeAlways;
        }
        _textField.layer.borderColor  = kAppWhiteColor.CGColor;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        UIImageView *PIc = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        PIc.image = [UIImage imageNamed:PicArr[i]];
        _textField.leftView           = PIc;
        _textField.leftViewMode       = UITextFieldViewModeAlways;
        
        [self.view addSubview:_textField];
    }
    UIButton *LoginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    LoginBtn.backgroundColor    = kAppBlueColor;
    LoginBtn.layer.borderWidth  = 0.1;
    LoginBtn.layer.cornerRadius = 20;
    LoginBtn.frame = CGRectMake(20, kScreenHeight/2+90, kScreenWidth-40, 40);
    [LoginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [LoginBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    [LoginBtn addTarget:self action:@selector(LoginBtn:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *ShengMLabel  = [[UIButton alloc]initWithFrame:CGRectMake(10, kScreenHeight-40, kScreenWidth-20, 20)];
    [ShengMLabel setTitle:@"点击“注册”即表示同意上课呗《用户协议及声明》" forState:UIControlStateNormal];
    [ShengMLabel setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    ShengMLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    ShengMLabel.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    ShengMLabel.backgroundColor = kAppBlackColor;
    [ShengMLabel addTarget:self action:@selector(SmCLick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:imageView];
    [self.view addSubview:DuanLabel];
    [self.view addSubview:BackButton];
    [self.view addSubview:LoginBtn];
    [self.view addSubview:ShengMLabel];
}

-(void)SmCLick:(UIButton *)tap
{
    NSLog(@"进入注册协议");
    RegistrationAgreementVC *agreement = [[RegistrationAgreementVC alloc]init];
    [self.navigationController pushViewController:agreement animated:YES];
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
    UITextField *textField         = [self.view viewWithTag:100];
    UITextField *textFieldYanZheng = [self.view viewWithTag:101];
    UITextField *textFieldPassWord = [self.view viewWithTag:102];
     NSUserDefaults *defaults   = [NSUserDefaults standardUserDefaults];
    NSString *mobileRegex = @"[1][34578][0-9]{9}";
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    if (textField.text.length != 0 || textFieldYanZheng.text.length != 0 || textFieldPassWord.text.length != 0) {
        if (textFieldPassWord.text.length > 5) {
            if ([mobilePredicate evaluateWithObject:textField.text]) {
                __weak typeof(self) weakSelf = self;
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userName":textField.text,@"password":textFieldPassWord.text,@"phone":textField.text,@"validCode":textFieldYanZheng.text} url:UrL_ChuangJian success:^(id responseObject) {
//                    NSLog(@"注册是否成功%@",responseObject);
                    if ([[responseObject objectForKey:@"errcode"]integerValue] != 0) {
                        [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"msg"]];
                    }else{
//                        if ([[responseObject objectForKey:@"msg"]isEqualToString:@"重复的用户名注册"]) {
//                            [SVProgressHUD showErrorWithStatus:@"该用户已注册"];
//                        }else{
//                            NSLog(@"%@",responseObject);
                            [defaults setObject:textField.text forKey:@"UserPhone"];
                            [defaults synchronize];
                            NSDictionary *RootDic = [responseObject objectForKey:@"data"];
                            NSString *STR = [RootDic objectForKey:@"id"];
                            [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                            PerfectInformationVC *info = [[PerfectInformationVC alloc]init];
                            info.UserInfoId = STR;
                            [weakSelf.navigationController pushViewController:info animated:YES];
//                        }
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

- (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//-(void)TapResist:(UITapGestureRecognizer *)Tap
//{
//}

-(void)klick:(UIButton *)ck
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
