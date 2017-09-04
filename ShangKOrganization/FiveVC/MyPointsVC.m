//
//  MyPointsVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyPointsVC.h"
#import "AppDelegate.h"

@interface MyPointsVC ()
{
    NSInteger AccountPoints;
}
@end

@implementation MyPointsVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    [self createData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    __weak typeof(self) weakSelf = self;
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId} url:UrL_MyAccount success:^(id responseObject) {
        if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSNull class]]) {
            AccountPoints = 0;
        }else{
            NSDictionary *Dict = [responseObject objectForKey:@"data"];
            if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSNull class]]) {
                AccountPoints = 0;
            }else{
              AccountPoints = [[Dict objectForKey:@"integral"]integerValue];
            }
        }
        [weakSelf createHeadView];
        [weakSelf createNav];
    } failure:^(NSError *error) {
    }];
}

-(void)createHeadView
{
    UIImageView *PointPic  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    PointPic.image         = [UIImage imageNamed:@"组-1@2x.png"];
    UILabel *PriceLabel    = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2-30, 50, 200, 200)];
    PriceLabel.adjustsFontSizeToFitWidth = YES;
    PriceLabel.font        = [UIFont boldSystemFontOfSize:70];
    PriceLabel.text        = [NSString stringWithFormat:@"%ld",(long)AccountPoints];
    PriceLabel.textColor   = kAppWhiteColor;
    UILabel *TicLabel      = [[UILabel alloc]initWithFrame:CGRectMake(0, 40,200, 20)];
    TicLabel.font          = [UIFont boldSystemFontOfSize:20];
    TicLabel.text          = @"我的积分";
    TicLabel.textColor     = kAppWhiteColor;
    UIImageView *JiFenPic  = [[UIImageView alloc]initWithFrame:CGRectMake(40, kScreenHeight/2,20, 20)];
    JiFenPic.image         = [UIImage imageNamed:@"金额-(1)@2x.png"];
    UILabel *JiFemSm       = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(JiFenPic.frame)+10, kScreenHeight/2, 100, 20)];
    JiFemSm.text           = @"积分说明";
    JiFemSm.font           = [UIFont systemFontOfSize:16];
    NSArray *arr = @[@"1.消费获得积分，每消费意愿获取1个积分；",@""];
    for (int i=0; i<2; i++) {
        UILabel *ItemLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(JiFenPic.frame) + 20 +i*40, kScreenWidth - 50, 30)];
        ItemLabel.text     = arr[i];
        ItemLabel.font     = [UIFont systemFontOfSize:16];
        [PointPic addSubview:ItemLabel];
    }
    
    [PointPic   addSubview:PriceLabel];
    [PriceLabel addSubview:TicLabel];
    [PointPic   addSubview:JiFenPic];
    [PointPic   addSubview:JiFemSm];
    [self.view  addSubview:PointPic];
}

-(void)createNav
{
    UIView *NavBarview      = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppClearColor;
    UIButton *button1       = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-55@2x.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaKclick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [self.view  addSubview:NavBarview];
    
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
