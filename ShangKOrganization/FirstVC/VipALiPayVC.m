//
//  VipALiPayVC.m
//  ShangKOrganization
//
//  Created by apple on 16/11/24.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "VipALiPayVC.h"
#import "FourVC.h"
#import "VideoClassVC.h"
#import "OrganizationActivityVC.h"
#import "VideoVipVC.h"
#import "MyOrderVC.h"
@implementation VipALiPayVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self createNAv];
    self.view.backgroundColor = kAppBlackColor;
}

-(void)createUI
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    NSString *html = [NSString stringWithFormat:@"<html><body>%@</body></html>",self.AliMSG];
    [webView loadHTMLString:html baseURL:nil];
    [self.view addSubview:webView];
}

-(void)createNAv
{
    UIView *BarView = [[UIView alloc]initWithFrame:CGRectMake(20, kScreenHeight-250, 60, 60)];
    BarView.backgroundColor = kAppWhiteColor;
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame = CGRectMake(10, 10, 40, 40);
    [Btn setBackgroundImage:[UIImage imageNamed:@"关闭-拷贝@2x.png"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(Close:) forControlEvents:UIControlEventTouchUpInside];
    [BarView addSubview:Btn];
    [self.view addSubview:BarView];
}

-(void)Close:(UIButton *)BaBtn
{
    if ([self.ChooseTitle isEqualToString:@"AddObject"]) {
        FourVC *rog = [[FourVC alloc]init];
        [self.navigationController pushViewController:rog animated:YES];
    }else if([self.ChooseTitle isEqualToString:@"AddActivity"]){
        OrganizationActivityVC *acvity = [[OrganizationActivityVC alloc]init];
        acvity.navigationController.navigationBar.hidden = NO;
        acvity.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:acvity animated:YES];
    }else if ([self.ChooseTitle isEqualToString:@"BuyVideo"]){
        VideoClassVC *video = [[VideoClassVC alloc]init];
         video.PayTit = @"Alerady";
        [self.navigationController pushViewController:video animated:YES];
    }else if ([self.ChooseTitle isEqualToString:@"VipGet"]){
        VideoVipVC *vip = [[VideoVipVC alloc]init];
        [self.navigationController pushViewController:vip animated:YES];
    }else if ([self.ChooseTitle isEqualToString:@"SpBuy"]){
        MyOrderVC *vip = [[MyOrderVC alloc]init];
        vip.PayTit = @"AlL";
        [self.navigationController pushViewController:vip animated:YES];
    }

    
}
@end
