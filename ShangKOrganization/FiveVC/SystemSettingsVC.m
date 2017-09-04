//
//  SystemSettingsVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//
//1一定要先配置自己项目在商店的APPID,配置完最好在真机上运行才能看到完全效果哦
//#define STOREAPPID @"1080182980"
#import "SystemSettingsVC.h"
#import "AppDelegate.h"
#import "LoginVC.h"
#import "ArrowView.h"
#import "FixPassWordVC.h"
#import "FeedBackVC.h"
#import "FbwManager.h"
#import "ContactCustomerService.h"
#import "AboutUS.h"
#import <SDWebImageManager.h>
#import "EveryVideoStoreVC.h"
#import "FALViewC.h"
#import "UseHelpVC.h"
@interface SystemSettingsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArr;
    NSArray *_GtrArr;
    NSArray *_DetailText;
    ArrowView *_arrowView;
    NSInteger  _ClashNum;
}
@end

@implementation SystemSettingsVC
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
    _DetailText = [NSArray array];
    [self createTableView];
    _dataArr = [NSArray array];
    _GtrArr  = [NSArray array];
    
    _dataArr = @[@"使用帮助",@"联系客服",@"关于我们"];
    _GtrArr  = @[@"意见反馈",@"法律声明",@"清除缓存"];
   
}

-(void)createTableView
{
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        _ClashNum = (unsigned long)[files  count];
        NSLog(@"我不怕你啊看看%ld",_ClashNum);
        _DetailText = @[@"",@"",[NSString stringWithFormat:@"%ldK",_ClashNum]];
    });
    NSLog(@"我哈哈%ld",_ClashNum);
    [self.view addSubview:_tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 3;
    }else if(section == 2){
        return 3;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FbwManager *MAnager = [FbwManager shareManager];
    if (indexPath.section == 0) {
            FixPassWordVC *word = [[FixPassWordVC alloc]init];
            [self.navigationController pushViewController:word animated:YES];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            UseHelpVC *USerHel = [[UseHelpVC alloc]init];
            [self.navigationController pushViewController:USerHel animated:YES];
        }else if (indexPath.row == 1) {
            ContactCustomerService *Service = [[ContactCustomerService alloc]init];
            [self.navigationController pushViewController:Service animated:YES];
        }else if (indexPath.row == 2){
            AboutUS *about = [[AboutUS alloc]init];
            [self.navigationController pushViewController:about animated:YES];
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            FeedBackVC *Feed = [[FeedBackVC alloc]init];
            [self.navigationController pushViewController:Feed animated:YES];
        }else if (indexPath.row == 1){
            FALViewC *Fal = [[FALViewC alloc]init];
            [self.navigationController pushViewController:Fal animated:YES];
        }else if (indexPath.row == 2){
             __weak typeof(self) weakSelf = self;
            _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
            [_arrowView setBackgroundColor:[UIColor clearColor]];
            [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定清楚缓存？"];
            [_arrowView setSelectBlock:^(UIButton *button){
                if (button.tag == 10) {
                }else if (button.tag == 11){
                    [weakSelf clearCache];
                    [SVProgressHUD showSuccessWithStatus:@"清理成功"];
                    [weakSelf createTableView];
                }
            }];
            [weakSelf createTableView];
            [weakSelf.tableView reloadData];
            [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
            [_arrowView showArrowView:YES];
        }
    }else if (indexPath.section == 3) {
        
        _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
        [_arrowView setBackgroundColor:[UIColor clearColor]];
        [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"您确定要退出吗？"];
        __weak typeof(self) weakSelf = self;
        [_arrowView setSelectBlock:^(UIButton *button){
            if (button.tag == 10) {
            }else if (button.tag == 11){
                LoginVC *login = [[LoginVC alloc]init];
                MAnager.FirstIsLogin = @"NO";
                [weakSelf.navigationController pushViewController:login animated:YES];
            }
        }];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
        [_arrowView showArrowView:YES];

    }
}

//-(void)hsUpdateApp
//{
//    //2先获取当前工程项目版本号
//    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
//    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
//    
//    //3从网络获取appStore版本号
//    NSError *error;
//    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
//    if (response == nil) {
//        NSLog(@"你没有连接网络哦");
//        return;
//    }
//    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//    if (error) {
//        NSLog(@"hsUpdateAppError:%@",error);
//        return;
//    }
//    NSArray *array = appInfoDic[@"results"];
//    NSDictionary *dic = array[0];
//    NSString *appStoreVersion = dic[@"version"];
//    //打印版本号
//    NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
//    //4当前版本号小于商店版本号,就更新
//    if([currentVersion floatValue] < [appStoreVersion floatValue])
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",appStoreVersion] delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"更新",nil];
//        [alert show];
//    }else{
//        NSLog(@"版本号好像比商店大噢!检测到不需要更新");
//    }
//}
//
//- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    //5实现跳转到应用商店进行更新
//    if(buttonIndex==1)
//    {
//        //6此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
//        [[UIApplication sharedApplication] openURL:url];
//    }
//}

//清楚缓存
//+(float)folderSizeAtPath:(NSString *)path{
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    float folderSize;
//    if ([fileManager fileExistsAtPath:path]) {
//        NSArray *childerFiles=[fileManager subpathsAtPath:path];
//        for (NSString *fileName in childerFiles) {
//            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
//            
//        }
//        　　　　　//SDWebImage框架自身计算缓存的实现
//        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
////        folderSize +=[FileService fileSizeAtPath:absolutePath];
//        return folderSize;
//    }
//    return 0;
//}

//+(void)clearCache:(NSString *)path{
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:path]) {
//        NSArray *childerFiles=[fileManager subpathsAtPath:path];
//        for (NSString *fileName in childerFiles) {
//            //如有需要，加入条件，过滤掉不想删除的文件
//            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
//            [fileManager removeItemAtPath:absolutePath error:nil];
//        }
//    }
//    [[SDImageCache sharedImageCache] cleanDisk];
//}

-(void)clearCache
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSArray *files = [[ NSFileManager defaultManager ]  subpathsAtPath :cachPath];
//        NSLog ( @"files :%lu" ,(unsigned long)[files  count ]);
//        _ClashNum = (unsigned long)[files  count ];
//        NSLog(@"我哈哈%ld",_ClashNum);
        for (NSString * p in files)
        {
            NSError * error;
            NSString * path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path])
            {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
    });
    [SVProgressHUD showWithStatus:@"清理中"];
    [self.tableView reloadData];
    [self createTableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Chat"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Chat"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"修改登录密码";
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = _dataArr[indexPath.row];
    }
    if (indexPath.section == 2) {
        cell.textLabel.text = _GtrArr[indexPath.row];
        if (_DetailText.count == 0) {
            
        }else{
        cell.detailTextLabel.text = _DetailText[indexPath.row];
        }
    }
    if (indexPath.section == 3) {
        cell.textLabel.text = @"退出登录";
    }
    
    return cell;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"系统设置";
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
