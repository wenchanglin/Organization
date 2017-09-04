//
//  MyCompanyVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyCompanyVC.h"
#import "AppDelegate.h"
#import "FirstCell.h"
#import "CompanyProfileVC.h"
#import "CarouselVC.h"
#import "CompanyFirCell.h"
#import "BusinessLicense.h"
#import "IDCardVC.h"
#import "MainBusinessVC.h"
#import "ManagerUserInfoVC.h"
#import "ColumnViewController.h"
#import "GaoDeMap.h"
#import "FbwManager.h"
#import <TZImagePickerController.h>
@interface MyCompanyVC ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>
{
    UITableView *_TableView;
    NSMutableArray *_dataOneArray;
    NSMutableArray *_dataIdOneArray;
    NSMutableArray *_selectedPhotos;
    UILabel        *_AddressLabel;
    NSString       *_UserIntro;
//    NSString       *_UserNickName;
    NSString       *_UserPhone;
    NSInteger       _UserAge;
    NSInteger       _UserSex;
    UIButton       *button2;
}
@end

@implementation MyCompanyVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;

    FbwManager *Manger = [FbwManager shareManager];
    if (Manger.AddressTit.length != 0) {
        _AddressLabel.text = Manger.AddressTit;
    }else{
      NSLog(@"看看%@",_AddressLabel.text);
    }
        NSLog(@"经度a %f  纬度a %f",Manger.LocationLatitude,Manger.LocationLongitude);
    [self createDAta];
    
}

-(void)createDAta
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId} url:UrL_MyOrgDetails success:^(id responseObject) {
//        NSLog(@"我得意的笑了%@",responseObject);
        NSDictionary *rootD = [responseObject objectForKey:@"data"];
        NSDictionary *RootDic = [rootD objectForKey:@"userBase"];
        if ([[RootDic objectForKey:@"intro"] isKindOfClass:[NSNull class]]) {
             _UserIntro = @"暂无简介";
        }else{
             _UserIntro = [RootDic objectForKey:@"intro"];
        }
//        _UserNickName = rootD[@"userBase"][@"nickName"];
        if ([[RootDic objectForKey:@"phone"] isKindOfClass:[NSNull class]]) {
             _UserPhone = @"暂无手机号";
        }else{
             _UserPhone = [RootDic objectForKey:@"phone"];
        }
        
        if ([[RootDic objectForKey:@"age"] isKindOfClass:[NSNull class]]) {
            _UserAge = 0;
        }else{
            _UserAge = [[RootDic objectForKey:@"age"]integerValue];
        }
        if ([[RootDic objectForKey:@"sex"] isKindOfClass:[NSNull class]]) {
            _UserSex = 1;
        }else{
          _UserSex = [[RootDic objectForKey:@"sex"]integerValue];
        }
    } failure:^(NSError *error) {
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedPhotos = [NSMutableArray array];
    self.fd_interactivePopDisabled = YES;
    [self createNav];
    self.view.backgroundColor = kAppBlueColor;
    [self createTableView];
    [self createTDAta];
}

#pragma mark-------------------------tableview---------------------

-(void)createTableView
{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _TableView.delegate   = self;
    _TableView.scrollEnabled = YES;
    _TableView.dataSource = self;
    _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_TableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 3) {
        return 60;
    }else if (indexPath.row == 0){
        return 80;
    }
    return 60;
}

