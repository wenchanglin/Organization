//
//  TeachingAchievement.m
//  ShangKOrganization
//
//  Created by apple on 16/9/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "TeachingAchievement.h"
#import "AppDelegate.h"
#import "TeachingAchienementCell.h"
#import "AddTeachingAchVC.h"
#import "EveryAchievementVC.h"
#import "TeachingAchienementModel.h"
#import "ArrowView.h"
#import "FixTeachVC.h"
@interface TeachingAchievement ()<UITableViewDelegate,UITableViewDataSource>
{
    ArrowView      * _arrowView;
    NSInteger       _page;
    BOOL            _isPulling;
}
@end

@implementation TeachingAchievement

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
    __weak TeachingAchievement *weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        _isPulling = YES;
        [weakSelf createData];
    }];
}
//上拉加载
- (void)updown {
    __weak TeachingAchievement *weakSelf = self;
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
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_AddTeachAchienement success:^(id responseObject) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        if (_isPulling || Manager.IsListPulling == 3) {
            [_dataArray removeAllObjects];
            Manager.IsListPulling = 0;
        }else{
            NSLog(@"上拉咯");
        }
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dic in arr) {
            TeachingAchienementModel *Model = [[TeachingAchienementModel alloc]init];
            [Model setWithDic:dic];
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
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 64, kScreenWidth-20, kScreenHeight-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight-80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TeachingAchienementModel *Model = _dataArray[indexPath.section];
    EveryAchievementVC *Achieve = [[EveryAchievementVC alloc]init];
    Achieve.AchienementId = Model.AchienementId;
    [self.navigationController pushViewController:Achieve animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeachingAchienementCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Achieve"];
    if (!cell) {
        
        cell = [[TeachingAchienementCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Achieve"];
        }
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.layer.borderColor = kAppLineColor.CGColor;
        deleteBtn.layer.borderWidth = 1;
        deleteBtn.tag = indexPath.section;
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [deleteBtn addTarget:self action:@selector(DeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        [deleteBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
        deleteBtn.frame = CGRectMake(kScreenWidth - 160, kScreenHeight-120, 60, 30);
        UIButton *modifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [modifyBtn setTitle:@"修改" forState:UIControlStateNormal];
        modifyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [modifyBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
        modifyBtn.layer.borderColor = kAppLineColor.CGColor;
        modifyBtn.layer.borderWidth = 1;
        modifyBtn.tag = indexPath.section;
        [modifyBtn addTarget:self action:@selector(FixBtn:) forControlEvents:UIControlEventTouchUpInside];
        modifyBtn.frame = CGRectMake(kScreenWidth - 90, kScreenHeight-120, 60, 30);
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:deleteBtn];
        [cell.contentView addSubview:modifyBtn];
    
    TeachingAchienementModel *Model = _dataArray[indexPath.section];
    [cell configWithModel:Model];
    return cell;
}

-(void)DeleteBtn:(UIButton *)DeBtn
{
//    NSLog(@"你妹删除错了%ld",DeBtn.tag);
    TeachingAchienementModel *Model = _dataArray[DeBtn.tag];
    _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
    [_arrowView setBackgroundColor:[UIColor clearColor]];
    [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定要删除此成果吗？"];
        __weak typeof(self) weakSelf = self;
     [_arrowView setSelectBlock:^(UIButton *button){
            if (button.tag == 10) {
                NSLog(@"我是不删除%ld",(long)button.tag);
            }else if (button.tag == 11){
                NSLog(@"我是删除%ld",(long)button.tag);
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkResultId":Model.AchienementId} url:UrL_DeleteAchievent success:^(id responseObject) {
//                    [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.dataArray removeObject:weakSelf.dataArray[DeBtn.tag]];
                        
                        [weakSelf.tableView reloadData];
                        
                    });
                } failure:^(NSError *error) {
                }];
            }
        }];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
        [_arrowView showArrowView:YES];
}

-(void)FixBtn:(UIButton *)FixBtn
{
//    NSLog(@"看看修改几%ld",FixBtn.tag);
    TeachingAchienementModel *Model = _dataArray[FixBtn.tag];
    _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
    [_arrowView setBackgroundColor:[UIColor clearColor]];
    [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定要修改此成果吗？"];
    __weak typeof(self) weakSelf = self;
    [_arrowView setSelectBlock:^(UIButton *button){
        if (button.tag == 10) {
        }else if (button.tag == 11){
            FixTeachVC *fix = [[FixTeachVC alloc]init];
            fix.DataArray = Model.ModelArray;
            fix.FixTeachId = Model.AchienementId;
            fix.FixTeachName = Model.AchienementName;
            fix.FixTeachHeadPhoto = Model.AchienementHeadPhoto;
            [weakSelf.navigationController pushViewController:fix animated:YES];
        }
    }];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
    [_arrowView showArrowView:YES];
}

-(void)createNav
{
    
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"教学成果";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 40, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button2 setTitle:@"添加" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(AddAchieveClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
}

-(void)BaClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)AddAchieveClick:(UIButton *)btn1
{
    AddTeachingAchVC *AddTeach = [[AddTeachingAchVC alloc]init];
    [self.navigationController pushViewController:AddTeach animated:YES];
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
