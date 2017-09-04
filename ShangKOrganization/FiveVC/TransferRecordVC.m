//
//  TransferRecordVC.m
//  ShangKOrganization
//
//  Created by apple on 16/12/12.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "TransferRecordVC.h"
#import "TransferRecordModel.h"
#import "TransferRecordCell.h"

@interface TransferRecordVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end
@implementation TransferRecordVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self createData];
    [self createNav];
    [self createTableView];
    self.view.backgroundColor = KAppBackBgColor;
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkAcceptId":Manager.UUserId} url:UrL_TransferRecord success:^(id responseObject) {
        [_dataArray removeAllObjects];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in Arr) {
            TransferRecordModel *Model = [[TransferRecordModel alloc]init];
            [Model setDic:Dict];
            NSDictionary *dic = [Dict objectForKey:@"userInfoBase"];
            [Model setPeople:dic];
            [_dataArray addObject:Model];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    TransferRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Record"];
    if (!cell) {
        cell = [[TransferRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Record"];
    }
    TransferRecordModel *Model = _dataArray[indexPath.section];
    if (Model.TransferRecordStatus == 10) {
        cell.TransferRecordPeople.text = [NSString stringWithFormat:@"%@(转账中)",Model.TransferRecordPeople];
        cell.TransferRecordPeople.textColor = kAppBlueColor;
    }else{
        cell.TransferRecordPeople.text = [NSString stringWithFormat:@"%@(已转账)",Model.TransferRecordPeople];
        cell.TransferRecordPeople.textColor = kAppRedColor;
    }
    [cell.contentView addSubview:cell.TransferRecordPeople];
    [cell configWith:Model];
    return cell;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 90)/2, 10, 90, 30)];
    label.text      = @"转账记录";
    label.textAlignment = NSTextAlignmentCenter;
    label.font      = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaKclick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
    
}

-(void)BaKclick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
