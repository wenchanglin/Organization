//
//  OrganizationActivityVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "OrganizationActivityVC.h"
#import "AppDelegate.h"
#import "OrganizationActivityCell.h"
#import "AddActVC.h"
#import "ArrowView.h"
#import "EventDetailsVC.h"
#import "OrganizationActivityModel.h"
@interface OrganizationActivityVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView * _mainScrollView;
    UIView       * _topView;
    NSInteger      _pageIndex;
    BOOL           btnIsLight;
    NSString       *_ActivityID;
    ArrowView      * _arrowView;
    NSInteger       _page;
    BOOL            _isPulling;
//    int          Status;
}
@property(nonatomic, strong)UIButton *btnSelected;
@end

@implementation OrganizationActivityVC

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
    _dataOneArray = [NSMutableArray array];
    _dataTwoArray = [NSMutableArray array];
    [self createNav];
    [self createTopView];
    
    [self initMainScrollView];
    [self form];
    [self updown];
    self.view.backgroundColor = kAppWhiteColor;
}

//下拉刷新
- (void)form {
    __weak OrganizationActivityVC *weakSelf = self;
    if (_firstView) {
        _firstView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 0;
            _isPulling = YES;
            [weakSelf createData];
        }];
    }
    if (_secondView) {
        _secondView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 0;
            _isPulling = YES;
            [weakSelf OverCreateData];
        }];
    }
    
}
//上拉加载
- (void)updown {
    __weak OrganizationActivityVC *weakSelf = self;
    if (_firstView) {
        _firstView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
            _page ++;
            _isPulling = NO;
            if (_page >= 50) {
                [_firstView.mj_footer endRefreshing];
                return ;
            } else {
                [weakSelf createData];
            }
        }];
    }
    if (_secondView) {
        _secondView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
            _page ++;
            _isPulling = NO;
            if (_page >= 50) {
                [_secondView.mj_footer endRefreshing];
                return ;
            } else {
                [weakSelf OverCreateData];
            }
        }];
    }
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];//3109081a-14fc-41da-9408-90434490a560
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"status":@1,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_AcTivityManager success:^(id responseObject) {
        NSLog(@"活动列表%@",responseObject);
        if (_isPulling || Manager.IsListPulling == 3) {
            [_dataOneArray removeAllObjects];
            Manager.IsListPulling = 0;
        }
        NSDictionary *Dict = [responseObject objectForKey:@"data"];
        NSArray *arr       = [Dict objectForKey:@"iData"];
        for (NSDictionary *dic in arr) {
            OrganizationActivityModel *Model= [[OrganizationActivityModel alloc]init];
            [Model setDic:dic];
            if ([[dic objectForKey:@"shareCommon"] isKindOfClass:[NSNull class]]) {
                NSDictionary *DicT = [dic objectForKey:@"shareCommon"];
                [Model setTDic:DicT];
            }else{
            NSDictionary *DicT = [dic objectForKey:@"shareCommon"];
            [Model setTDic:DicT];
            }
            [_dataOneArray addObject:Model];
        }
        if (_isPulling) {
            [_firstView.mj_header endRefreshing];
        }else{
            [_firstView.mj_footer endRefreshing];
        }
        [_firstView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)OverCreateData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"status":@2,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_AcTivityManager success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
        if (_isPulling) {
            [_dataTwoArray removeAllObjects];
        }
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *Dict = [responseObject objectForKey:@"data"];
        NSArray *arr       = [Dict objectForKey:@"iData"];
        for (NSDictionary *dic in arr) {
            OrganizationActivityModel *Model= [[OrganizationActivityModel alloc]init];
            [Model setDic:dic];
            NSDictionary *DicT = [dic objectForKey:@"shareCommon"];
            [Model setTDic:DicT];
            [_dataTwoArray addObject:Model];
        }
        if (_isPulling) {
            [_secondView.mj_header endRefreshing];
        }else{
            [_secondView.mj_footer endRefreshing];
        }
//        NSLog(@"%ld",_dataTwoArray.count);
        [_secondView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)initMainScrollView
{
    
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_topView.frame), kScreenWidth, kScreenHeight-CGRectGetMaxY(_topView.frame))];
    CGFloat width = _mainScrollView.frame.size.width;
    CGFloat height = _mainScrollView.frame.size.height;
    _mainScrollView.scrollEnabled = NO;
    _mainScrollView.delegate = self;
    
    _firstView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,width,height) style:UITableViewStyleGrouped];
    _firstView.tag = 10;
    _firstView.delegate = self;
    _firstView.dataSource = self;
    _firstView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _firstView.showsVerticalScrollIndicator=NO;
    
    _secondView = [[UITableView alloc]initWithFrame:CGRectMake(width, 0,width,height) style:UITableViewStyleGrouped];
    _secondView.tag = 11;
    _secondView.delegate = self;
    _secondView.dataSource = self;
    _secondView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _secondView.showsVerticalScrollIndicator=NO;
    _mainScrollView.contentSize = CGSizeMake(width*2, 0);
    _mainScrollView.pagingEnabled = YES;
    
    [_mainScrollView addSubview:_firstView];
    [_mainScrollView addSubview:_secondView];
    [self.view addSubview:_mainScrollView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 10) {
        return _dataOneArray.count;
    }
    return _dataTwoArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 10) {
       OrganizationActivityModel *Model = _dataOneArray[indexPath.section];
       EventDetailsVC *Detail = [[EventDetailsVC alloc]init];
       Detail.ActivityID = Model.ActivityId;
       [self.navigationController pushViewController:Detail animated:YES];
    }else{
       OrganizationActivityModel *Model = _dataTwoArray[indexPath.section];
       EventDetailsVC *Detail = [[EventDetailsVC alloc]init];
       Detail.ActivityID = Model.ActivityId;
       [self.navigationController pushViewController:Detail animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Oranization";
    OrganizationActivityCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OrganizationActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (tableView.tag == 10) {
        dispatch_async(dispatch_get_main_queue(), ^{
        UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 120, 95, 100, 30)];
        button.backgroundColor = kAppBlueColor;
        button.tag = indexPath.section;
        OrganizationActivityModel *Model = _dataOneArray[indexPath.section];
        [button setTitle:@"结束活动" forState:UIControlStateNormal];
        [button setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
            [button addTarget:self action:@selector(OverActivity:) forControlEvents:UIControlEventTouchUpInside];
        [cell configWithModel:Model];
//        if (Model.ActivityPhoto == nil || [Model.ActivityPhoto isKindOfClass:[NSNull class]]) {
//                cell.headPic.image = [UIImage imageNamed:@"哭脸.png"];
//        }else{
//        [cell.headPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.readerday.com/cover/%@",Model.ActivityPhoto]] placeholderImage:nil];
//        }
        [cell.contentView addSubview:button];
        });
        return cell;
    }else{
    OrganizationActivityModel *Model = _dataTwoArray[indexPath.section];
    dispatch_async(dispatch_get_main_queue(), ^{
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 120, 95, 100, 30)];
    button.backgroundColor = kAppBlueColor;
    button.tag = indexPath.section;
    [button setTitle:@"删除活动" forState:UIControlStateNormal];
    [button setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(DeleActivity:) forControlEvents:UIControlEventTouchUpInside];
    [cell.headPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.readerday.com/cover/%@",Model.ActivityPhoto]] placeholderImage:nil];
    _ActivityID = Model.ActivityId;
    [cell configWithModel:Model];
    [cell.contentView addSubview:button];
    });
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    }
}

