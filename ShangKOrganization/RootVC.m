//
//  RootVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/9.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "RootVC.h"
#import "AppDelegate.h"
#define VCS @[@"FirstVC",@"SecondVC",@"ThirdVC",@"FourVC",@"FiveVC"]
#define Titles @[@"首页",@"交流圈",@"商城",@"课程管理",@"机构中心"]
#define Image1 @[@"图层-20@2x.png",@"bae-群组@2x_97.png",@"商城-(4)@2x.png",@"课程管理满@2x.png",@"图层-23@2x.png"]
#define Image2 @[@"图层-20@2x_99.png",@"bae-群组@2x.png",@"商城-(4)@2x_19.png",@"课程管理满@2x_8.png",@"图层-23@2x_32.png"]

#define Width [UIScreen mainScreen].bounds.size.width

@interface RootVC ()
{
    UIView *TabBarView;
}
@end
@implementation RootVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBar.hidden = YES;
}

-(void)createTabBarController
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i < VCS.count; i++) {
        UIViewController *vc = [[NSClassFromString(VCS[i]) alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [arr addObject:nav];
    }
    self.viewControllers = arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabBarController];
    [self createTabBar];
}

-(void)createTabBar
{
    TabBarView = [[UIView alloc]initWithFrame:self.tabBar.frame];
    TabBarView.backgroundColor = kAppWhiteColor;
    TabBarView.tintColor = kAppWhiteColor;

    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView = TabBarView;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, 2)];
    imageView.image = [UIImage imageNamed:@"78@2x.png"];
    [TabBarView addSubview:imageView];
    
    CGFloat xSpace = (Width - 50 * 5)/6;
    for (int i = 0; i < VCS.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(xSpace + (i % 5)*(xSpace + 50), 2, 50,35);
        [button setImage:[UIImage imageNamed:Image1[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:Image2[i]] forState:UIControlStateSelected];
        button.tag = 100+i;
        
        if (button.tag == 100) {
            button.selected   = YES;
            self.selectButton = button;
        }
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [TabBarView addSubview:button];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(xSpace + (i % 5)*(xSpace + 50) - 5 , 37, 60, 11)];
        label.text     = Titles[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag      = 200+i;
        if (label.tag  == 200) {
            label.textColor  = kAppBlueColor;
            self.selectLabel = label;
        }
        label.font     = [UIFont systemFontOfSize:11];
        [TabBarView addSubview:label];
    }
    [self.view addSubview:TabBarView];
}

-(void)btnClick:(UIButton *)btn
{
    self.selectButton.selected = NO;
    btn.selected = YES;
    self.selectButton = btn;
    self.selectedIndex = btn.tag - 100;
    
    self.selectLabel.textColor = kAppBlackColor;
    self.selectLabel = (UILabel *)[TabBarView viewWithTag:btn.tag+100];
    self.selectLabel.textColor = kAppBlueColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
