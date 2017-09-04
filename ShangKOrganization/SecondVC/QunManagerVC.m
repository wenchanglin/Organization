//
//  QunManagerVC.m
//  ShangKOrganization
//
//  Created by apple on 17/1/9.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import "QunManagerVC.h"
#import "AppDelegate.h"
#import "QunManagerModel.h"
#import "QunManagerCellTableViewCell.h"
#import "FbwManager.h"
@interface QunManagerVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@end

@implementation QunManagerVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self createNav];
    [self createData];
    [self createTableView];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId} url:UrL_ListOfTeacher success:^(id responseObject) {
        [_dataArray removeAllObjects];
        //        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dic in arr) {
            QunManagerModel *Model =[[QunManagerModel alloc]init];
            [Model setDic:dic];
            [_dataArray addObject:Model];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
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
    return 60;
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
    QunManagerCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatSsLine"];
    if (!cell) {
        
        cell = [[QunManagerCellTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ChatSsLine"];
    }
    QunManagerModel *Model = _dataArray[indexPath.section];
    if ([Model.QunManagerUserPhotoHead isKindOfClass:[NSNull class]]||Model.QunManagerUserPhotoHead == nil) {
        cell.QunImagePic.image = [UIImage imageNamed:@"哭脸.png"];
    }else{
        [cell.QunImagePic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.QunManagerUserPhotoHead]] placeholderImage:nil];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth-100, 15, 90, 30);
    [button setTitle:@"设为管理员" forState:UIControlStateNormal];
    button.backgroundColor = kAppBlueColor;
    button.tag = indexPath.section;
    [button setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button addTarget:self action:@selector(AdminSet:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:button];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configWithModel:Model];
    [cell.contentView addSubview:cell.QunImagePic];
    return cell;
}

-(void)AdminSet:(UIButton *)Admin
{
    FbwManager *Manager = [FbwManager shareManager];
    QunManagerModel *Model = _dataArray[Admin.tag];
    Manager.IsZiJiJianQunId = Model.QunManagerId;
    Manager.IsZiJiJianQunName = Model.QunManagerNickName;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 90)/2, 10, 90, 30)];
    label.text = @"设置群管理";
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
