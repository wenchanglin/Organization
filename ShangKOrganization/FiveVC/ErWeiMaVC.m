//
//  ErWeiMaVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ErWeiMaVC.h"
#import "AppDelegate.h"
#import "TransferRecordVC.h"
@interface ErWeiMaVC ()

@end

@implementation ErWeiMaVC
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
}

-(void)createHeadView
{
    FbwManager *Manager = [FbwManager shareManager];
    UIView *HeadView         =[[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,kScreenHeight/2-70)];
    HeadView.backgroundColor = kAppWhiteColor;
    UIImageView *ErWeiMaPic  = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - kScreenWidth/2.8)/2, (kScreenHeight/2-70-kScreenWidth/2.8)/2, kScreenWidth/2.8, kScreenWidth/2.8)];
     NSDictionary *dic = @{@"type":@"account",@"id":Manager.UUserId};
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
     ErWeiMaPic.image = [UIImage imageWithCIImage:outputImage scale:10.0 orientation:UIImageOrientationUp];
    
    UIImageView *imageView   = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    imageView.image          = [UIImage imageNamed:@"多边形-1-拷贝@2x.png"];
    UILabel *ShuoMLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 45, 20)];
    ShuoMLabel.text          = @"说明";
    ShuoMLabel.font          = [UIFont systemFontOfSize:16];
    UILabel *TTLabel         = [[UILabel alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(ShuoMLabel.frame)+10, kScreenWidth - 30, 15)];
    TTLabel.text             = @"学生端扫一扫后，费用可以直接转入我账户上。";
    UIView *FootView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(HeadView.frame)+20, kScreenWidth, kScreenHeight - (CGRectGetMaxY(HeadView.frame)+20))];
    FootView.backgroundColor = kAppWhiteColor;
    
    [HeadView  addSubview:ErWeiMaPic];
    [FootView  addSubview:imageView];
    [FootView  addSubview:ShuoMLabel];
    [FootView  addSubview:TTLabel];
    [self.view addSubview:FootView];
    [self.view addSubview:HeadView];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 90)/2, 10, 90, 30)];
    label.text      = @"收费二维码";
    label.textAlignment = NSTextAlignmentCenter;
    label.font      = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaKclick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2       = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame           = CGRectMake(kScreenWidth - 80, 10, 70, 30);
    [button2 setTitle:@"转账记录" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:15];
    [button2 addTarget:self action:@selector(ZhuanzClick) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
    
}

-(void)ZhuanzClick
{
    TransferRecordVC *Record = [[TransferRecordVC alloc]init];
    [self.navigationController pushViewController:Record animated:YES];
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
