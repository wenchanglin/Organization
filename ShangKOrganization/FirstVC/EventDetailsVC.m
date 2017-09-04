//
//  EventDetailsVC.m
//  ShangKOrganization
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EventDetailsVC.h"
#import "EventDetailsModel.h"
#import "EventDetailsCell.h"
#import "EveryLessonVC.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
@interface EventDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView    *_tableView;
    NSMutableArray *_OneDataArray;
    NSString       *_PhotoUrl;
    NSString       *_ContentTitle;
    NSString       *_DetailsId;
    UIView         *_TAbView;
}
@end

@implementation EventDetailsVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    _OneDataArray = [NSMutableArray array];
    [self  createNav];
    [self  createDataOne];
    self.view.backgroundColor = KAppBackBgColor;
}

-(void)creteTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [self createUI];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(void)createDataOne
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"activityId":self.ActivityID} url:UrL_AcTivityXiangQ success:^(id responseObject) {
//        NSLog(@"活动详情%@",responseObject);
        NSDictionary *rootDic = [responseObject objectForKey:@"data"];
        _PhotoUrl = [rootDic objectForKey:@"photoUrl"];
        _ContentTitle = [rootDic objectForKey:@"content"];
        NSArray *Arr = [rootDic objectForKey:@"courseList"];
        for (NSDictionary *Ditc in Arr) {
            NSDictionary *Root = [Ditc objectForKey:@"course"];
            if ([[Ditc objectForKey:@"course"] isKindOfClass:[NSNull class]]) {
                
            }else{
              EventDetailsModel *Model = [[EventDetailsModel alloc]init];
              [Model setDic:Root];
              [_OneDataArray addObject:Model];
            }
        }
        [self  creteTableView];
    } failure:^(NSError *error) {
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _OneDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 20)];
        UIImageView *image     = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
        image.image            = [UIImage imageNamed:@"多边形-1-拷贝@2x.png"];
        UILabel * lable1       = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(image.frame)+5, 5, 100, 20)];
        lable1.text            = @"活动课程";
        lable1.font            = [UIFont boldSystemFontOfSize:15];
        [imageView addSubview:image];
        [imageView addSubview:lable1];
        return imageView;
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EventDetailsModel *model = _OneDataArray[indexPath.section];
    EveryLessonVC *lesson = [[EveryLessonVC alloc]init];
    lesson.CourseId = model.DetailsId;
    [self.navigationController pushViewController:lesson animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Text"];
    if (!cell) {
        cell = [[EventDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Text"];
    }
    EventDetailsModel *model = _OneDataArray[indexPath.section];
    [cell configWithMoedl:model];
    return cell;
}

-(UIView *)createUI
{
    UIImageView *imageView  = [[UIImageView alloc]init];
    if (_PhotoUrl == nil || [_PhotoUrl isKindOfClass:[NSNull class]]) {
        imageView.image = [UIImage imageNamed:@"哭脸.png"];
    }else{
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,_PhotoUrl]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!image) {
                image = [UIImage imageNamed:@"哭脸.png"];
                imageView.image = image;
            }
            //高图
            if (image.size.height > image.size.width) {
                CGFloat ImgeViewHeight = image.size.height / image.size.width * kScreenWidth;
                imageView.frame = CGRectMake(0, 0, kScreenWidth, ImgeViewHeight);
                _TAbView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ImgeViewHeight+120)];
                _TAbView.backgroundColor = kAppWhiteColor;
                [_TAbView addSubview:imageView];
            }else{
               //宽图
                CGSize size = image.size;
                CGFloat width = kScreenWidth;
                CGFloat height = width * size.height / size.width;
                if (height > kScreenHeight) {
                    height = kScreenHeight;
                    width = height * size.width / size.height;
                }
                _TAbView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height+120)];
                _TAbView.backgroundColor = kAppWhiteColor;
                imageView.frame = CGRectMake(0, 0, width, height);
                if (height > kScreenHeight) {
                    CGPoint center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.f);
                    imageView.center = center;
                }
                [_TAbView addSubview:imageView];
            }
            
       }];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString s®tringWithFormat:@"%@%@",BASEURL,_PhotoUrl]] placeholderImage:[UIImage imageNamed:@"哭脸.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
////            NSLog(@"%f",image.);
//            _TAbView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, image.size.height+50)];
//            _TAbView.backgroundColor = kAppWhiteColor;
//            imageView.frame = CGRectMake(0, 0, kScreenWidth, image.size.height);
//        }];
    }
    UILabel *TitleLAbel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(imageView.frame)+10, kScreenWidth-30, 10)];
    TitleLAbel.textColor = [UIColor blackColor];
    TitleLAbel.numberOfLines = 3;
    TitleLAbel.font = [UIFont systemFontOfSize:15];
    TitleLAbel.text = _ContentTitle;
    CGRect rect = [TitleLAbel.text boundingRectWithSize:CGSizeMake(kScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    TitleLAbel.frame = CGRectMake(20,  CGRectGetMaxY(imageView.frame)+10, kScreenWidth-30, rect.size.height);
    
    [_TAbView addSubview:TitleLAbel];
    
    return _TAbView;
}

-(void)createNav
{
    
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"活动详情";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCkck:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
}

-(void)BaCkck:(UIButton *)btn
{
    FbwManager *Manager = [FbwManager shareManager];
    Manager.IsListPulling = 3;
    Manager.PullPage = 3;
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
