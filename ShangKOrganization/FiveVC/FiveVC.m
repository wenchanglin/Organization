//
//  FiveVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/9.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FiveVC.h"
#import "AppDelegate.h"
#import "SystemSettingsVC.h"
#import "MyInvitationCodeVC.h"
#import "ErWeiMaVC.h"
#import "MyPointsVC.h"
#import "VideoVipVC.h"
#import "MyVideosVC.h"
#import "MyAccountVC.h"
#import "MyCompanyVC.h"
#import "MyOrderVC.h"
#import "MyOrderCar.h"
#define PictureArr @[@"购物车-(1)@2x.png",@"账户-(1)@2x.png",@"视频-(12)@2x.png",@"会员-(3)@2x.png",@"积分-(3)@2x.png",@"图层-81@2x.png",@"123@2x.png",@"设置-(2)@2x_25.png"]
#define TitleARr @[@"购物车",@"我的账户",@"我的视频",@"视频会员",@"我的积分",@"收费二维码",@"我的邀请码",@"系统设置"]
@interface FiveVC ()
{
    UILabel *PersonLabel;
    NSString *ConpanyName;
    NSString *ConpanyAddress;
    NSString *ConpanyPersonName;
    NSArray  *TitleArr;
    NSString *PicUserInfo;
    NSString *RecommendCode;
}
@end

@implementation FiveVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = NO;
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    [defaults synchronize];
    [self createDAta];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    TitleArr = [NSArray array];
    [self createSEcondView];
}

-(void)createDAta
{
    __weak typeof(self) weakSelf = self;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId} url:UrL_MyOrgDetails success:^(id responseObject) {
//        NSLog(@"我真的笑了%@",responseObject);
        NSDictionary *rootD = [responseObject objectForKey:@"data"];
        ConpanyAddress = [rootD objectForKey:@"location"];
//        NSLog(@"公司法人%@",[rootD objectForKey:@"legalPersonName"]);
        ConpanyPersonName = [rootD objectForKey:@"legalPersonName"];
//        NSLog(@"公司地址:%@",ConpanyAddress);
        PicUserInfo = rootD[@"userBase"][@"userPhotoHead"];
        if ([rootD[@"userBase"][@"recommendCode"] isKindOfClass:[NSNull class]]) {
            RecommendCode = @"";
        }else{
          RecommendCode = rootD[@"userBase"][@"recommendCode"];
          ConpanyName = rootD[@"userBase"][@"nickName"];
        }
        [defaults setObject:rootD[@"userBase"][@"username"] forKey:@"UinfoUser"];
        [defaults synchronize];
        [weakSelf createHeadView];
        
    } failure:^(NSError *error) {
    }];
}

#pragma mark-----------------------视图-----------------------

-(void)createHeadView
{
    UIView *HeadView       = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight/2.4)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(HeadView.frame) - 120)];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TApImageView:)];
    imageView.image        = [UIImage imageNamed:@"图层-10-副本@2x.png"];
    UIButton *button       = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame           = CGRectMake(10, (CGRectGetMaxY(HeadView.frame) - 220)/2, kScreenWidth/3.6, kScreenWidth/3.6);
    button.layer.cornerRadius =kScreenWidth/3.6/2 ;
    button.layer.masksToBounds = YES;
    if ([PicUserInfo isKindOfClass:[NSNull class]]) {
        [button setBackgroundImage:[UIImage imageNamed:@"Orgicon_logo.png"] forState:UIControlStateNormal];
    }else{
        [button setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,PicUserInfo]]];
    }
    [button addTarget:self action:@selector(PersonPic:) forControlEvents:UIControlEventTouchUpInside];
    NSArray *PicArr        = @[@"周边机构@2x.png",@"定位@2x.png"];
    if (ConpanyName == nil) {
        if (ConpanyAddress == nil) {
            TitleArr      = @[@"",@""];
        }else{
        TitleArr      = @[@"",ConpanyAddress];
        }
    }else if (ConpanyAddress == nil){
        if (ConpanyName == nil) {
            TitleArr      = @[@"",@""];
        }else{
        TitleArr      = @[ConpanyName,@""];
        }
    }else{
      TitleArr      = @[ConpanyName,ConpanyAddress];//@"黑白键音乐工作室",@"浙江省杭州市余杭区良渚"
    }
    for (int i=0; i<2; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+10, (CGRectGetMaxY(HeadView.frame) - 220)/2 +10+50*i, 25, 25)];
        image.image        = [UIImage imageNamed:PicArr[i]];
        UILabel *label     = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+40,  (CGRectGetMaxY(HeadView.frame) - 220)/2 +15+40*i, kScreenWidth - 150, 25)];
        label.text         = TitleArr[i];
        label.font = [UIFont systemFontOfSize:16];
        label.numberOfLines = 0;
        label.adjustsFontSizeToFitWidth = YES;
        label.textColor = kAppWhiteColor;
        CGRect textFrame   = label.frame;
        label.frame = CGRectMake(CGRectGetMaxX(button.frame)+40,  (CGRectGetMaxY(HeadView.frame) - 220)/2 +15+50*i, kScreenWidth - 160, textFrame.size.height = [label.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName ,nil] context:nil].size.height);
