//
//  SuccessErWeiMVC.m
//  ShangKOrganization
//
//  Created by apple on 16/11/16.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SuccessErWeiMVC.h"

@implementation SuccessErWeiMVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self createUI];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createUI
{
    UIView *LayerView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-100)/2, (kScreenHeight-120)/2, 100, 120)];
    LayerView.backgroundColor = kAppWhiteColor;
    UIImageView *imager = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 90, 90)];
    imager.image = [UIImage imageNamed:@"验证@2x.png"];
    UILabel *LAbel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(imager.frame)+5, 90, 20)];
    LAbel.text = @"验证成功!";
    LAbel.textAlignment = NSTextAlignmentCenter;
    LAbel.font = [UIFont boldSystemFontOfSize:17];
    
    [LayerView addSubview:LAbel];
    [LayerView addSubview:imager];
    [self.view addSubview:LayerView];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 90)/2, 10, 90, 30)];
    label.text = @"验证成功";
    label.textAlignment = NSTextAlignmentCenter;
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
