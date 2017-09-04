//
//  CourseOrdersVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "CourseOrdersVC.h"
#import "AppDelegate.h"
#import "CourseOrdersCell.h"
#import "CourseOrdersModel.h"
#import "ViewReasonVC.h"
#import "ScanViewController.h"

@interface CourseOrdersVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView * _mainScrollView;
    UIView       * _topView;
    UITableView  * _firstView;
    UITableView  * _secondView;
    UITableView  * _thirdView;
    NSMutableArray *_dataOneArray;
    NSMutableArray *_dataTwoArray;
    NSMutableArray *_dataThreeArray;
    NSInteger       _page;
    BOOL            _isPulling;
}
@property(nonatomic, strong)UIButton *btnSelected;
@end
@implementation CourseOrdersVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    _dataOneArray = [NSMutableArray array];
    FbwManager *Manager = [FbwManager shareManager];
    if (Manager.PullPage == 3) {
        _page = 0;
        Manager.PullPage = 0;
    }
    [self createDataOne];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    
    _dataTwoArray = [NSMutableArray array];
    _dataThreeArray = [NSMutableArray array];
    [self createNav];
    
    [self createTopView];
    [self initMainScrollView];
    [self form];
    [self updown];
    self.view.backgroundColor = kAppWhiteColor;
}

//下拉刷新
- (void)form {
    __weak CourseOrdersVC *weakSelf = self;
    if (_firstView) {
        _firstView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 0;
            _isPulling = YES;
            [weakSelf createDataOne];
        }];
    }
    if (_secondView){
        _secondView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 0;
            _isPulling = YES;
            [weakSelf createDataTwo];
        }];
    }
    if(_thirdView){
        _thirdView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 0;
            _isPulling = YES;
            [weakSelf createDataThree];
        }];
    }
    
}

//上拉加载
- (void)updown {
    __weak CourseOrdersVC *weakSelf = self;
    if (_firstView) {
        _firstView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
            _page ++;
            _isPulling = NO;
            if (_page >= 50) {
                [_firstView.mj_footer endRefreshing];
                return ;
            } else {
                [weakSelf createDataOne];
            }
        }];
    }
    if (_secondView){
        _secondView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
            _page ++;
            _isPulling = NO;
            if (_page >= 50) {
                [_secondView.mj_footer endRefreshing];
                return ;
            } else {
                [weakSelf createDataTwo];
            }
        }];
    }
    if(_thirdView){
        _thirdView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
            _page ++;
            _isPulling = NO;
            if (_page >= 50) {
                [_thirdView.mj_footer endRefreshing];
                return ;
            } else {
                [weakSelf createDataThree];
            }
        }];
    }
}

