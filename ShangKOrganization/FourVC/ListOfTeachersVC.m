//
//  ListOfTeachersVC.m
//  ShangKOrganization
//
//  Created by apple on 16/10/17.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ListOfTeachersVC.h"
#import "ListOfTeachersModel.h"
#import "ListOfTeachersCell.h"
#import "FbwManager.h"

@interface ListOfTeachersVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView    *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation ListOfTeachersVC

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
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dic in arr) {
            ListOfTeachersModel *Model =[[ListOfTeachersModel alloc]init];
            NSDictionary *UserInfo = [dic objectForKey:@"userInfoBase"];
            [Model setDic:UserInfo];
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
    return 90;
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
    ListOfTeachersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Chat"];
    if (!cell) {
        
        cell = [[ListOfTeachersCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Chat"];
    }
    ListOfTeachersModel *Model = _dataArray[indexPath.section];
   
    dispatch_async(dispatch_get_main_queue(), ^{
        UIButton *Btn       = [UIButton buttonWithType:UIButtonTypeCustom];
        Btn.frame           = CGRectMake(kScreenWidth-90, 30, 80, 30);
        Btn.backgroundColor = kAppBlueColor;
        [Btn setTitle:@"选择TA" forState:UIControlStateNormal];
        [Btn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
        Btn.tag             = indexPath.section;
        Btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [Btn addTarget:self action:@selector(Choose:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:Btn];
    });
    [cell configWithModel:Model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)Choose:(UIButton *)YBtn
{
    FbwManager *Manager = [FbwManager shareManager];
    Manager.TeacherArray = [NSMutableArray array];
    ListOfTeachersModel *Model = _dataArray[YBtn.tag];
    [Manager.TeacherArray addObject:Model];
    NSLog(@"要过来了%@",Manager.TeacherArray);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"教师列表";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaBtnck:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)BaBtnck:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
