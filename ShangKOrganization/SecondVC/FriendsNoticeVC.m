//
//  FriendsNoticeVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FriendsNoticeVC.h"
#import "AppDelegate.h"
#import "FriendNoFirstCell.h"
#import "FirendNoSecondCell.h"
#import "FriendsNoticeModel.h"
@interface FriendsNoticeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSInteger       _page;
    BOOL            _isPulling;
}
@end

@implementation FriendsNoticeVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    [self createTableView];
//    [self form];
//    [self updown];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self createNav];
    [self createData];
    
    self.view.backgroundColor = kAppWhiteColor;
}

//下拉刷新
- (void)form {
    __weak FriendsNoticeVC *weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        _isPulling = YES;
        [weakSelf createData];
    }];
}
//上拉加载
- (void)updown {
    __weak FriendsNoticeVC *weakSelf = self;
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
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"myUserBaseId":Manager.UUserId} url:UrL_FriendMessageCenter success:^(id responseObject) {
        NSLog(@"你瞧%@",responseObject);
//        if (_isPulling) {
            [_dataArray removeAllObjects];
//        }
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in Arr) {
            FriendsNoticeModel *Model = [[FriendsNoticeModel alloc]init];
            [Model setDic:Dict];
            [_dataArray addObject:Model];
        }
//        if (_isPulling) {
//            [_tableView.mj_header endRefreshing];
//        }else{
//            [_tableView.mj_footer endRefreshing];
//        }
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
    FriendsNoticeModel *Model = _dataArray[indexPath.section];
    if (Model.FriendsMessageStatus == 1) {
        return 170;
    }else{
    return 120;
    }
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
    FriendsNoticeModel *Model = _dataArray[indexPath.section];
    if (Model.FriendsMessageStatus == 1) {
        FriendNoFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoFir"];
        if (!cell) {
            cell = [[FriendNoFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoFir"];
        }
        NSArray *arr = @[@"拒绝",@"同意"];
        for (int i=0; i<2; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = indexPath.section;
            button.frame = CGRectMake((kScreenWidth-(kScreenWidth/5)*2)/3+i*(kScreenWidth/5)*2, 90, kScreenWidth/5, 30);
            [button setTitle:arr[i] forState:UIControlStateNormal];
            if ([button.titleLabel.text isEqualToString:@"拒绝"]) {
                button.backgroundColor = kAppGrayColor;
            }else{
                button.backgroundColor = kAppBlueColor;
            }
            [button setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
            [button addTarget:self action:@selector(BTNFF:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWith:Model];
        return cell;
    }else{
        FirendNoSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatInfo"];
        if (!cell) {
            
            cell = [[FirendNoSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatInfo"];
            [cell configWith:Model];
        }
        return cell;
    }
}
-(void)BTNFF:(UIButton *)btn
{
//    NSLog(@"看看Tag:%ld",btn.tag);
    __weak typeof(self) weakSelf = self;
    FriendsNoticeModel *Model = _dataArray[btn.tag];
    if ([btn.titleLabel.text isEqualToString:@"拒绝"]) {
        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"makeFriendApplyId":Model.FriendsMessageId,@"result":@3} url:UrL_NoFriend success:^(id responseObject) {
//             [_tableView reloadData];
            [weakSelf createData];
        } failure:^(NSError *error) {
        }];
//        [self createTableView];
    }else{
        NSLog(@"同意");
        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"makeFriendApplyId":Model.FriendsMessageId,@"result":@2} url:UrL_NoFriend success:^(id responseObject) {
//            [_tableView reloadData];
            [weakSelf createData];
        } failure:^(NSError *error) {
        }];
//        [self createTableView];
    }
}

-(void)createNav
{
    
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"好友通知";
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
