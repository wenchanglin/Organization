//
//  MessagePushVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MessagePushVC.h"
#import "AppDelegate.h"
#import "MessagePushCell.h"
#import "AddMessageVC.h"
#import "EveryMessageVC.h"
#import "MessagePushModel.h"

@interface MessagePushVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView    *_TableView;
    NSMutableArray *_dataArray;
    NSInteger       _page;
    BOOL            _isPulling;
    NSString       *_OrgName;
}
@end

@implementation MessagePushVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    FbwManager *Manager = [FbwManager shareManager];
    if (Manager.PullPage == 3) {
        _page = 0;
        Manager.PullPage = 0;
    }
    [self createData];
    [_TableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    _dataArray = [NSMutableArray array];
    [self createNav];
    [self createTableView];
    [self form];
    [self updown];
    self.view.backgroundColor = kAppWhiteColor;
}

//下拉刷新
- (void)form {
    __weak MessagePushVC *weakSelf = self;
    _TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        _isPulling = YES;
        [weakSelf createData];
    }];
}
//上拉加载
- (void)updown {
    __weak MessagePushVC *weakSelf = self;
    _TableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        _page ++;
        _isPulling = NO;
        if (_page >= 50) {
            [_TableView.mj_footer endRefreshing];
            return ;
        } else {
            [weakSelf createData];
        }
    }];
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId} url:UrL_MyOrgDetails success:^(id responseObject) {
        NSDictionary *Dict = [responseObject objectForKey:@"data"];
        NSDictionary *dict = [Dict objectForKey:@"userBase"];
        if ([[dict objectForKey:@"nickName"] isKindOfClass:[NSNull class]]) {
            _OrgName = @"暂无机构名";
        }else{
            _OrgName = [dict objectForKey:@"nickName"];
        }
        [_TableView reloadData];
    } failure:^(NSError *error) {
    }];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_PushMessage success:^(id responseObject) {
//        NSLog(@"推送%@",responseObject);
        if (_isPulling || Manager.IsListPulling == 3) {
            [_dataArray removeAllObjects];
            Manager.IsListPulling = 0;
        }
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *Dic in arr) {
            MessagePushModel *Model = [[MessagePushModel alloc]init];
            [Model setDic:Dic];
            [_dataArray addObject:Model];
        }
        if (_isPulling) {
            [_TableView.mj_header endRefreshing];
        }else{
            [_TableView.mj_footer endRefreshing];
        }
        [_TableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createTableView
{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    [self.view addSubview:_TableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessagePushModel *Model = _dataArray[indexPath.section];
    EveryMessageVC *everyMess = [[EveryMessageVC alloc]init];
    everyMess.NavTitle = Model.PushMessageTitle;
    everyMess.EveryMessId = Model.PushMessageId;
    [self.navigationController pushViewController:everyMess animated:YES];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessagePushCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessPush"];
    if (!cell) {
        cell = [[MessagePushCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessPush"];
    }
    MessagePushModel *Model = _dataArray[indexPath.section];
    [cell configWithModel:Model];
    cell.OffersLabel.text = _OrgName;
    [cell.contentView addSubview:cell.OffersLabel];
    return cell;
}
-(void)createNav
{
    
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"消息推送";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(Baklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 15, 20, 20);
    [button2 setImage:[UIImage imageNamed:@"创建-(2).png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(BtnAddClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
}

-(void)Baklick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

//添加消息
-(void)BtnAddClick:(UIButton *)addBtn
{
    AddMessageVC *addMess = [[AddMessageVC alloc]init];
    
    [self.navigationController pushViewController:addMess animated:YES];
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
