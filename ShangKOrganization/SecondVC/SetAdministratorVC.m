//
//  SetAdministratorVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SetAdministratorVC.h"
#import "AppDelegate.h"
#import "SetAdminCell.h"
#import "TeacherManagerModel.h"
#import "FbwManager.h"
@interface SetAdministratorVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSInteger       _page;
    BOOL            _isPulling;
}
@end

@implementation SetAdministratorVC

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
    [self form];
    [self updown];
    self.view.backgroundColor = kAppWhiteColor;
}

//下拉刷新
- (void)form {
    __weak SetAdministratorVC *weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        _isPulling = YES;
        [weakSelf createData];
    }];
}
//上拉加载
- (void)updown {
    __weak SetAdministratorVC *weakSelf = self;
    _tableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        _page ++;
        _isPulling = NO;
        if (_page >= 50) {
            [_tableView.mj_footer endRefreshing];
            return ;
        } else {
            [weakSelf createData];
        }
    }];
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_ListOfTeacher success:^(id responseObject) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        if (_isPulling) {
            [_dataArray removeAllObjects];
        }
//        [_dataArray removeAllObjects];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dic in arr) {
            TeacherManagerModel *Model =[[TeacherManagerModel alloc]init];
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
    SetAdminCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatSLine"];
    if (!cell) {
        
        cell = [[SetAdminCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ChatSLine"];
    }
    TeacherManagerModel *Model = _dataArray[indexPath.section];
    if ([Model.TeacherManagerUserPhotoHead isKindOfClass:[NSNull class]]||Model.TeacherManagerUserPhotoHead == nil) {
        cell.ImagePic.image = [UIImage imageNamed:@"哭脸.png"];
    }else{
        [cell.ImagePic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.TeacherManagerUserPhotoHead]] placeholderImage:nil];
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
    [cell.contentView addSubview:cell.ImagePic];
    return cell;
}

-(void)AdminSet:(UIButton *)Admin
{
    FbwManager *Manager = [FbwManager shareManager];
    TeacherManagerModel *Model = _dataArray[Admin.tag];
    if ([self.PushYes isEqualToString:@"YESPush"]) {
        Manager.IsZiJiJianQunId = Model.TeacherManagerId;
        Manager.IsZiJiJianQunName = Model.TeacherManagerNickName;
        Manager.CouldYes = self.PushYes;
//        self.PushYes = @"";
    }else{
    if ([self.WhereCome isEqualToString:@"ZiJiChuangJian"]) {
        Manager.UserAddAdminId = Model.TeacherManagerId;
        Manager.UserAddAdminName = Model.TeacherManagerNickName;
        NSLog(@"自主创建管理员 走一波");
    }else{
        Manager.TeacherId = Model.TeacherManagerId;
        Manager.isAdmintor = YES;
        NSLog(@"课程创建管理员 走一波");
        Manager.TeacherNAme = Model.TeacherManagerNickName;
    }
    }
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

@end
