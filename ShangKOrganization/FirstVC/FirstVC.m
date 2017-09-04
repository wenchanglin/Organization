//
//  FirstVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/9.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FirstVC.h"
#import "TeacherManager.h"
#import "AppDelegate.h"
#import "OrganizationActivityVC.h"
#import "TeachingAchievement.h"
#import "StudentChatVC.h"
#import "ReportViewVC.h"
#import "DemandHallVC.h"
#import "VideoClassVC.h"
#import "MessagePushVC.h"
#import "CourseOrdersVC.h"
#import "SystemMessageVC.h"
#define TitleS @[@"课程订单",@"教师管理",@"机构活动",@"教学成果",@"学生咨询",@"报表查看",@"需求大厅",@"视频课堂",@"消息推送"]
#define ButtonPic @[@"订单-(2)@2x.png",@"教师管理@2x.png",@"活动-(1)@2x.png",@"学历教育@2x.png",@"咨询-(1)@2x.png",@"查看@2x.png",@"我的订单-(1)@2x.png",@"视频-(4)@2x.png",@"消息推送-01@2x.png"]
@interface FirstVC ()

@end

@implementation FirstVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self createNav];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight/4)];
    imageView.image = [UIImage imageNamed:@"OrgFirstPic.png"];//组-10@2x.png
    
    [self.view addSubview:imageView];
    CGFloat xSpace = (kScreenWidth - 300)/4;
    for (int i = 0; i < 9; i++) {
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame      = CGRectMake(xSpace + (i % 3)*(xSpace + 101), kScreenHeight/4 +(i / 3)*(xSpace + 30) + 70 , 100, kScreenHeight/7.2-20);
        button.tag        = 100+i;
        [button addTarget:self action:@selector(btnClck:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label    = [[UILabel alloc]initWithFrame:CGRectMake(xSpace + (i % 3)*(xSpace + 101) +10, kScreenHeight/4 +(i / 3)*(xSpace + 30) + 70 * 2 + 10, 80, kScreenHeight/7.2-70)];
        label.font        = [UIFont systemFontOfSize:16];
        label.text        = TitleS[i];
        label.textAlignment = NSTextAlignmentCenter;
        if (i > 2 ) {
            button.frame     = CGRectMake(xSpace + (i % 3)*(xSpace +  101), kScreenHeight/4 +(i / 3)*(xSpace + 30) + 70 * 2, 100, kScreenHeight/7.2-20);
            label.frame      = CGRectMake(xSpace + (i % 3)*(xSpace+101)+10 ,kScreenHeight/4 +(i / 3)*(xSpace + 30) + 70 * 3 + 10, 80, kScreenHeight/7.2-70);
            if (i > 5) {
                button.frame = CGRectMake(xSpace + (i % 3)*(xSpace +  101), kScreenHeight/4 +(i / 3)*(xSpace + 30) + 70 * 3, 100, kScreenHeight/7.2-20);
                label.frame  = CGRectMake(xSpace + (i % 3)*(xSpace + 101)+10 ,kScreenHeight/4 +(i / 3)*(xSpace + 30) + 70 * 4 + 10, 80, kScreenHeight/7.2-70);
            }
        }
        [button setImage:[UIImage imageNamed:ButtonPic[i]] forState:UIControlStateNormal];

        [self.view addSubview:label];
        [self.view addSubview:button];
    }
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
        
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 45)/2, 10, 70, 30)];
    label.text = @"机构端";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 30, 30);
    [button2 setImage:[UIImage imageNamed:@"消息@2x.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(btnClck:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 109;
    
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)btnClck:(UIButton *)btn
{
    if (btn.tag == 100) {
        //课程订单
        CourseOrdersVC *course = [[CourseOrdersVC alloc]init];
        [self.navigationController pushViewController:course animated:YES];
        
    }else if (btn.tag == 101){
       //教师管理
        TeacherManager *manager = [[TeacherManager alloc]init];
        [self.navigationController pushViewController:manager animated:YES];
    
    }else if (btn.tag == 102){
        //机构活动
        OrganizationActivityVC *Activity = [[OrganizationActivityVC alloc]init];
        [self.navigationController pushViewController:Activity animated:YES];
        
    }else if (btn.tag == 103){
        //教学成果
        TeachingAchievement *Achieve = [[TeachingAchievement alloc]init];
        [self.navigationController pushViewController:Achieve animated:YES];
        
    }else if (btn.tag == 104){
        //学生咨询VideoClass
        StudentChatVC *chat = [[StudentChatVC alloc]init];
        [self.navigationController pushViewController:chat animated:YES];
        
    }else if (btn.tag == 105){
        //报表查看
        ReportViewVC *Report = [[ReportViewVC alloc]init];
        [self.navigationController pushViewController:Report animated:YES];
        
    }else if (btn.tag == 106){
        //需求大厅
        DemandHallVC *demand = [[DemandHallVC alloc]init];
        [self.navigationController pushViewController:demand animated:YES];
        
    }else if (btn.tag == 107){
        //视频课堂
        VideoClassVC *video = [[VideoClassVC alloc]init];
        [self.navigationController pushViewController:video animated:YES];
        
    }else if (btn.tag == 108){
        //消息推送
        MessagePushVC *MessPush = [[MessagePushVC alloc]init];
        [self.navigationController pushViewController:MessPush animated:YES];
        
    }else if (btn.tag == 109){
        //系统消息
        SystemMessageVC *SysMess = [[SystemMessageVC alloc]init];
        [self.navigationController pushViewController:SysMess animated:YES];
    }
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
