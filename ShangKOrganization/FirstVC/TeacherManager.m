//
//  TeacherManager.m
//  ShangKOrganization
//
//  Created by apple on 16/9/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "TeacherManager.h"
#import "AppDelegate.h"
#import "AddTeacher.h"
#import "TeacherDetailsVC.h"
#import "TeacherManagerModel.h"
#import "TeacherManagerCell.h"
#import "FbwManager.h"
@interface TeacherManager ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView    *_tableView;
    NSMutableArray *_dataArray;
    NSInteger       _page;
    BOOL            _isPulling;
}
@end

@implementation TeacherManager

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    self.fd_interactivePopDisabled = YES;
    FbwManager *Manager = [FbwManager shareManager];
    if (Manager.PullPage == 3) {
        _page = 0;
        Manager.PullPage = 0;
    }
    _dataArray = [NSMutableArray array];
    [self createData];
    [self createNav];
    [self createTableView];
    [self form];
    [self updown];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kAppMainBgColor;
}

//下拉刷新
- (void)form {
    __weak TeacherManager *weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        _isPulling = YES;
        [weakSelf createData];
    }];
}
//上拉加载
- (void)updown {
    __weak TeacherManager *weakSelf = self;
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
    FbwManager *Manager = [FbwManager shareManager];//3109081a-14fc-41da-9408-90434490a560
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_ListOfTeacher success:^(id responseObject) {
        if (_isPulling) {
            [_dataArray removeAllObjects];
        }
        NSLog(@"你看看搞笑%@",responseObject);
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dic in arr) {
             TeacherManagerModel *Model =[[TeacherManagerModel alloc]init];
            [Model setDic:dic];
            [_dataArray addObject:Model];
        }
        if (_isPulling) {
            [_tableView.mj_header endRefreshing];
        }else{
            [_tableView.mj_footer endRefreshing];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FbwManager *Manager = [FbwManager shareManager];
    TeacherManagerModel *Model = _dataArray[indexPath.section];
    TeacherDetailsVC *details =[[TeacherDetailsVC alloc]init];
    details.TeacherDeSex = Model.TeacherManagerSex;
    details.TeacherDeName = Model.TeacherManagerNickName;
    details.TeacherDeObjeceNum = Model.TeacherManagerCourseCount;
    details.TeacherDePhoto = Model.TeacherManagerUserPhotoHead;
    details.TeacherDeDict = Model.TeacherManagerDict;
    details.TeacherDeId = Model.TeacherManagerId;
    Manager.JianTYeMian = 2;
    [self.navigationController pushViewController:details animated:YES];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Jack"];
    if (!cell) {
        cell = [[TeacherManagerCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Jack"];
    }
    cell.preservesSuperviewLayoutMargins = NO;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    TeacherManagerModel *Model = _dataArray[indexPath.section];
    if (Model.TeacherManagerSex==1) {
        cell.TeacherManagerSex.image = [UIImage imageNamed:@"形状-1-拷贝-2@2x.png"];
    }else{
        cell.TeacherManagerSex.image = [UIImage imageNamed:@"形状-2-拷贝@2x.png"];
    }
    [cell configWithModel:Model];
    
    return cell;
}

-(void)createNav
{
    
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"教师管理";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BtnBackClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 30, 30);
    [button2 setImage:[UIImage imageNamed:@"添加.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(BtnAddClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
}

-(void)BtnBackClick:(UIButton *)btn1
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)BtnAddClick:(UIButton *)btn2
{
    AddTeacher *teacher = [[AddTeacher alloc]init];
    teacher.NAvTit = @"创建教师";
    [self.navigationController pushViewController:teacher animated:YES];
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