-(void)createTDAta
{
    _dataIdOneArray = [NSMutableArray array];
    _dataOneArray   = [NSMutableArray array];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:nil url:UrL_LookAllOrgDetail success:^(id responseObject) {
//        NSLog(@"我得意的小%@",responseObject);
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in Arr) {
            NSArray *ListArr = [dict objectForKey:@"list"];
            for (NSDictionary *DC in ListArr) {
                [_dataOneArray addObject:[DC objectForKey:@"name"]];
                [_dataIdOneArray addObject:[DC objectForKey:@"id"]];
            }
//            [_dataOneArray addObject:[dict objectForKey:@"id"]];
//            NSLog(@"看看%ld",(unsigned long)_dataOneArray.count);
        }
    } failure:^(NSError *error) {
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3) {
        GaoDeMap *map = [[GaoDeMap alloc]init];
        [self.navigationController pushViewController:map animated:YES];
    }else if (indexPath.row == 4) {
        CompanyProfileVC *Profile = [[CompanyProfileVC alloc]init];
        [self.navigationController pushViewController:Profile animated:YES];
    }else if (indexPath.row == 5){
        MainBusinessVC *main = [[MainBusinessVC alloc]init];
        [self.navigationController pushViewController:main animated:YES];
    }else if (indexPath.row == 6){
        //轮播图片
        CarouselVC *Carouse = [[CarouselVC alloc]init];
        [self.navigationController pushViewController:Carouse animated:YES];
    }else if (indexPath.row == 7){
        BusinessLicense *Licence = [[BusinessLicense alloc]init];
        [self.navigationController pushViewController:Licence animated:YES];
    }else if (indexPath.row == 8){
        IDCardVC *Card = [[IDCardVC alloc]init];
        [self.navigationController pushViewController:Card animated:YES];
    }else if (indexPath.row == 9){
        ManagerUserInfoVC *user = [[ManagerUserInfoVC alloc]init];
        user.UserInfoIntro = _UserIntro;
        user.UserAge = _UserAge;
        user.UserSex = _UserSex;
        user.UserNickName = self.UserNickNameCom;
        user.UserPhone = _UserPhone;
        [self.navigationController pushViewController:user animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *TitleARr = @[@"机构简介",@"主营业务",@"轮播图片",@"营业执照",@"身份验证",@"管理员信息"];
    NSArray *FirstAr = @[@"机构名称",@"机构法人",@"机构地址"];
    NSLog(@"%@ %@ %@",self.UserNickNameCom,[defaults objectForKey:@"CompanyPeople"],self.AddressTit);
//    NSString *Perple;
    NSArray *NeiRAr = @[self.UserNickNameCom,[defaults objectForKey:@"CompanyPeople"],self.AddressTit];
    if (indexPath.row == 0) {
        CompanyFirCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Yell"];
        if (!cell) {
            cell = [[CompanyFirCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Yell"];
        }
        if ([self.PicImage isKindOfClass:[NSNull class]]) {
            [cell.ImaPic setBackgroundImage:[UIImage imageNamed:@"Orgicon_logo.png"] forState:UIControlStateNormal];
        }else{
            [cell.ImaPic setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,self.PicImage]]];
        }
        cell.ImaPic.layer.cornerRadius = 30;
        cell.ImaPic.layer.masksToBounds = YES;
        [cell.ImaPic addTarget:self action:@selector(ImageAD:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:cell.ImaPic];
        return cell;
    }
    if (indexPath.row > 3) {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Chat"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Chat"];
    }
        cell.textLabel.text = TitleARr[indexPath.row-4];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Company"];
    if (!cell) {
        cell = [[FirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Company"];
    }
    cell.TitleLabel.text  = FirstAr[indexPath.row-1];
    cell.PeopleLabel.text = NeiRAr[indexPath.row-1];
    if (indexPath.row     == 3) {
        _AddressLabel     = cell.PeopleLabel;
        cell.PeopleLabel.numberOfLines = 0;
        CGRect textFrame       = cell.PeopleLabel.frame;
        cell.PeopleLabel.frame = CGRectMake(CGRectGetMaxX(cell.TitleLabel.frame)+15, 10, kScreenWidth - (CGRectGetMaxX(cell.PeopleLabel.frame)+25), textFrame.size.height = [cell.PeopleLabel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:cell.TitleLabel.font,NSFontAttributeName ,nil] context:nil].size.height);
        cell.PeopleLabel.frame = CGRectMake(CGRectGetMaxX(cell.TitleLabel.frame)+15, 10, kScreenWidth - (CGRectGetMaxX(cell.TitleLabel.frame)+25), textFrame.size.height);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

-(void)ImageAD:(UIButton *)Rbt
{
  //选择头像
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *photosArr ,BOOL isSelectOriginalPhoto) {
        _selectedPhotos = [NSMutableArray arrayWithArray:photos];
        NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
        [Rbt setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark-------------------------导航---------------------

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"我的机构";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(lick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 40, 30);
    [button2 setTitle:@"提交" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(BtnAddClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
}

-(void)BtnAddClick:(UIButton *)BAd
{
//    NSLog(@"提交");
//    NSLog(@"我哈哈哈机构法人%@",self.AddressPeople);
    __weak typeof(self) weakSelf = self;
    FbwManager *Manager = [FbwManager shareManager];
    if (_AddressLabel.text.length != 0) {
        button2.userInteractionEnabled = NO;
        BAd.userInteractionEnabled = NO;
//        NSLog(@"修改地址坐标%f %f",Manager.LocationLatitude,Manager.LocationLongitude);
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId,@"x":[NSString stringWithFormat:@"%f",Manager.LocationLatitude],@"y":[NSString stringWithFormat:@"%f",Manager.LocationLongitude],@"legalPersonName":self.AddressPeople,@"address":_AddressLabel.text} url:UrL_WanShanUserInfo success:^(id responseObject) {
                if (_selectedPhotos.count != 0) {
                    [SVProgressHUD showWithStatus:@"上传中"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSData *imageData  = UIImagePNGRepresentation(_selectedPhotos[0]);
                        NSDictionary *Dict = @{@"fileType":@"image",@"filePurpose":@"imageUserPhotoHead",@"fkPurposeId":Manager.UUserId};
                        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                        [manager POST:UrL_UploadFile
                           parameters:Dict
                         constructingBodyWithBlock:
                         ^(id<AFMultipartFormData>_Nonnull formData) {
                             [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:@"imageUserPhotoHead.png" mimeType:@"image/png"];
                         } progress:nil
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  [SVProgressHUD dismiss];
                                  [weakSelf.navigationController popViewControllerAnimated:YES];
                                  NSLog(@"图片上传成功啦");
                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                  NSLog(@"图片上传失败啦");
                              }];
                    });
                }else{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }
            failure:^(NSError *error) {
                NSLog(@"完善失败");
            }];
    }else{
        if (_selectedPhotos.count != 0) {
            {
                button2.userInteractionEnabled = NO;
                BAd.userInteractionEnabled = NO;
                [SVProgressHUD showWithStatus:@"上传中"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSData *imageData  = UIImagePNGRepresentation(_selectedPhotos[0]);
                    NSDictionary *Dict = @{@"fileType":@"image",@"filePurpose":@"imageUserPhotoHead",@"fkPurposeId":Manager.UUserId};
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    [manager POST:UrL_UploadFile
                       parameters:Dict
                       constructingBodyWithBlock:
                     ^(id<AFMultipartFormData>_Nonnull formData) {
                         [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:@"imageUserPhotoHead.png" mimeType:@"image/png"];
                     } progress:nil
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              [SVProgressHUD dismiss];
                              [weakSelf.navigationController popViewControllerAnimated:YES];
                              NSLog(@"图片上传成功啦");
                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                              NSLog(@"图片上传失败啦");
                          }];
                });
            }
        }
    }
}

-(void)lick:(UIButton *)btn
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
