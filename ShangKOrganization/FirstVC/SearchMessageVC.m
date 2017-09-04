//
//  SearchMessageVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SearchMessageVC.h"
#import "StudentStatisticsCell.h"
#import "ActivityRewardCell.h"
#import "FirstSearchMessCell.h"
#import "UITextField+Extension.h"
#import "ActivityRewardModel.h"
#import "StudentPeopleModel.h"
#import "FourModel.h"
#import "PellTableViewSelect.h"
#import "OrganizationActivityModel.h"
@interface SearchMessageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_TableView;
    UITextField *XtextField;
    NSMutableArray *_ActivityArray;
    NSMutableArray *_PeopleArray;
    NSMutableArray *_dataArray;
    NSMutableArray *_IdArray;
    NSMutableArray *_ActArray;
    NSMutableArray *_ActIdArray;
    NSInteger Selected;
}
@end

@implementation SearchMessageVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    _ActivityArray = [NSMutableArray array];
    _PeopleArray = [NSMutableArray array];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    _IdArray = [NSMutableArray array];
    _ActArray = [NSMutableArray array];
    _ActIdArray = [NSMutableArray array];
    [self createNav];
    if ([self.NavTitle isEqualToString:@"报名学员统计"]) {
    [self createData];
    }else{
        [self createAvtivity];
    }
    [self createSeachBar];
    self.view.backgroundColor = KAppBackBgColor;
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId} url:UrL_ObjectLieBiao success:^(id responseObject) {
//        NSLog(@"报名学员统计%@",responseObject);
        [_dataArray removeAllObjects];
        [_IdArray removeAllObjects];
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *Dict = [responseObject objectForKey:@"data"];
        NSArray *arr       = [Dict objectForKey:@"iData"];
        for (NSDictionary *dic in arr) {
            FourModel *Model= [[FourModel alloc]init];
            [Model setDic:dic];
//            NSLog(@"%@",Model.FourName);
            [_dataArray addObject:Model.FourName];
            [_IdArray addObject:Model.FourId];
        }
//        NSLog(@"%ld",_dataArray.count);
//        NSLog(@"w%ld",_IdArray.count);
//        [_TableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createAvtivity
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId} url:UrL_AcTivityManager success:^(id responseObject) {
//        NSLog(@"活动分销%@",responseObject);
        [_ActArray removeAllObjects];
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *Dict = [responseObject objectForKey:@"data"];
        NSArray *arr       = [Dict objectForKey:@"iData"];
        for (NSDictionary *dic in arr) {
            OrganizationActivityModel *Model= [[OrganizationActivityModel alloc]init];
            [Model setDic:dic];
            [_ActArray addObject:Model.ActivityName];
            [_ActIdArray addObject:Model.ActivityId];
        }
//            NSLog(@"%ld",_ActArray.count);
//            NSLog(@"w%ld",_ActIdArray.count);
//        [_firstView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createTableView
{
    if ([self.NavTitle isEqualToString:@"报名学员统计"]) {
    _TableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 80, kScreenWidth, kScreenHeight-64-80) style:UITableViewStylePlain];//kScreenHeight -64
    _TableView.delegate = self;
    _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _TableView.dataSource = self;
    _TableView.scrollEnabled = YES;
    [self.view addSubview:_TableView];
    }else{
        _TableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 80, kScreenWidth, kScreenHeight-64-80) style:UITableViewStylePlain];//kScreenHeight -64
        _TableView.delegate = self;
        _TableView.dataSource = self;
        _TableView.scrollEnabled = YES;
        [self.view addSubview:_TableView];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.NavTitle isEqualToString:@"报名学员统计"]) {
          return _PeopleArray.count+1;
    }else{
          return _ActivityArray.count;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"查询结果";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _TableView)
    {
        CGFloat sectionHeaderHeight = 28;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.NavTitle isEqualToString:@"报名学员统计"]) {
        if (indexPath.row == 0) {
            return 20;
        }
    }
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.NavTitle isEqualToString:@"报名学员统计"]) {
        if (indexPath.row == 0) {
            FirstSearchMessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeK"];
            if (!cell) {
                cell = [[FirstSearchMessCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HeK"];
            }
            cell.SearchFirLabel.text = [NSString stringWithFormat:@"总检索到%ld名学员",(unsigned long)_PeopleArray.count];
            [cell.contentView addSubview:cell.SearchFirLabel];
            return cell;
        }else{
           StudentStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Student"];
           if (!cell) {
           cell = [[StudentStatisticsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Student"];
       }
//            NSLog(@"是不是瞎%ld",_PeopleArray.count);
            StudentPeopleModel *Model = _PeopleArray[indexPath.row-1];
            [cell configWithMoDel:Model];
             return cell;
        }
    }
    ActivityRewardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reward"];
    if (!cell) {
        cell = [[ActivityRewardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reward"];
    }
    ActivityRewardModel *Model = _ActivityArray[indexPath.row];
    if (Model.ActivityRewardType == 1) {
        cell.ShareLuJLabel.text = @"分享路径:微信好友";
    }else if (Model.ActivityRewardType == 2){
        cell.ShareLuJLabel.text = @"分享路径:微信朋友圈";
    }else{
        cell.ShareLuJLabel.text = @"分享路径:新浪微博";
    }
//    [cell configWithMoEdl:Model];
//    NSLog(@"几点%@",Model.ActivityRewardCreateTime);
    cell.SharePriceLabel.text = [NSString stringWithFormat:@"+%@元",Model.ActivityIncome];
    NSString * timeStampString = Model.ActivityRewardCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    cell.ShareTimeLabel.text = [NSString stringWithFormat:@"分享时间:%@",time];
    [cell.contentView addSubview:cell.ShareTimeLabel];
    [cell.contentView addSubview:cell.ShareLuJLabel];
    return cell;
}

-(void)createSeachBar
{
    UIView *SearchView          = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 80)];
    SearchView.backgroundColor  = kAppWhiteColor;
    UILabel *TitleLabel         = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 50, 30)];
    TitleLabel.font             = [UIFont boldSystemFontOfSize:16];
    if ([self.NavTitle isEqualToString:@"报名学员统计"]) {
        TitleLabel.text             = @"课程";
    }else{
        TitleLabel.text             = @"活动";
    }
    TitleLabel.textAlignment    = NSTextAlignmentCenter;
    XtextField = [[UITextField alloc]initWithFrame:CGRectMake(60, 15, kScreenWidth - 120, 30)];
    XtextField.backgroundColor   = kAppWhiteColor;
    [XtextField setBorderStyle:UITextBorderStyleBezel];
    XtextField.layer.borderWidth = 0.1;
    XtextField.placeholder       = @"请下拉选择";
    XtextField.enabled           = true;
    XtextField.ex_heightToKeyboard = 0;
    XtextField.ex_moveView = self.view;
    XtextField.layer.borderColor = kAppLineColor.CGColor;
    XtextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UIImageView *view           = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(XtextField.frame)-20, 0, 20, CGRectGetMaxY(XtextField.frame)+7)];
    view.image = [UIImage imageNamed:@"图层-56@2x.png"];
    view.userInteractionEnabled = YES;
    view.contentMode = UIViewContentModeCenter;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SearcgPic:)];
    XtextField.rightView         = view;
    XtextField.rightViewMode     = UITextFieldViewModeAlways;
    [view addGestureRecognizer:tap];
    UIButton *ChaXunBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 60, 15, 50, 30)];
    ChaXunBtn.titleLabel.font   = [UIFont boldSystemFontOfSize:16];
    [ChaXunBtn setTitle:@"查询" forState:UIControlStateNormal];
    [ChaXunBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
    ChaXunBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [ChaXunBtn addTarget:self action:@selector(ChaXunBtn:) forControlEvents:UIControlEventTouchUpInside];
  
    [SearchView addSubview:ChaXunBtn];
    [SearchView addSubview:XtextField];
    [SearchView addSubview:TitleLabel];
    [self.view  addSubview:SearchView];
}

