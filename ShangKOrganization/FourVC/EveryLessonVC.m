//
//  EveryLessonVC.m
//  ShangKOrganization
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EveryLessonVC.h"
#import "AppDelegate.h"
#import "EveryLessonCell.h"
#import "EveryLessonModel.h"
#import "EveryLessonPinaJiaModel.h"
#import "EveryLessonPinaJiaCell.h"
#import "ImageScrollView.h"
#import "LuRuStudentVC.h"
@interface EveryLessonVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView     *_TableView;
    NSMutableArray  *_PicArr;
    NSMutableArray  *_dataArray;
    NSString        *_ObjectName;
    NSString        *_ObjectPrice;
    NSInteger        _ObjectBuyCount;
    NSString        *_ObjectavgScore;
    NSMutableArray  *_PingJiaArray;
    EveryLessonCell *Ycell;
    ImageScrollView *imgScrollView;
}
@end

@implementation EveryLessonVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    _dataArray = [NSMutableArray array];
    _PingJiaArray = [NSMutableArray array];
    _PicArr = [NSMutableArray array];
    [self createTableView];
    [self createNav];
    [self createPingJiaData];
}

#pragma mark------------------------tableview----------------------
-(void)createTableView
{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+54) style:UITableViewStylePlain];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    [self.view addSubview:_TableView];
    [self createData];
    UIButton *ShenQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ShenQBtn.frame = CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44);
    [ShenQBtn setTitle:@"录入学员" forState:UIControlStateNormal];
    [ShenQBtn addTarget:self action:@selector(LuRuStudent:)forControlEvents:UIControlEventTouchUpInside];
    [ShenQBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    ShenQBtn.backgroundColor = kAppBlueColor;
    
    [self.view addSubview:ShenQBtn];
}

#pragma mark------------------------Data----------------------
-(void)createData
{
    __weak typeof(self) weakSelf = self;
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"courseId":self.CourseId} url:UrL_CourseDetails success:^(id responseObject) {
        NSLog(@"悄悄%@",responseObject);
        [_PicArr removeAllObjects];
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        EveryLessonModel *model = [[EveryLessonModel alloc]init];
        NSDictionary *RootDic   = [responseObject objectForKey:@"data"];
        _ObjectName             = [RootDic objectForKey:@"name"];
        
        
        _ObjectPrice            = [RootDic objectForKey:@"price"];
        _ObjectBuyCount         = [[RootDic objectForKey:@"buyCount"]integerValue];
        _ObjectavgScore         = [RootDic objectForKey:@"avgScore"];
        dispatch_async(dispatch_get_main_queue(), ^{
            _TableView.tableHeaderView = [weakSelf createHeadView];
        });
        NSArray *arr = [RootDic objectForKey:@"photoList"];
        if ([[RootDic objectForKey:@"photoList"] isKindOfClass:[NSNull class]]||[RootDic objectForKey:@"photoList"] == nil) {
            
        }else{
        for (NSDictionary *dic in arr) {
            NSString *st = [NSString stringWithFormat:@"%@%@",BASEURL,[dic objectForKey:@"location"]];
            [_PicArr addObject:st];
          }
        }
        [model setDic:RootDic];
//        [self createHeadView];
        [_dataArray addObject:model];
        [_TableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createPingJiaData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"courseId":self.CourseId} url:UrL_ObjectConment success:^(id responseObject) {
        [_PingJiaArray removeAllObjects];
        NSDictionary *RootDic =[responseObject objectForKey:@"data"];
        NSArray *arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in arr) {
            EveryLessonPinaJiaModel *Model =[[EveryLessonPinaJiaModel alloc]init];
            [Model setDic:Dict];
            [_PingJiaArray addObject:Model];
        }
        [Ycell.SecondTableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(UIView *)createHeadView
{
    UIView *HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2+10)];
    HeadView.backgroundColor = kAppWhiteColor;
    NSLog(@"%@",_PicArr);
//     NSMutableArray *arr = @[@"图层-56@2x_70.png",@"图层-56@2x_81.png",@"图层-72-拷贝@2x.png"];
     imgScrollView       = [[ImageScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2 - 120)];
     imgScrollView.pics  = _PicArr;
     [imgScrollView returnIndex:^(NSInteger index) {
//     _lunboSelectedIndex = index;
//     NSLog(@"??%ld??",_lunboSelectedIndex);
     }];
     [imgScrollView reloadView];
    [HeadView addSubview:imgScrollView];
//    UIImageView *imageView   = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2 - 120)];
//    imageView.userInteractionEnabled = YES;
//    imageView.image     = [UIImage imageNamed:@"图层-56@2x_70.png"];
    UILabel *TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenHeight/2 - 100, kScreenWidth, 25)];
    TitleLabel.text     = _ObjectName;
    TitleLabel.font     = [UIFont boldSystemFontOfSize:19];
    NSMutableAttributedString *PingFenStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"评分: %@分",_ObjectavgScore]];
    [PingFenStr addAttribute:NSForegroundColorAttributeName value:kAppOrangeColor range:NSMakeRange(4,1)];
    UILabel *PriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenHeight/2 - 70, 100, 25)];
    PriceLabel.attributedText = PingFenStr;
    PriceLabel.font     = [UIFont boldSystemFontOfSize:17];
    UIImageView *TouXianPic = [[UIImageView alloc]initWithFrame:CGRectMake(115, kScreenHeight/2 - 70+2, 20, 20)];
    TouXianPic.image    = [UIImage imageNamed:@"我的@2x.png"];
    UILabel *StudNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(TouXianPic.frame)+5, kScreenHeight/2 - 70, kScreenWidth - 150, 25)];
    StudNumLabel.text   = [NSString stringWithFormat:@"%ld人已报名",(long)_ObjectBuyCount];
    StudNumLabel.font   = [UIFont boldSystemFontOfSize:17];
    StudNumLabel.textColor = kAppBlackColor;
    UILabel *LineLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(StudNumLabel.frame)+10, kScreenWidth, 0.5)];
    LineLabel.backgroundColor = kAppLineColor;

    UILabel *Price = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(LineLabel.frame)+10, 100, 20)];
    Price.text = [NSString stringWithFormat:@"¥%@",_ObjectPrice];
    Price.textColor = kAppRedColor;
    Price.font           = [UIFont boldSystemFontOfSize:18];
    
    
    [HeadView  addSubview:StudNumLabel];
