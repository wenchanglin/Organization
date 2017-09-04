//
//  FourVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/9.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FourVC.h"
#import "Addobject.h"
#import "AppDelegate.h"
#import "FourCell.h"
#import "ArrowView.h"
#import "EveryLessonVC.h"
#import "FourModel.h"
@interface FourVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView   * _mainScrollView;
    UIView         * _topView;
    BOOL           btnIsLight;
    ArrowView      *_arrowView;
    NSString       *_ActivityID;
    NSArray        *Ar;
    NSInteger       _page;
    BOOL            _isPulling;
}
@property(nonatomic, strong)UIButton *btnSelected;
@end

@implementation FourVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = NO;
    [self createNav];
    _dataOneArray = [NSMutableArray array];
    FbwManager *Manager = [FbwManager shareManager];
    if (Manager.PullPage == 3) {
        _page = 0;
        Manager.PullPage = 0;
    }
    [self createData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataOneArray = [NSMutableArray array];
    _dataTwoArray = [NSMutableArray array];
    [self createTopView];
    [self initMainScrollView];
    [self form];
    [self updown];
    self.view.backgroundColor = kAppWhiteColor;
}

//下拉刷新
- (void)form {
    __weak FourVC *weakSelf = self;
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
            [weakSelf createOverData];
        }];
    }
    
}
//上拉加载
- (void)updown {
    __weak FourVC *weakSelf = self;
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
                [weakSelf createOverData];
            }
        }];
    }
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"status":@1,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_ObjectLieBiao success:^(id responseObject) {
        NSLog(@"课程管理%@",responseObject);
        [_firstView.mj_footer endRefreshing];
        [_firstView.mj_header endRefreshing];
        if (_isPulling || Manager.IsListPulling == 3) {
            [_dataOneArray removeAllObjects];
            Manager.IsListPulling = 0;
        }else{
            NSLog(@"上拉咯");
        }
        NSDictionary *Dict = [responseObject objectForKey:@"data"];
        NSArray *arr       = [Dict objectForKey:@"iData"];
        for (NSDictionary *dic in arr) {
            FourModel *Model= [[FourModel alloc]init];
            [Model setDic:dic];
            if ([[dic objectForKey:@"photoList"] isKindOfClass:[NSNull class]]) {
                
            }else{
              Ar = [dic objectForKey:@"photoList"];
            }
            for (NSDictionary *RooD in Ar) {
                [Model setTDic:RooD];
            }
            [_dataOneArray addObject:Model];
        }
        [_firstView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createOverData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"status":@2,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_ObjectLieBiao success:^(id responseObject) {
        [_secondView.mj_footer endRefreshing];
        [_secondView.mj_header endRefreshing];
        if (_isPulling|| Manager.IsListPulling == 3) {
            [_dataTwoArray removeAllObjects];
            Manager.IsListPulling = 0;
        }else{
            NSLog(@"上拉咯");
        }
        NSDictionary *Dict = [responseObject objectForKey:@"data"];
        NSArray *arr       = [Dict objectForKey:@"iData"];
        for (NSDictionary *dic in arr) {
            FourModel *Model= [[FourModel alloc]init];
            [Model setDic:dic];
            if ([[dic objectForKey:@"photoList"] isKindOfClass:[NSNull class]]) {
                
            }else{
                Ar = [dic objectForKey:@"photoList"];
            }
            for (NSDictionary *RooD in Ar) {
                [Model setTDic:RooD];
            }
            [_dataTwoArray addObject:Model];
        }
        [_secondView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)initMainScrollView
{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_topView.frame), kScreenWidth, kScreenHeight-CGRectGetMaxY(_topView.frame)-44)];
    CGFloat width  = _mainScrollView.frame.size.width;
    CGFloat height = _mainScrollView.frame.size.height;
    _mainScrollView.scrollEnabled = NO;
    _mainScrollView.delegate = self;
    
    _firstView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,width,height) style:UITableViewStyleGrouped];
    _firstView.tag   = 10;
    _firstView.delegate = self;
    _firstView.dataSource = self;
    _firstView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _firstView.showsVerticalScrollIndicator=NO;
    
    _secondView = [[UITableView alloc]initWithFrame:CGRectMake(width, 0,width,height) style:UITableViewStyleGrouped];
    _secondView.tag   = 11;
    _secondView.delegate = self;
    _secondView.dataSource  = self;
    _secondView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _secondView.showsVerticalScrollIndicator=NO;
    _mainScrollView.contentSize = CGSizeMake(width*2, 0);
    _mainScrollView.pagingEnabled = YES;
    
    [_mainScrollView addSubview:_firstView];
    [_mainScrollView addSubview:_secondView];
    [self.view       addSubview:_mainScrollView];
}

