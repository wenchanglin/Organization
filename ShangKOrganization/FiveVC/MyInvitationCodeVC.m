//
//  MyInvitationCodeVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyInvitationCodeVC.h"
#import "AppDelegate.h"
#import "TransferRecordVC.h"

@interface MyInvitationCodeVC ()

@end

@implementation MyInvitationCodeVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    [self createNav];
    self.view.backgroundColor = KAppBackBgColor;
    [self createHeadView];
    [self createSelfView];
}

-(void)createHeadView
{
    UIView *HeadView         =[[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight/2 -70)];
    UIImageView *Image = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/2.8)/2, 10, kScreenWidth/2.8, 50)];
    Image.image = [UIImage imageNamed:@"法律声明hhd.png"];
    [HeadView addSubview:Image];
    HeadView.backgroundColor = kAppWhiteColor;
    UIImageView *ErWeiMaPic  = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - kScreenWidth/2.8)/2, CGRectGetMaxY(Image.frame)+10, kScreenWidth/2.8, kScreenWidth/2.8)];
    NSDictionary *dic = @{@"type":@"invative",@"code":self.RecommendCode};
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    // 1. 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2. 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 3. 将字符串转换成NSData
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    // 4. 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    
    // 5. 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    // 6. 将CIImage转换成UIImage，并放大显示
    ErWeiMaPic.image = [UIImage imageWithCIImage:outputImage scale:1 orientation:UIImageOrientationUp];
    UIImageView *PicImage    = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 135)/2-5, CGRectGetMaxY(ErWeiMaPic.frame)+10, 20, 20)];
    PicImage.image           = [UIImage imageNamed:@"邀请码-(1)@2x.png"];
    UILabel *TitleLabel      = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 120)/2+15, CGRectGetMaxY(ErWeiMaPic.frame)+10, kScreenWidth/3.5, 20)];
    TitleLabel.adjustsFontSizeToFitWidth = YES;
    TitleLabel.text          = @"我的邀请二维码";
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    TitleLabel.font          = [UIFont boldSystemFontOfSize:17];

    [HeadView addSubview:ErWeiMaPic];
    [HeadView addSubview:TitleLabel];
    [HeadView addSubview:PicImage];
    [self.view addSubview:HeadView];
}

-(void)createSelfView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, kScreenHeight/2 + 10, 20, 20)];
    imageView.image        = [UIImage imageNamed:@"多边形-1-拷贝@2x.png"];
    UILabel *ShuoMLabel    = [[UILabel alloc]initWithFrame:CGRectMake(40, kScreenHeight/2+10, 45, 20)];
    ShuoMLabel.text        = @"说明";
    ShuoMLabel.font        = [UIFont systemFontOfSize:16];
    UILabel *TTLabel       = [[UILabel alloc]initWithFrame:CGRectMake(20,kScreenHeight/2+45, kScreenWidth - 30, 15)];
    TTLabel.lineBreakMode  = NSLineBreakByWordWrapping;
    TTLabel.numberOfLines  = 0;
    TTLabel.text           = @"你在推荐学生及其他人下载安装“上课呗学生端”APP后，在学生端注册的邀请码中，扫一扫上面的二维码后，该学生端就会成为您的永久粉丝！";
    CGRect textFrame       = TTLabel.frame;
    TTLabel.frame = CGRectMake(20, kScreenHeight/2+45, kScreenWidth - 30, textFrame.size.height = [TTLabel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:TTLabel.font,NSFontAttributeName ,nil] context:nil].size.height);
    TTLabel.frame = CGRectMake(20, kScreenHeight/2+45, kScreenWidth - 30, textFrame.size.height);

    [self.view addSubview:TTLabel];
    [self.view addSubview:ShuoMLabel];
    [self.view addSubview:imageView];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 120)/2, 10, 120, 30)];
    label.text = @"我的邀请二维码";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaKclick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
}

-(void)BaKclick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
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