//        NSLog(@"%f",textFrame.size.height);
        if (textFrame.size.height>50) {
            label.frame = CGRectMake(CGRectGetMaxX(button.frame)+40,  (CGRectGetMaxY(HeadView.frame) - 220)/2 +15+35*i, kScreenWidth - 160, textFrame.size.height);
        }else{
        label.frame = CGRectMake(CGRectGetMaxX(button.frame)+40,  (CGRectGetMaxY(HeadView.frame) - 220)/2 +15+50*i, kScreenWidth - 160, textFrame.size.height);
        }
        [imageView addSubview:image];
        [imageView addSubview:label];
    }
    UIImageView *SpPic = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+10, 30, kScreenHeight/25)];
    SpPic.image        = [UIImage imageNamed:@"我的订单@2x.png"];
    UILabel *SpLabel   = [[UILabel alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(imageView.frame)+10, kScreenWidth - 130, kScreenHeight/25)];
    SpLabel.text       = @"商品订单";
    SpLabel.font       = [UIFont boldSystemFontOfSize:18];
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(SpLabel.frame)+10, kScreenWidth, 1)];
    lineLabel.backgroundColor = kAppLineColor;
    NSArray *TitArr    = @[@"待收货",@"待发货",@"待评价",@"退货",@"历史订单"];
    NSArray *LageARr   = @[@"图层-77@2x_1.png",@"图层-78@2x_0.png",@"待评价-(1)@2x.png",@"图层-80@2x_82.png",@"下载(62)@2x.png"];
    for (int i=0; i<5; i++) {
        UIButton *PersonButton = [UIButton buttonWithType:UIButtonTypeCustom];
        PersonButton.tag       = i;
        PersonButton.frame     = CGRectMake(20+i*30+i*(kScreenWidth - 40 -150)/4, CGRectGetMaxY(lineLabel.frame)+10, 30, 30);
        [PersonButton setBackgroundImage:[UIImage imageNamed:LageARr[i]] forState:UIControlStateNormal];
        if (PersonButton.tag == 0) {
//            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(23, -7, 14, 14)];
//            label.text = @"2";
//            label.textColor            = kAppWhiteColor;
//            label.backgroundColor      = kAppRedColor;
//            label.textAlignment        = NSTextAlignmentCenter;
//            label.layer.cornerRadius   = 7;
//            label.layer.masksToBounds  =YES;
//            label.font = [UIFont systemFontOfSize:11];
//            [PersonButton addSubview:label];
        }
        [PersonButton addTarget:self action:@selector(PersonInfoBTn:) forControlEvents:UIControlEventTouchUpInside];
        PersonLabel   = [[UILabel alloc]initWithFrame:CGRectMake(5+i*30+i*(kScreenWidth - 40 -150)/4, CGRectGetMaxY(PersonButton.frame)+5, 60, 15)];
        PersonLabel.font          = [UIFont systemFontOfSize:14];
        PersonLabel.textAlignment = NSTextAlignmentCenter;
        PersonLabel.text          = TitArr[i];
        [HeadView addSubview:PersonButton];
        [HeadView addSubview:PersonLabel];
    }
    UILabel *FixLAbel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/3)/2, CGRectGetMaxY(imageView.frame)-25, kScreenWidth/3, 20)];
    FixLAbel.text = @"(点击修改资料)";
    FixLAbel.textColor = kAppWhiteColor;
    FixLAbel.font = [UIFont systemFontOfSize:16];
    FixLAbel.textAlignment = NSTextAlignmentCenter;
    FixLAbel.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    [imageView addSubview:FixLAbel];
    [imageView addSubview:button];
    [HeadView  addSubview:SpPic];
    [HeadView  addSubview:SpLabel];
    [HeadView  addSubview:lineLabel];
    [HeadView  addSubview:imageView];
    [self.view addSubview:HeadView];
}

