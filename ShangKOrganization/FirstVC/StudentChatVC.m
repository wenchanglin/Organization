//
//  StudentChatVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "StudentChatVC.h"
#import "AppDelegate.h"
#import "FriendDanChatCell.h"
#import "FriendDanChatModel.h"
#import "ChatWithFriendVc.h"
#import <RongIMKit/RongIMKit.h>

@interface StudentChatVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataThreeArray;
    NSInteger       _page;
    BOOL            _isPulling;
}
@end

@implementation StudentChatVC

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
    _dataThreeArray = [NSMutableArray array];
    [self createNav];
    [self createTableView];
    [self createThreeData];
    [self form];
    [self updown];
    self.view.backgroundColor = kAppWhiteColor;
}

//下拉刷新
- (void)form {
    __weak StudentChatVC *weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        _isPulling = YES;
        [weakSelf createThreeData];
    }];
}
//上拉加载
- (void)updown {
    __weak StudentChatVC *weakSelf = self;
    _tableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        _page ++;
        _isPulling = NO;
        if (_page >= 50) {
            [_tableView.mj_footer endRefreshing];
            return ;
        } else {
            [weakSelf createThreeData];
        }
    }];
}

-(void)createThreeData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_FriendQuery success:^(id responseObject) {
        if (_isPulling) {
            [_dataThreeArray removeAllObjects];
        }
        NSLog(@"课程咨询%@",responseObject);
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *Dict = [responseObject objectForKey:@"data"];
        NSArray *arr = [Dict objectForKey:@"iData"];
        for (NSDictionary *dict in arr) {
            FriendDanChatModel *Model =[[FriendDanChatModel alloc]init];
            [Model setDic:dict];
            [_dataThreeArray addObject:Model];
        }
        NSLog(@"默认%ld",(unsigned long)_dataThreeArray.count);
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
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataThreeArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FriendDanChatModel *Model = _dataThreeArray[indexPath.section];
    ChatWithFriendVc *chat = [[ChatWithFriendVc alloc]init];
    chat.conversationType = ConversationType_PRIVATE;
    chat.targetId = Model.FriendDanChatId; //Manager.UUserId;//[defaults objectForKey:@"UserId"];//Model.FriendDanChatId;//单聊对方ID
    chat.UserInfoId = Model.FriendDanChatId;
    chat.QuTitle = @"Dan";
    chat.NavTitleStr = Model.FriendDanChatNickName;
    [self.navigationController pushViewController:chat animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendDanChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ObjectX"];
    if (!cell) {
        cell = [[FriendDanChatCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ObjectX"];
    }
    FriendDanChatModel *Model = _dataThreeArray[indexPath.section];
    [cell configWith:Model];
    return cell;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"学生咨询";
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