-(void)OverActivity:(UIButton *)Tbn
{
//    NSLog(@"结束活动几:%ld",Tbn.tag);
    OrganizationActivityModel *Model = _dataOneArray[Tbn.tag];
    _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
    [_arrowView setBackgroundColor:[UIColor clearColor]];
    [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定要结束活动吗？"];
    __weak typeof(self) weakSelf = self;
    [_arrowView setSelectBlock:^(UIButton *button){
        if (button.tag == 10) {
        }else if (button.tag == 11){
            NSLog(@"我是结束%ld",(long)button.tag);
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"activityId":Model.ActivityId} url:UrL_OverActivity success:^(id responseObject) {
//                [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.dataOneArray removeObject:weakSelf.dataOneArray[Tbn.tag]];
                    [weakSelf.firstView reloadData];
                });
            } failure:^(NSError *error) {
            }];
        }
    }];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
    [_arrowView showArrowView:YES];
}

-(void)DeleActivity:(UIButton *)Det
{
    OrganizationActivityModel *Model = _dataTwoArray[Det.tag];
    _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
    [_arrowView setBackgroundColor:[UIColor clearColor]];
    [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定要删除活动吗？"];
    __weak typeof(self) weakSelf = self;
    [_arrowView setSelectBlock:^(UIButton *button){
        if (button.tag == 10) {
        }else if (button.tag == 11){
            NSLog(@"我是删除%ld",(long)button.tag);
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"activityId":Model.ActivityId} url:UrL_deleteActivity success:^(id responseObject) {
//                [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.dataTwoArray removeObject:weakSelf.dataTwoArray[Det.tag]];
                    [weakSelf.secondView reloadData];
                });
            } failure:^(NSError *error) {
            }];
        }
    }];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
    [_arrowView showArrowView:YES];
}