#pragma mark------------------------tableview代理----------------------

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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 10) {
        FourModel *Model = _dataOneArray[indexPath.section];
        _ActivityID = Model.FourId;
        EveryLessonVC *Lesson = [[EveryLessonVC alloc]init];
        Lesson.CourseId = _ActivityID;
        [self.navigationController pushViewController:Lesson animated:YES];
    }else if(tableView.tag == 11){
        FourModel *Model = _dataTwoArray[indexPath.section];
        _ActivityID = Model.FourId;
        EveryLessonVC *Lesson = [[EveryLessonVC alloc]init];
        Lesson.CourseId = _ActivityID;
        [self.navigationController pushViewController:Lesson animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Kiding";
    FourCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        cell = [[FourCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (tableView.tag == 10) {
        if (_dataOneArray.count == 0) {
            
        }else{
        FourModel *Model = _dataOneArray[indexPath.section];
        if (Model.FourPayStatus == 10) {
            cell.FourPayStatusLabel.text = @"(未付款)";
        }else{
                
        }
        [cell configWithModel:Model];
        UIButton *startBtn       = [UIButton buttonWithType:UIButtonTypeCustom];
        startBtn.backgroundColor = kAppBlueColor;
        [startBtn setTitle:@"下架课程" forState:UIControlStateNormal];
        startBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [startBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
        startBtn.frame           = CGRectMake(kScreenWidth - 100, 105, 70, 40);
        startBtn.tag             = indexPath.section;
        [startBtn addTarget:self action:@selector(ActionXiaJiaBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:startBtn];
        [cell.contentView addSubview:cell.FourPayStatusLabel];
        }
    }else if (tableView.tag == 11){
        FourModel *Model = _dataTwoArray[indexPath.section];
        if (Model.FourPayStatus == 10) {
            cell.FourPayStatusLabel.text = @"(未付款)";
        }else{
            
        }
        [cell configWithModel:Model];
        NSArray *arr = @[@"删除课程",@"上架课程"];
        for (int i=0; i<2; i++) {
            UIButton *Btn       = [UIButton buttonWithType:UIButtonTypeCustom];
            Btn.frame           = CGRectMake(kScreenWidth - 170+80*i, 105, 70, 40);
            Btn.backgroundColor = kAppBlueColor;
            Btn.tag             = indexPath.section;
            [Btn addTarget:self action:@selector(ActionBtn:) forControlEvents:UIControlEventTouchUpInside];
            [Btn setTitle:arr[i] forState:UIControlStateNormal];
            Btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [Btn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
            [cell.contentView addSubview:Btn];
        }
    }
    [cell.contentView addSubview:cell.FourPayStatusLabel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)ActionXiaJiaBtn:(UIButton *)BtN
{
         FourModel *Model = _dataOneArray[BtN.tag];
        _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
        [_arrowView setBackgroundColor:[UIColor clearColor]];
        [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定要开始下架课程吗？"];
        __weak typeof(self) weakSelf = self;
        [_arrowView setSelectBlock:^(UIButton *button){
            if (button.tag == 10) {
                NSLog(@"我是下架%ld",(long)button.tag);
            }else if (button.tag == 11){
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"courseId":Model.FourId,@"status":@2} url:UrL_UpDownObject success:^(id responseObject) {
//                    [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.dataOneArray removeObject:weakSelf.dataOneArray[BtN.tag]];
                        [weakSelf.firstView reloadData];
                    });
                } failure:^(NSError *error) {
                }];
            }
        }];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
        [_arrowView showArrowView:YES];
}

-(void)ActionBtn:(UIButton *)BTn
{
    FourModel *Model = _dataTwoArray[BTn.tag];
    __weak typeof(self) weakSelf = self;
    if ([BTn.titleLabel.text isEqualToString:@"删除课程"]){
        _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
        [_arrowView setBackgroundColor:[UIColor clearColor]];
        [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定要开始删除课程吗？"];
        [_arrowView setSelectBlock:^(UIButton *button){
            if (button.tag == 10) {
            }else if (button.tag == 11){
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"courseId":Model.FourId} url:UrL_DeleteCourse success:^(id responseObject) {
//                    [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.dataTwoArray removeObject:weakSelf.dataTwoArray[BTn.tag]];
                        [weakSelf.secondView reloadData];
                    });
                } failure:^(NSError *error) {
                }];
            }
        }];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
        [_arrowView showArrowView:YES];
        
    }else if ([BTn.titleLabel.text isEqualToString:@"上架课程"]){
    
        _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
        [_arrowView setBackgroundColor:[UIColor clearColor]];
        [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定要开始上架课程吗？"];
        [_arrowView setSelectBlock:^(UIButton *button){
            if (button.tag == 10) {
            }else if (button.tag == 11){
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"courseId":Model.FourId,@"status":@1} url:UrL_UpDownObject success:^(id responseObject) {
//                    [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.dataTwoArray removeObject:weakSelf.dataTwoArray[BTn.tag]];
                        [weakSelf.secondView reloadData];
                    });
                } failure:^(NSError *error) {
                }];
            }
        }];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
        [_arrowView showArrowView:YES];
    }
}

