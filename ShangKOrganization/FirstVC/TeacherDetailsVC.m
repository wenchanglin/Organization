//
//  TeacherDetailsVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "TeacherDetailsVC.h"
#import "AppDelegate.h"
#import "TeacherDetailCell.h"
#import "AddTeacher.h"
#import "FbwManager.h"
#import "TeacherDetailsModel.h"
#import "EveryLessonVC.h"

@interface TeacherDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation TeacherDetailsVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self createTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    _dataArray = [NSMutableArray array];
    [self createNav];
    [self createDAta];
    self.view.backgroundColor = kAppWhiteColor;
//    NSLog(@"看看来的字典%@",self.TeacherDeDict);
}

-(void)createDAta
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"teacherId":self.TeacherDeId} url:UrL_TeacherCourse success:^(id responseObject) {
        NSLog(@"负责的课程%@",responseObject);
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in Arr) {
            NSDictionary *Dic = [dict objectForKey:@"course"];
            TeacherDetailsModel *Model = [[TeacherDetailsModel alloc]init];
            [Model setDic:Dic];
            NSArray *ARR = [Dic objectForKey:@"photoList"];
            if ([[Dic objectForKey:@"photoList"] isKindOfClass:[NSNull class]]) {
                
            }else{
            for (NSDictionary *Dict in ARR) {
                [Model setdic:Dict];
              }
            }
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
    _tableView.tableHeaderView = [self createHeadView];
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
    if (section == 0) {
        return 40;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 50, 10)];
        label.font = [UIFont boldSystemFontOfSize:14];
        label.text = @"负责的课程";
        label.textColor = kAppBlackColor;
        return label;
    }
    return nil;
}

-(UIView *)createHeadView
{
    FbwManager *Manger = [FbwManager shareManager];
    UIView *HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    HeadView.backgroundColor = kAppWhiteColor;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
    imageView.layer.cornerRadius = 35;
    imageView.layer.masksToBounds = YES;
    if (Manger.JianTYeMian == 2) {
        [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,self.TeacherDePhoto]] placeholderImage:nil];
    }else{
        if (Manger.FixUserInfoPhotoUrl == nil) {
            [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,self.TeacherDePhoto]] placeholderImage:nil];
        }else{
           imageView.image = [UIImage imageWithData:Manger.FixUserInfoPhotoUrl];
        }
    }
    UILabel *TeacherName = [[UILabel alloc]initWithFrame:CGRectMake(90, 15, 120, 15)];
    if (Manger.JianTYeMian == 2) {
        TeacherName.text = [NSString stringWithFormat:@"教师:%@",self.TeacherDeName];
    }else {
        TeacherName.text = [NSString stringWithFormat:@"教师:%@",Manger.FixUserInfoName];
    }
    TeacherName.font = [UIFont boldSystemFontOfSize:16];
    UILabel *objectLAbel = [[UILabel alloc]initWithFrame:CGRectMake(90, 60, kScreenWidth - 120, 15)];
    objectLAbel.text = [NSString stringWithFormat:@"负责课程:%ld门",(long)self.TeacherDeObjeceNum];
    objectLAbel.font = [UIFont boldSystemFontOfSize:16];
    UIButton *ShezhiPic = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 50, 40, 25, 25)];
    [ShezhiPic setBackgroundImage:[UIImage imageNamed:@"设置-(2)@2x.png"] forState:UIControlStateNormal];
    [ShezhiPic addTarget:self action:@selector(SheZhiBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *ImageSex = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(TeacherName.frame)+5, 13, 20, 20)];
    if (Manger.JianTYeMian == 2) {
        if (self.TeacherDeSex==1) {
            ImageSex.image = [UIImage imageNamed:@"形状-1-拷贝-2@2x.png"];
        }else{
            ImageSex.image = [UIImage imageNamed:@"形状-2-拷贝@2x.png"];
        }
    }else {
        if (Manger.FixSex == 0){
        ImageSex.image = [UIImage imageNamed:@"形状-2-拷贝@2x.png"];
           }
    else{
      ImageSex.image = [UIImage imageNamed:@"形状-1-拷贝-2@2x.png"];
        }
    }
    [HeadView addSubview:imageView];
    [HeadView addSubview:TeacherName];
    [HeadView addSubview:objectLAbel];
    [HeadView addSubview:ShezhiPic];
    [HeadView addSubview:ImageSex];
    
    return HeadView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherDetailCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Details"];
    if (!cell) {
        
        cell = [[TeacherDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Details"];
    }
    TeacherDetailsModel *Model = _dataArray[indexPath.section];
    [cell configWithModel:Model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TeacherDetailsModel *Model = _dataArray[indexPath.section];
    EveryLessonVC *Lesson = [[EveryLessonVC alloc]init];
    Lesson.CourseId = Model.TeacherDetailsId;
    [self.navigationController pushViewController:Lesson animated:YES];
}

-(void)createNav
{
    
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"教师详情";
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
    FbwManager *Manager = [FbwManager shareManager];
    Manager.IsListPulling = 3;
    Manager.PullPage = 3;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)SheZhiBtn:(UIButton *)SZbtn
{
    AddTeacher *teacher = [[AddTeacher alloc]init];
    FbwManager *Manger = [FbwManager shareManager];
    teacher.NAvTit = @"修改教师";
    teacher.TeacherInfoDic = self.TeacherDeDict;
    
    teacher.TeacherOverId = self.TeacherDeId;
    if (Manger.JianTYeMian == 2) {
        teacher.PhotoHead = self.TeacherDePhoto;
        teacher.TeacherOverName = self.TeacherDeName;
    }else{
        NSLog(@"看着就行了%@",teacher.PhotoHeadData);
        teacher.TeacherOverName = Manger.FixUserInfoName;
        teacher.PhotoHeadData = Manger.FixUserInfoPhotoUrl;
    }
    [self.navigationController pushViewController:teacher animated:YES];
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
