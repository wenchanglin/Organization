//
//  LuRuStudentVC.m
//  ShangKOrganization
//
//  Created by apple on 16/12/16.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "LuRuStudentVC.h"
#import "UITextField+Extension.h"
#import "StudentPeopleModel.h"
#import "StudentStatisticsCell.h"
@interface LuRuStudentVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *_Topview;
    UITextField  *_textField;
    UITableView  *_TableView;
    NSMutableArray *_dataArray;
    NSString     *StudentId;
}
@property(nonatomic, strong)UIButton *btnSelected;
@property(nonatomic, strong)UIButton *ChangeSelected;
@end
@implementation LuRuStudentVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self createSearchBar];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createTablEview
{
    _TableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64 ,kScreenWidth,kScreenHeight-64) style:UITableViewStylePlain];
    _TableView.delegate = self;
    _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _TableView.dataSource = self;
    _TableView.scrollEnabled = YES;
    [self.view addSubview:_TableView];
    UIButton *ShenQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ShenQBtn.frame = CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44);
    [ShenQBtn setTitle:@"确认录入该学员" forState:UIControlStateNormal];
    [ShenQBtn addTarget:self action:@selector(LuRuStudentHa:)forControlEvents:UIControlEventTouchUpInside];
    [ShenQBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    ShenQBtn.backgroundColor = kAppBlueColor;
    
    [self.view addSubview:ShenQBtn];
}

-(void)LuRuStudentHa:(UIButton *)T
{
    __weak typeof(self) weakSelf = self;
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"courseId":self.CourseId,@"userId":StudentId} url:UrL_LuRuStudent success:^(id responseObject) {
        if ([[responseObject objectForKey:@"errcode"]integerValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"插入失败"];
        }
    } failure:^(NSError *error) {
    }];
}

-(void)createDAta
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"phone":_textField.text} url:UrL_FindStudent success:^(id responseObject) {
        if ([[responseObject objectForKey:@"errcode"]integerValue] == 0) {
            NSDictionary *RootDic = [responseObject objectForKey:@"data"];
            StudentPeopleModel *Model = [[StudentPeopleModel alloc]init];
            [Model SetLuRuStudent:RootDic];
            [_dataArray addObject:Model];
            [self createTablEview];
        }else{
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"msg"]];
        }
        [_TableView reloadData];
    } failure:^(NSError *error) {
        
    }];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"查询结果";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Student"];
    if (!cell) {
        cell = [[StudentStatisticsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Student"];
    }
    StudentPeopleModel *Model = _dataArray[indexPath.row];
    StudentId = Model.StudentPeopleId;
    [cell configWithMoDel:Model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)createSearchBar
{
    UIView *SearchView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    SearchView.backgroundColor = kAppBlueColor;
    UIButton *button1  = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame      = CGRectMake(10, 5, 30, 34);
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(Klick:)forControlEvents:UIControlEventTouchUpInside];
    _textField    = [[UITextField alloc]initWithFrame:CGRectMake(40, 5, kScreenWidth - 80, 34)];
    _textField.backgroundColor = kAppWhiteColor;
    [_textField setBorderStyle:UITextBorderStyleRoundedRect];
    _textField.layer.cornerRadius = 5;
    _textField.layer.borderWidth = 0.1;
    _textField.ex_heightToKeyboard = 0;
    _textField.ex_moveView = self.view;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.enabled         = true;
    _textField.placeholder     = @"搜索学员";
    _textField.layer.borderColor = kAppLineColor.CGColor;
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_textField.frame)-20, 0, 34, CGRectGetMaxY(_textField.frame))];
    view.image                  = [UIImage imageNamed:@"图层-56@2x_26.png"];
    view.userInteractionEnabled = YES;
    view.contentMode            = UIViewContentModeCenter;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SearchPic:)];
    _textField.rightView         = view;
    _textField.rightViewMode     = UITextFieldViewModeAlways;
    [view addGestureRecognizer:tap];
    
    [SearchView addSubview:_textField];
    [SearchView addSubview:button1];
    [self.view  addSubview:SearchView];
}

-(void)SearchPic:(UITapGestureRecognizer *)tap7
{
    
    if (_textField.text.length != 0) {
        [_textField resignFirstResponder];
        [self createDAta];
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入搜索条件"];
    }
}

-(void)Klick:(UIButton *)cBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
