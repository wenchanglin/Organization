//
//  BusinessLicense.m
//  ShangKOrganization
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "BusinessLicense.h"

@implementation BusinessLicense

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self createUI];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createUI
{
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UIButton *ServiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ServiceBtn.frame = CGRectMake(20, 80, kScreenWidth-40, kScreenHeight/3);
    if ([[defaults objectForKey:@"userInfoYingYe"] isEqual:@""]) {
        [ServiceBtn setBackgroundImage:[UIImage imageNamed:@"没有消息@2x.png"] forState:UIControlStateNormal];
    }else{
    [ServiceBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,[defaults objectForKey:@"userInfoYingYe"]]] placeholderImage:nil];
    }
    ServiceBtn.userInteractionEnabled = NO;
    
    [self.view addSubview:ServiceBtn];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"营业执照";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)BaCklick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