-(void)createTopView
{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,40)];
    _topView.backgroundColor = kAppWhiteColor;
    UIButton *BtnNow = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 40)];
    [BtnNow setTitle:@"进行中" forState:UIControlStateNormal];
    BtnNow.tag = 11;
    [BtnNow setTitleColor:kAppBlueColor forState:UIControlStateSelected];
    [BtnNow addTarget:self action:@selector(BtnSJ:) forControlEvents:UIControlEventTouchUpInside];
    [BtnNow setTitleColor:kAppBlackColor forState:UIControlStateNormal];
    BtnNow.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    UIButton *BtnOver = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2,0, kScreenWidth/2, 40)];
    [BtnOver setTitle:@"已结束" forState:UIControlStateNormal];
    [BtnOver addTarget:self action:@selector(BtnSJ:) forControlEvents:UIControlEventTouchUpInside];
    BtnOver.tag = 12;
    [BtnOver setTitleColor:kAppBlueColor forState:UIControlStateSelected];
    [BtnOver setTitleColor:kAppBlackColor forState:UIControlStateNormal];
    BtnOver.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, 0, 1, 38)];
    label.backgroundColor = kAppLightGrayColor;
    
    BtnNow.selected = YES;
    self.btnSelected = BtnNow;
    
    
    [_topView addSubview:BtnNow];
    [_topView addSubview:BtnOver];
    [_topView addSubview:label];
    [self.view addSubview:_topView];
    
}

//上下架
-(void)BtnSJ:(UIButton *)btnSJ
{
    self.btnSelected.selected = NO;
    
    if (btnSJ.tag == 11) {
        btnSJ.selected = YES;
        [_dataOneArray removeAllObjects];
        _page = 0;
        [self createData];
        _mainScrollView.contentOffset = CGPointMake(0,0);
    }else
    {
        btnSJ.selected = YES;
        [_dataTwoArray removeAllObjects];
        _page = 0;
        [self OverCreateData];
        _mainScrollView.contentOffset = CGPointMake(kScreenWidth,0);
    }
    self.btnSelected = btnSJ;
    //    self.selectedIndex = btnSJ.tag - 1;
}

-(void)Btn2Click:(UIButton *)btn
{
    NSLog(@"2");
}


-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"活动管理";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BackClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 40, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button2 setTitle:@"添加" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(AddClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];

}

-(void)BackClick:(UIButton *)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//添加活动
-(void)AddClick:(UIButton *)btn1
{
    AddActVC *activity = [[AddActVC alloc]init];
    [self.navigationController pushViewController:activity animated:YES];
    
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
