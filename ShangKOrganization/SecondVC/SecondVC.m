//
//  SecondVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/9.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SecondVC.h"
#import "LHSJSNeedTop.h"
#import "AppDelegate.h"
#import "FriendsNoticeVC.h"
#import "CreateGroupVC.h"
#import "ChatWithFriendVc.h"
#import <RongIMKit/RongIMKit.h>
#import "SecondModel.h"
#import "SecondCell.h"
#import "FriendDanChatModel.h"
#import "FriendDanChatCell.h"
@interface SecondVC ()<UITableViewDelegate,UITableViewDataSource>
{
    LHSJSNeedTop   * _topView;
    UIScrollView   * _mainScrollView;
    NSInteger        pageIndex;
    CGFloat          priorY;
    UITableView    * firstView;
    UITableView    * secondView;
    UITableView    * threeView;
    NSMutableArray *_dataArray;
    NSMutableArray *_dataTwoArray;
    NSMutableArray *_dataThreeArray;
}
@end

@implementation SecondVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = NO;
    [self createData];
    [self createTwoData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    pageIndex = 0;
    _dataArray  = [NSMutableArray array];
    _dataTwoArray = [NSMutableArray array];
    _dataThreeArray = [NSMutableArray array];
    [self createNav];
    [self createData];
    [self settopview];
    [self initMainScrollView];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];//3109081a-14fc-41da-9408-90434490a560
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId} url:UrL_ChatGroupsQuery success:^(id responseObject) {
        [_dataArray removeAllObjects];
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *RootDic =[responseObject objectForKey:@"data"];
        NSArray *ARr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *Dic in ARr) {
            SecondModel *Model = [[SecondModel alloc]init];
            [Model setDic:Dic];
            [_dataArray addObject:Model];
        }
        [firstView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createTwoData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId,@"type":@1} url:UrL_FriendQuery success:^(id responseObject) {
//        NSLog(@"看看%@",responseObject);
        [_dataTwoArray removeAllObjects];
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *Dict = [responseObject objectForKey:@"data"];
        NSArray *arr = [Dict objectForKey:@"iData"];
        for (NSDictionary *dict in arr) {
            FriendDanChatModel *Model =[[FriendDanChatModel alloc]init];
            [Model setDic:dict];
            [_dataTwoArray addObject:Model];
        }
        [secondView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createThreeData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId} url:UrL_FriendQuery success:^(id responseObject) {
        [_dataThreeArray removeAllObjects];
        NSLog(@"课程咨询%@",responseObject);
        NSDictionary *Dict = [responseObject objectForKey:@"data"];
        NSArray *arr = [Dict objectForKey:@"iData"];
        for (NSDictionary *dict in arr) {
            FriendDanChatModel *Model =[[FriendDanChatModel alloc]init];
            [Model setDic:dict];
            [_dataThreeArray addObject:Model];
        }
        NSLog(@"默认%ld",(unsigned long)_dataThreeArray.count);
        [threeView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)initMainScrollView{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,104, kScreenWidth, kScreenHeight -104-44)];
    CGFloat width = _mainScrollView.frame.size.width;
    CGFloat height = _mainScrollView.frame.size.height;
    _mainScrollView.bounces = NO;
    _mainScrollView.scrollEnabled = NO;
    _mainScrollView.delegate = self;
    
    firstView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,width,height) style:UITableViewStyleGrouped];
    firstView.tag = 10;
    firstView.delegate = self;
    firstView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    firstView.separatorStyle = UITableViewCellSeparatorStyleNone;
    firstView.showsVerticalScrollIndicator=NO;

    secondView = [[UITableView alloc]initWithFrame:CGRectMake(width, 0,width,height) style:UITableViewStyleGrouped];
    secondView.tag = 11;
    secondView.delegate = self;
    secondView.dataSource = self;
    secondView.separatorStyle = UITableViewCellSeparatorStyleNone;
    secondView.showsVerticalScrollIndicator=NO;
    
    threeView = [[UITableView alloc]initWithFrame:CGRectMake(width*2, 0,width,height) style:UITableViewStyleGrouped];
    threeView.tag = 12;
    threeView.delegate = self;
    threeView.dataSource = self;
    threeView.separatorStyle = UITableViewCellSeparatorStyleNone;
    threeView.showsVerticalScrollIndicator=NO;
 
    [_mainScrollView addSubview:firstView];
    [_mainScrollView addSubview:secondView];
    [_mainScrollView addSubview:threeView];
    
    _mainScrollView.contentSize = CGSizeMake(width*3, 0);
    _mainScrollView.pagingEnabled = YES;
    
    [self.view addSubview:_mainScrollView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 10 || tableView.tag == 11 || tableView.tag == 12) {
        return 1;
    }
    return 1;
}

