//
//  ViewReasonVC.m
//  ShangKOrganization
//
//  Created by apple on 16/10/17.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ViewReasonVC.h"

@implementation ViewReasonVC
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
    UILabel *FirstLAbel = [[UILabel alloc]initWithFrame:CGRectMake(15, 84, 200, 20)];
    FirstLAbel.text = @"关闭时间";
    FirstLAbel.font = [UIFont boldSystemFontOfSize:15];
    UILabel *TimeLAbel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(FirstLAbel.frame)+10, 200, 20)];
    NSString * timeStampString = self.CloseTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    TimeLAbel.text = [NSString stringWithFormat:@"%@",time];
    TimeLAbel.font = [UIFont systemFontOfSize:17];
    UILabel *CloseLAbel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(TimeLAbel.frame)+20, 200, 20)];
    CloseLAbel.text = @"关闭原因";
    CloseLAbel.font = [UIFont boldSystemFontOfSize:15];
    UILabel *OrderLAbel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(CloseLAbel.frame)+10, 200, 20)];
    OrderLAbel.text = self.RefundReason;
    OrderLAbel.font = [UIFont systemFontOfSize:17];
    
    [self.view addSubview:OrderLAbel];
    [self.view addSubview:CloseLAbel];
    [self.view addSubview:TimeLAbel];
    [self.view addSubview:FirstLAbel];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    NSLog(@"-%@ %@",self.RefundReason,self.CloseTime);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"查看原因";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BFlick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)BFlick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