-(void)createDataOne
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"status":@"20",@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_CourseOrder success:^(id responseObject) {
        NSLog(@"课程%@",responseObject);
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        [_firstView.mj_footer endRefreshing];
        [_firstView.mj_header endRefreshing];
        if (_isPulling ) {
            [_dataOneArray removeAllObjects];
        }
        NSArray *Arr = [RootDic objectForKey:@"iData"];
//        [_dataOneArray removeAllObjects];
        for (NSDictionary *dic in Arr) {
            CourseOrdersModel *Model = [[CourseOrdersModel alloc]init];
            [Model setDic:dic];
            [_dataOneArray addObject:Model];
        }
//        if (_isPulling) {
//            [_firstView.mj_header endRefreshing];
//        }else{
//            [_firstView.mj_footer endRefreshing];
//        }
        [_firstView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createDataTwo
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"status":@"30",@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_CourseOrder success:^(id responseObject) {
        [_secondView.mj_footer endRefreshing];
        [_secondView.mj_header endRefreshing];
        if (_isPulling) {
            [_dataTwoArray removeAllObjects];
        }
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
//        [_dataTwoArray removeAllObjects];
        for (NSDictionary *dic in Arr) {
            CourseOrdersModel *Model = [[CourseOrdersModel alloc]init];
            [Model setDic:dic];
            [_dataTwoArray addObject:Model];
        }
//        if (_isPulling) {
//            [_secondView.mj_header endRefreshing];
//        }else{
//            [_secondView.mj_footer endRefreshing];
//        }
        [_secondView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createDataThree
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"status":@"1000",@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_CourseOrder success:^(id responseObject) {
        [_thirdView.mj_footer endRefreshing];
        [_thirdView.mj_header endRefreshing];
        if (_isPulling) {
            [_dataThreeArray removeAllObjects];
        }
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
//        [_dataThreeArray removeAllObjects];
        for (NSDictionary *dic in Arr) {
            CourseOrdersModel *Model = [[CourseOrdersModel alloc]init];
            [Model setDic:dic];
            [_dataThreeArray addObject:Model];
        }
//        if (_isPulling) {
//            [_thirdView.mj_header endRefreshing];
//        }else{
//            [_thirdView.mj_footer endRefreshing];
//        }
        [_thirdView reloadData];
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
    
    _thirdView = [[UITableView alloc]initWithFrame:CGRectMake(2*width, 0,width,height) style:UITableViewStyleGrouped];
    _thirdView.tag = 12;
    _thirdView.delegate = self;
    _thirdView.dataSource = self;
    _thirdView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _thirdView.showsVerticalScrollIndicator=NO;

    _mainScrollView.contentSize = CGSizeMake(width*3, 0);
    _mainScrollView.pagingEnabled = YES;
    
    [_mainScrollView addSubview:_firstView];
    [_mainScrollView addSubview:_secondView];
    [_mainScrollView addSubview:_thirdView];
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
    }else if (tableView.tag == 11){
        return _dataTwoArray.count;
    }
    return _dataThreeArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10 || tableView.tag == 12) {
        return 140;
    }
    return 95;
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
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Course"];
    if (!cell) {
        cell = [[CourseOrdersCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Course"];
    }
    if (tableView.tag == 10) {
            CourseOrdersModel *Model = _dataOneArray[indexPath.section];
            [cell configWithModel:Model];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            startBtn.layer.borderColor = kAppBlackColor.CGColor;
            startBtn.layer.borderWidth = 1;
            startBtn.tag = indexPath.section;
            [startBtn setTitle:@"开始课程" forState:UIControlStateNormal];
            startBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [startBtn addTarget:self action:@selector(StartClass:) forControlEvents:UIControlEventTouchUpInside];
            [startBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
            startBtn.frame = CGRectMake(kScreenWidth - 90, 105, 80, 30);
            [cell.contentView addSubview:startBtn];
        });
            return cell;
    }else if(tableView.tag == 12){
            CourseOrdersModel *Model = _dataThreeArray[indexPath.section];
            [cell configWithModel:Model];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            startBtn.layer.borderColor = kAppBlackColor.CGColor;
            startBtn.layer.borderWidth = 1;
            startBtn.tag = indexPath.section;
            [startBtn setTitle:@"查看原因" forState:UIControlStateNormal];
            startBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [startBtn addTarget:self action:@selector(ViewReason:) forControlEvents:UIControlEventTouchUpInside];
            [startBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
            startBtn.frame = CGRectMake(kScreenWidth - 90, 105, 80, 30);
            [cell.contentView addSubview:startBtn];
        });
        return cell;
    }else if (tableView.tag == 11){
            CourseOrdersModel *Model = _dataTwoArray[indexPath.section];
            [cell configWithModel:Model];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//查看原因
-(void)ViewReason:(UIButton *)BnY
{
    CourseOrdersModel *Model = _dataThreeArray[BnY.tag];
    ViewReasonVC *reason = [[ViewReasonVC alloc]init];
    reason.RefundReason = Model.CourseOrderContactRefundReason;
    reason.CloseTime = Model.CourseOrderCreateTime;
    [self.navigationController pushViewController:reason animated:YES];
}

-(void)StartClass:(UIButton *)Sta
{
    NSLog(@"开始课程%ld",(long)Sta.tag);
//    CourseOrdersModel *Model = _dataOneArray[Sta.tag];
    ScanViewController *scan = [[ScanViewController alloc]init];
    
    [self.navigationController pushViewController:scan animated:YES];
}

-(void)createTopView
{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,40)];
    _topView.backgroundColor = kAppWhiteColor;
    NSArray *arr = @[@"未开始",@"已完成",@"已关闭"];
    for (int i=0; i<3; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i+i*(kScreenWidth-2)/3, 0, (kScreenWidth-2)/3, 40);
        button.tag = 10+i;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:kAppBlackColor forState:UIControlStateNormal];
        [button setTitleColor:kAppBlueColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(BtnClose:) forControlEvents:UIControlEventTouchUpInside];
        if (i < 2) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-2)/3 + i*(kScreenWidth-2)/3, 0, 1, 38)];
            label.backgroundColor = kAppLightGrayColor;
            
            [_topView addSubview:label];
        }
         button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        if (button.tag == 10) {
            button.selected = YES;
            self.btnSelected = button;
        }
        [_topView addSubview:button];
    }
    [self.view addSubview:_topView];
    
}
-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"我的订单";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(Blick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
}
//上下架
-(void)BtnClose:(UIButton *)btnSJ
{
    self.btnSelected.selected = NO;
    
    if (btnSJ.tag == 10) {
        btnSJ.selected = YES;
        [_dataOneArray removeAllObjects];
        _page = 0;
        [self createDataOne];
        _mainScrollView.contentOffset = CGPointMake(0,0);
    }else if(btnSJ.tag == 11)
    {
        [_dataTwoArray removeAllObjects];
        _page = 0;
        [self createDataTwo];
        btnSJ.selected = YES;
        _mainScrollView.contentOffset = CGPointMake(kScreenWidth,0);
    }else{
        [_dataThreeArray removeAllObjects];
        _page = 0;
        [self createDataThree];
        btnSJ.selected = YES;
        _mainScrollView.contentOffset = CGPointMake(2*kScreenWidth,0);
    }
    self.btnSelected = btnSJ;
}

-(void)Btn2Click:(UIButton *)btn
{
    NSLog(@"2");
}

-(void)Blick:(UIButton *)Bbtn
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