//-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
//{
//    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
//    conversationVC.conversationType =model.conversationType;
//    conversationVC.targetId = model.targetId;
////    conversationVC.userName =model.conversationTitle;
//    conversationVC.title = model.conversationTitle;
//    [self.navigationController pushViewController:conversationVC animated:YES];
//    
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 10){
        SecondModel *Model = _dataArray[indexPath.section];
        ChatWithFriendVc *chat = [[ChatWithFriendVc alloc]init];
        chat.conversationType = ConversationType_GROUP;
        chat.targetId = Model.SecondId;//群聊对方ID
        chat.QuTitle = @"Qun";
        chat.NavTitleStr = Model.SecondName;
        chat.GroupId = Model.SecondId;
        [self.navigationController pushViewController:chat animated:YES];
    }else if (tableView.tag == 11) {
        FriendDanChatModel *Model = _dataTwoArray[indexPath.section];
        ChatWithFriendVc *chat = [[ChatWithFriendVc alloc]init];
        chat.conversationType = ConversationType_PRIVATE;
        chat.targetId = Model.FriendDanChatId; //Manager.UUserId;//[defaults objectForKey:@"UserId"];//Model.FriendDanChatId;//单聊对方ID
        chat.UserInfoId = Model.FriendDanChatId;
        chat.QuTitle = @"Dan";
        chat.NavTitleStr = Model.FriendDanChatNickName;
        [self.navigationController pushViewController:chat animated:YES];
    }else if (tableView.tag == 12) {
        FriendDanChatModel *Model = _dataThreeArray[indexPath.section];
        ChatWithFriendVc *chat = [[ChatWithFriendVc alloc]init];
        chat.conversationType = ConversationType_PRIVATE;
        chat.targetId = Model.FriendDanChatId; //Manager.UUserId;//[defaults objectForKey:@"UserId"];//Model.FriendDanChatId;//单聊对方ID
        chat.UserInfoId = Model.FriendDanChatId;
        chat.QuTitle = @"Dan";
        chat.NavTitleStr = Model.FriendDanChatNickName;
        [self.navigationController pushViewController:chat animated:YES];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10) {
        return 80;
    }else if (tableView.tag == 11){
        return 80;
    }else if (tableView.tag == 12){
        return 80;
    }
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 10) {
        return _dataArray.count;
    }else if (tableView.tag == 11){
        return _dataTwoArray.count;
    }else if (tableView.tag == 12){
        return _dataThreeArray.count;
    }
    return 1;
}

//-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
//{
//    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
//    conversationVC.conversationType =model.conversationType;
//    conversationVC.targetId = model.targetId;
//    conversationVC.title = model.conversationTitle;
//    [self.navigationController pushViewController:conversationVC animated:YES];
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView.tag == 10) {
        
        SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Ck"];
        if (!cell) {
            cell = [[SecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CK"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        SecondModel *Model = _dataArray[indexPath.section];
        [cell configWith:Model];
        return cell;
    }else if (tableView.tag == 11){
    
        FriendDanChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Jack"];
        if (!cell) {
            cell = [[FriendDanChatCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Jack"];
        }
        FriendDanChatModel *Model = _dataTwoArray[indexPath.section];
        [cell configWith:Model];
        return cell;
    }
    
    FriendDanChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ObjectZX"];
    if (!cell) {
        cell = [[FriendDanChatCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ObjectZX"];
    }
    FriendDanChatModel *Model = _dataThreeArray[indexPath.section];
    [cell configWith:Model];
    return cell;
}

-(void)settopview{
    
    _topView=[[[NSBundle mainBundle]loadNibNamed:@"LHSJSNeedTop" owner:nil options:nil]firstObject];
    _topView.frame=CGRectMake(0, 64, kScreenWidth,40);
    priorY = -64;
    [_topView addOneAction:@selector(OneAction:) twoAction:@selector(TwoAction:)
                                                 threeAction:@selector(ThreeAction:)
                                                 target:self];
    
    [self.view addSubview:_topView];
}
//群组
-(void)OneAction:(id)sender{
    [_topView setCurrentPosition:0];
    [self createData];
    _mainScrollView.contentOffset = CGPointMake(0, 0);
}
//好友
-(void)TwoAction:(id)sender{
    [_topView setCurrentPosition:1];
    [self createTwoData];
    _mainScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    
}
//课程咨询
-(void)ThreeAction:(id)sender{
    [_topView setCurrentPosition:2];
    [self createThreeData];
    _mainScrollView.contentOffset = CGPointMake(kScreenWidth*2, 0);
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 45)/2, 10, 70, 30)];
    label.text = @"交流圈";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 70, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setTitle:@"创建群组" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BtnQunClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 30, 30);
    [button2 setImage:[UIImage imageNamed:@"系统消息@2x.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(BtnSecClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
    
}

-(void)BtnQunClick:(UIButton *)btn
{
    //NSLog(@"1");
    CreateGroupVC *group = [[CreateGroupVC alloc]init];
    [self.navigationController pushViewController:group animated:YES];
}

-(void)BtnSecClick:(UIButton *)btn
{
    //NSLog(@"2");
    FriendsNoticeVC *notice = [[FriendsNoticeVC alloc]init];
    [self.navigationController pushViewController:notice animated:YES];
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
