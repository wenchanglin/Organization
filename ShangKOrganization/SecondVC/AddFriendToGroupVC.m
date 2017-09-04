//
//  AddFriendToGroupVC.m
//  ShangKOrganization
//
//  Created by apple on 17/1/9.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import "AddFriendToGroupVC.h"
#import "FriendDanChatModel.h"
#import "FriendDanChatCell.h"
@interface AddFriendToGroupVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView    *_tableView;
    NSMutableArray *_dataArray;
}

@end

@implementation AddFriendToGroupVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self createNav];
    [self createData];
    [self createTableView];
    self.view.backgroundColor = kAppWhiteColor;
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
    return 80;
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
    static NSString *CellIdentifier = @"Jacked";
    FriendDanChatCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[FriendDanChatCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        UIButton *AddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        AddBtn.layer.borderColor = kAppLineColor.CGColor;
        AddBtn.layer.borderWidth = 1;
        AddBtn.tag = indexPath.section;
        [AddBtn setTitle:@"添加" forState:UIControlStateNormal];
        AddBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [AddBtn addTarget:self action:@selector(AddFriendBtn:) forControlEvents:UIControlEventTouchUpInside];
        [AddBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
        AddBtn.frame = CGRectMake(kScreenWidth - 90, 30, 80, 20);
        [cell.contentView addSubview:AddBtn];
    });
    FriendDanChatModel *Model = _dataArray[indexPath.section];
    cell.FriendDanChatSecondTimeLabel.hidden = YES;
    cell.FriendDanChatSecondName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.FriendDanChatImageSecond.frame)+10, 30, kScreenWidth/2, 20)];
    cell.FriendDanChatSecondName.text = Model.FriendDanChatNickName;
    [cell.contentView addSubview:cell.FriendDanChatSecondName];
    [cell configWith:Model];
    return cell;
}

-(void)AddFriendBtn:(UIButton *)Bt
{
    
    FriendDanChatModel *Model = _dataArray[Bt.tag];
    FbwManager *Manager = [FbwManager shareManager];
    __weak typeof(self) weakSelf = self;
    NSArray *arr = @[@{@"id":Model.FriendDanChatId}];
    NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"添加好友进群%@",jsonStr);
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"groupId":self.GroupID,@"userIdListStr":jsonStr} url:UrL_AddStudent success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        Manager.isAdmintor = NO;
        //        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
    }];
    
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId,@"type":@1} url:UrL_FriendQuery success:^(id responseObject) {
        NSLog(@"看看%@",responseObject);
        [_dataArray removeAllObjects];
        //        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *Dict = [responseObject objectForKey:@"data"];
        NSArray *arr = [Dict objectForKey:@"iData"];
        for (NSDictionary *dict in arr) {
            FriendDanChatModel *Model =[[FriendDanChatModel alloc]init];
            [Model setDic:dict];
            [_dataArray addObject:Model];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2, 10, 100, 30)];
    label.text = @"好友列表";
    label.textAlignment = NSTextAlignmentCenter;
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