//    [imageView addSubview:BackButton];
//    [imageView addSubview:LineLabel];
    [HeadView  addSubview:TitleLabel];
    [HeadView  addSubview:TouXianPic];
    [HeadView  addSubview:Price];
    [HeadView  addSubview:PriceLabel];
//    [HeadView  addSubview:imageView];
    return HeadView;
}
#pragma mark------------------------tableview代理----------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 100) {
        return _PingJiaArray.count;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_dataArray.count) {
        
        return 0;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        return 120;
    }
    return kScreenHeight-200;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        EveryLessonPinaJiaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Full"];
        if (!cell) {
            cell = [[EveryLessonPinaJiaCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Full"];
        }
        EveryLessonPinaJiaModel *Model = _PingJiaArray[indexPath.section];
        [cell configWithModel:Model];
        return cell;
    }else{
    Ycell = [tableView dequeueReusableCellWithIdentifier:@"LessonCell"];
    if (!Ycell) {
        Ycell = [[EveryLessonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LessonCell"];
    }
    EveryLessonModel *Model = _dataArray[indexPath.row];
    [Ycell configWith:Model];
        
    Ycell.SecondTableView.delegate = self;
    Ycell.SecondTableView.tag = 100;
    Ycell.SecondTableView.dataSource = self;
//        [Ycell addSubview:Ycell.FirstOneTitle];
    return Ycell;
    }
}

-(void)LuRuStudent:(UIButton *)LuRu
{
    LuRuStudentVC *Student = [[LuRuStudentVC alloc]init];
    Student.CourseId = self.CourseId;
    [self.navigationController pushViewController:Student animated:YES];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppClearColor;
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-45@2x.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(Cklick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [self.view addSubview:NavBarview];
}

-(void)Cklick:(UIButton *)btn
{
    FbwManager *Manager = [FbwManager shareManager];
    Manager.IsListPulling = 3;
    Manager.PullPage = 3;
    [self.navigationController popViewControllerAnimated:YES];
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
