//
//  ShelvesCourse.m
//  ShangKOrganization
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ShelvesCourse.h"
#import "ShelvesModel.h"
#import "ShelvesCourseCell.h"
#import "FbwManager.h"
@interface ShelvesCourse ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_DataArray;
    NSMutableArray *_InfoDataArray;
}
@property(nonatomic, strong)UIButton *btnSelected;
@end

@implementation ShelvesCourse

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _DataArray = [NSMutableArray array];
    _InfoDataArray = [NSMutableArray array];
    [self createNav];
    [self createData];
    [self createTableView];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"status":@1} url:UrL_ObjectLieBiao success:^(id responseObject) {
        [_DataArray removeAllObjects];
        NSDictionary *Dict = [responseObject objectForKey:@"data"];
        NSArray *arr       = [Dict objectForKey:@"iData"];
        for (NSDictionary *dic in arr) {
            ShelvesModel *Model= [[ShelvesModel alloc]init];
            [Model setDic:dic];
            NSArray *Ar = [dic objectForKey:@"photoList"];
            if ([[dic objectForKey:@"photoList"] isKindOfClass:[NSNull class]]) {
                
            }else{
            for (NSDictionary *RooD in Ar) {
                [Model setTDic:RooD];
              }
            }
            [_DataArray addObject:Model];
        }
        NSLog(@"你看%@",_DataArray);
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
    return _DataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
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
    ShelvesCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdCe"];
    if (!cell) {
        cell = [[ShelvesCourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdCe"];
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"icon_shelve lesson_nomal.png"] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"形状-1@2x.png"] forState:UIControlStateSelected];
        startBtn.frame = CGRectMake(kScreenWidth - 40, 105, 30, 30);
        startBtn.tag = indexPath.section;
        [startBtn addTarget:self action:@selector(PicClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:startBtn];
        ShelvesModel *Model = _DataArray[indexPath.section];
        [cell configWithModel:Model];
    }
   //else{
//        while ([cell.contentView.subviews lastObject] != nil) {
//            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
//        }
   // }
        return cell;
}

-(void)PicClick:(UIButton *)PicBtn
{
    PicBtn.selected = !PicBtn.selected;
    ShelvesModel *Model = _DataArray[PicBtn.tag];
    
    if (PicBtn.selected) {
        Model.IsChoose = YES;
       [_InfoDataArray addObject:Model];
    }else{
        Model.IsChoose = NO;
        [_InfoDataArray removeObject:Model];
    }
    self.btnSelected = PicBtn;
    
}

-(void)createNav
{
    UIView *NavBarview  = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2, 10, 100, 30)];
    label.text          = @"已上架课程";
    label.textAlignment = NSTextAlignmentCenter;
    label.font          = [UIFont boldSystemFontOfSize:16];
    label.textColor     = [UIColor whiteColor];
    UIButton *button1   = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame       = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BtnFanClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2       = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame           = CGRectMake(kScreenWidth - 70, 10, 50, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button2 setTitle:@"确定" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(QueDingClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
}

-(void)BtnFanClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)QueDingClick:(UIButton *)btn
{
    
    FbwManager *Manager = [FbwManager shareManager];
    Manager.AddActivityModelArray = _InfoDataArray;
    NSLog(@"奇迹%ld",(unsigned long)Manager.AddActivityModelArray.count);
    NSLog(@"%ld %@",(long)Manager.AddActivityModelArray.count,Manager.AddActivityModelArray);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