#pragma mark----------------------8键------------------------

-(void)createSEcondView
{
    for (int i = 0; i < 8; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame     = CGRectMake((i % 3)*kScreenWidth/3, kScreenHeight/2.4 +(i / 3)*(kScreenHeight/7.2) +(kScreenHeight/14) , kScreenWidth/3, kScreenHeight/7.2);
        button.tag       = 100+i;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth/3 - 40)/2, (button.frame.size.height - 40)/2-10, 40, 40)];
        imageView.image  = [UIImage imageNamed:PictureArr[i]];
        [button addSubview:imageView];
        UILabel * LineLabel        = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight/2.4 +(i / 3)*(kScreenHeight/7.2) + (kScreenHeight/14), kScreenWidth, 0.5)];
        LineLabel.backgroundColor  = kAppLineColor;
        UILabel * LineLabelT       = [[UILabel alloc]initWithFrame:CGRectMake((i % 3)*kScreenWidth/3, CGRectGetMinY(button.frame) , 0.5, 100)];
        LineLabelT.backgroundColor = kAppLineColor;
        [button addTarget:self action:@selector(BTnClck:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *DicLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth/3 - 40)/2-24, CGRectGetMaxY(imageView.frame)+5, 90, 15)];
        DicLabel.font     = [UIFont systemFontOfSize:14];
        DicLabel.textAlignment = NSTextAlignmentCenter;
        DicLabel.text     = TitleARr[i];
        
        [self.view addSubview:LineLabel];
        [button    addSubview:DicLabel];
        [self.view addSubview:LineLabelT];
        [self.view addSubview:button];
    }
}
//个人头像
-(void)PersonPic:(UIButton *)Picbtn
{
    NSLog(@"点我");
    MyCompanyVC *company = [[MyCompanyVC alloc]init];
    company.AddressTit = ConpanyAddress;
    company.PicImage = PicUserInfo;
    company.AddressPeople = ConpanyPersonName;
    company.UserNickNameCom = ConpanyName;
    [self.navigationController pushViewController:company animated:YES];
}

-(void)TApImageView:(UITapGestureRecognizer *)ImageTap
{
    NSLog(@"进入个人信息");
    MyCompanyVC *company = [[MyCompanyVC alloc]init];
    company.AddressTit = ConpanyAddress;
    company.PicImage = PicUserInfo;
    company.AddressPeople = ConpanyPersonName;
    company.UserNickNameCom = ConpanyName;
    [self.navigationController pushViewController:company animated:YES];
}
//订单 5
-(void)PersonInfoBTn:(UIButton *)OrderBtn
{
    
    MyOrderVC *MainView = [[MyOrderVC alloc]init];
    MainView.num = OrderBtn.tag;
    [self.navigationController pushViewController:MainView animated:YES];
}

//个人 8
-(void)BTnClck:(UIButton *)Info
{
    if (Info.tag == 100) {
        MyOrderCar *Car = [[MyOrderCar alloc]init];
        [self.navigationController pushViewController:Car animated:YES];
    }else if(Info.tag == 101){
        //我的账户
        MyAccountVC *Account = [[MyAccountVC alloc]init];
        [self.navigationController pushViewController:Account animated:YES];
    }else if(Info.tag == 102){
        //我的网络视频
        MyVideosVC *video = [[MyVideosVC alloc]init];
        [self.navigationController pushViewController:video animated:YES];
    }else if(Info.tag == 103){
        //视频会员
        VideoVipVC *Vip = [[VideoVipVC alloc]init];
        [self.navigationController pushViewController:Vip animated:YES];
    }else if(Info.tag == 104){
        //我的积分
        MyPointsVC *point = [[MyPointsVC alloc]init];
        [self.navigationController pushViewController:point animated:YES];
    }else if(Info.tag == 105){
        //收费二维码
        ErWeiMaVC *erweima = [[ErWeiMaVC alloc]init];
        [self.navigationController pushViewController:erweima animated:YES];
    }else if(Info.tag == 106){
        //我的邀请码MyInvitationCode
        MyInvitationCodeVC *code = [[MyInvitationCodeVC alloc]init];
        code.RecommendCode = RecommendCode;
        [self.navigationController pushViewController:code animated:YES];
    }else if(Info.tag == 107){
       //系统设置
        SystemSettingsVC *setting = [[SystemSettingsVC alloc]init];
        [self.navigationController pushViewController:setting animated:YES];
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