-(void)SearcgPic:(UITapGestureRecognizer *)tap
{
    
    if ([self.NavTitle isEqualToString:@"报名学员统计"]) {
        [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(60, 64, kScreenWidth - 120, 200) selectData:_dataArray images:nil action:^(NSInteger index) {
            NSLog(@"选择%ld",(long)index);
            Selected = index;
            XtextField.text = _dataArray[Selected];
            NSLog(@"琪琪%@",_IdArray[Selected]);
        } animated:YES];
    }else{
        [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(60, 64, kScreenWidth - 120, 200) selectData:_ActArray images:nil action:^(NSInteger index) {
            NSLog(@"选择%ld",(long)index);
            Selected = index;
            XtextField.text = _ActArray[Selected];
            NSLog(@"琪琪%@",_ActIdArray[Selected]);
        } animated:YES];
    }
    
}

-(void)ChaXunBtn:(UIButton *)btn
{
    __weak typeof(self) weakSelf = self;
    FbwManager *Manager = [FbwManager shareManager];
    if ([self.NavTitle isEqualToString:@"报名学员统计"]) {
        if (XtextField.text.length != 0) {
            if (_IdArray.count != 0) {
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"fkCourseId":_IdArray[Selected]} url:UrL_queryStudentForOrg success:^(id responseObject) {
                    [_PeopleArray removeAllObjects];
//                    NSLog(@"报名统计%@",responseObject);
                    NSDictionary *RootDic = [responseObject objectForKey:@"data"];
                    NSArray *arr = [RootDic objectForKey:@"iData"];
                    for (NSDictionary *Dict in arr) {
                        StudentPeopleModel *Model = [[StudentPeopleModel alloc]init];
                        [Model setDic:Dict];
                        [_PeopleArray addObject:Model];
                    }
                    [weakSelf createTableView];
//                    [_TableView reloadData];
                } failure:^(NSError *error) {
                }];
            }else{
                [SVProgressHUD showErrorWithStatus:@"请下拉选择课程"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请选择课程"];
        }
    }else{
//        NSLog(@"%@",_ActIdArray[Selected]);
//        NSLog(@"你逗我%@",XtextField.text);
        if (XtextField.text.length != 0) {
            if (_ActIdArray.count != 0) {
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"idValue":_ActIdArray[Selected]} url:UrL_ReportListForOrg success:^(id responseObject) {
                    [_ActivityArray removeAllObjects];
                            NSLog(@"活动%@",responseObject);
                    NSDictionary *RootDic = [responseObject objectForKey:@"data"];
                    NSArray *arr = [RootDic objectForKey:@"iData"];
                    for (NSDictionary *Dict in arr) {
                        ActivityRewardModel *Model = [[ActivityRewardModel alloc]init];
                        [Model setDic:Dict];
                        [_ActivityArray addObject:Model];
                    }
                    [weakSelf createTableView];
                    [_TableView reloadData];
                } failure:^(NSError *error) {
                    
                }];
            }else{
                [SVProgressHUD showErrorWithStatus:@"请下拉选择活动"];
            }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请选择课程"];
    }
    }

}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2, 10, 100, 30)];
    label.text = self.NavTitle;
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