#pragma mark--------------------------分界--------------------

-(void)createTopView
{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,40)];
    _topView.backgroundColor = kAppWhiteColor;
    UIButton *BtnSJ = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 40)];
    [BtnSJ setTitle:@"已上架" forState:UIControlStateNormal];
    BtnSJ.tag = 11;
    [BtnSJ setTitleColor:kAppBlueColor forState:UIControlStateSelected];
    [BtnSJ addTarget:self action:@selector(BtnSJ:) forControlEvents:UIControlEventTouchUpInside];
    [BtnSJ setTitleColor:kAppBlackColor forState:UIControlStateNormal];
    BtnSJ.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    UIButton *BtnXJ = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2,0, kScreenWidth/2, 40)];
    [BtnXJ setTitle:@"已下架" forState:UIControlStateNormal];
    [BtnXJ addTarget:self action:@selector(BtnSJ:) forControlEvents:UIControlEventTouchUpInside];
    BtnXJ.tag = 12;
    [BtnXJ setTitleColor:kAppBlueColor forState:UIControlStateSelected];
    [BtnXJ setTitleColor:kAppBlackColor forState:UIControlStateNormal];
    BtnXJ.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, 0, 1, 38)];
    label.backgroundColor = kAppLightGrayColor;
    
    BtnSJ.selected = YES;
    self.btnSelected = BtnSJ;
    
    
    [_topView addSubview:BtnSJ];
    [_topView addSubview:BtnXJ];
    [_topView addSubview:label];
    [self.view addSubview:_topView];
    
}

#pragma mark-------------------------导航---------------------
-(void)createNav
{
    
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 45)/2, 10, 70, 30)];
    label.text = @"课程管理";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 30, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button2 setTitle:@"添加" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(Btn2Click:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
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
        [self createOverData];
        _mainScrollView.contentOffset = CGPointMake(kScreenWidth,0);
    }
    
    self.btnSelected = btnSJ;
}

-(void)Btn2Click:(UIButton *)btn
{
    Addobject *addObjc = [[Addobject alloc]init];
    
    [self.navigationController pushViewController:addObjc animated:YES];
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
