//
//  PerfectInformationVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "PerfectInformationVC.h"
#import "AppDelegate.h"
#import "InformationFirstCell.h"
#import "InformationSecondCell.h"
#import "InformationThirdCell.h"
#import "GaoDeMap.h"
#import "InformCellThird.h"
#import "UITextField+Extension.h"
#import "FbwManager.h"
#import <TZImagePickerController.h>
#import "LoginVC.h"

@interface PerfectInformationVC ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>
{
    UITableView *_tableView;
    InformationFirstCell *cellHello;
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_EndTextFieldArr;
    NSMutableArray *_EndXiangXiTextArr;
    NSMutableArray *_SFZPositivePhotos;
    NSMutableArray *_SFZTheOtherSidePhotos;
    UITextField *_CompanyNameTextField;
    UITextField *_CompanyNamePeopleTextField;
    UITextField *_CompanyNameAddressTextField;
    UITextField *_CompanyNameXingXiAddressTextField;
}
@end

@implementation PerfectInformationVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    FbwManager *Manger = [FbwManager shareManager];
    if (Manger.WanShanXinYeMian == 3) {
        cellHello.FirstInfo.text = Manger.AddressTit;
        NSLog(@"经度%f  纬度%f",Manger.LocationLatitude,Manger.LocationLongitude);
        Manger.WanShanXinYeMian = 0;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedPhotos = [NSMutableArray array];
    _EndTextFieldArr  = [NSMutableArray array];
    _EndXiangXiTextArr = [NSMutableArray array];
    _SFZPositivePhotos  = [NSMutableArray array];
    _SFZTheOtherSidePhotos = [NSMutableArray array];
    _CompanyNameTextField     = [[UITextField alloc]init];
    _CompanyNamePeopleTextField  = [[UITextField alloc]init];
    _CompanyNameAddressTextField    = [[UITextField alloc]init];
    _CompanyNameXingXiAddressTextField = [[UITextField alloc]init];
    [self createNav];
    [self createTableView];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4||indexPath.row == 5) {
        return 150;
    }
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = @[@"机构名称",@"法人代表",@"公司地址"];
    NSArray *InfoAr = @[@"请输入企业名称",@"请输入企业法人",@"请地图选择公司地址"];
    if (indexPath.row == 4) {
        InformationSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SEcInfo"];
        if (!cell) {
            cell = [[InformationSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SEcInfo"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(cell.SecondTit.frame)+15, kScreenWidth/2-20, kScreenHeight/7.2)];
            button.backgroundColor = kAppWhiteColor;
            button.tag = 2;
            [button setBackgroundImage:[UIImage imageNamed:@"上传营业执照或--@2x.png"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(BtnCick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];
        });
        return cell;
    }else if (indexPath.row == 5){
        InformationThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirInfo"];
        if (!cell) {
            cell = [[InformationThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirInfo"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *Pic = @[@"上传身份证2x（正面）.png"];
        for (int i=0; i<1; i++) {
            UIButton *Button = [UIButton buttonWithType:UIButtonTypeSystem];
            Button.tag = i;
            Button = [[UIButton alloc]initWithFrame:CGRectMake(10+i*(kScreenWidth/2-20)+i*20, CGRectGetMaxY(cell.ThirdTit.frame)+15, kScreenWidth/2-20, kScreenHeight/7.2)];
            [Button setBackgroundImage:[UIImage imageNamed:Pic[i]] forState:UIControlStateNormal];
            [Button addTarget:self action:@selector(BtnCick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:Button];
        }
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10+(kScreenWidth/2-20)+20, CGRectGetMaxY(cell.ThirdTit.frame)+15, kScreenWidth/2-20, kScreenHeight/7.2)];
            image.image = [UIImage imageNamed:@"上传机构门面照@2x.png"];
            UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TApClick:)];
            image.userInteractionEnabled = YES;
            image.tag = 20;
            [image addGestureRecognizer:Tap];
            [cell.contentView addSubview:image];
        });
        return cell;
    }else if (indexPath.row == 3){
        InformCellThird *Third = [tableView dequeueReusableCellWithIdentifier:@"HeHeDa"];
        if (!Third) {
            Third = [[InformCellThird alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HeHeDa"];
        }
        Third.FourthQuesk.text        = @"详细地址";
        Third.FourthInfo.placeholder  = @"请输入详细地址";
        [_EndXiangXiTextArr addObject: Third.FourthInfo];
        Third.FourthInfo.ex_heightToKeyboard = 0;
        Third.FourthInfo.ex_moveView = self.view;
        return Third;
    }
    cellHello = [tableView dequeueReusableCellWithIdentifier:@"ChatInfo"];
    if (!cellHello) {
        cellHello = [[InformationFirstCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ChatInfo"];
    }
    if (indexPath.row == 2) {
        UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageTap:)];
        cellHello.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cellHello.FirstInfo.frame)-10, 0, 30, 30)];
        cellHello.FirstInfo.enabled      = NO;
        [cellHello.imageV addGestureRecognizer:Tap];
        cellHello.imageV.image = [UIImage imageNamed:@"图层-56@2x_53.png"];
        cellHello.imageV.userInteractionEnabled = YES;
//        cellHello.FirstInfo.rightView = imageV;
//        cellHello.FirstInfo.rightViewMode = UITextFieldViewModeAlways;
        [cellHello.contentView addSubview:cellHello.imageV];
    }
    cellHello.FirstQuesk.text        = arr[indexPath.row];
    cellHello.FirstInfo.placeholder  = InfoAr[indexPath.row];
    
    [_EndTextFieldArr addObject:cellHello.FirstInfo];
    cellHello.FirstInfo.ex_heightToKeyboard = 0;
    cellHello.FirstInfo.ex_moveView = self.view;
    return cellHello;
}

-(void)TApClick:(UITapGestureRecognizer *)Tap
{
    UIImageView *imageV = [self.view viewWithTag:20];
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *photosArr ,BOOL isSelectOriginalPhoto) {
        _SFZTheOtherSidePhotos = [NSMutableArray arrayWithArray:photos];
        NSData *imageData = UIImagePNGRepresentation(_SFZTheOtherSidePhotos[0]);
        [imageV setImage:[UIImage imageWithData:imageData]];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)BtnCick:(UIButton *)BaChoose
{
    if (BaChoose.tag == 2) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *photosArr ,BOOL isSelectOriginalPhoto) {
            _selectedPhotos = [NSMutableArray arrayWithArray:photos];
            NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
            [BaChoose setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else if (BaChoose.tag == 0){
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *photosArr ,BOOL isSelectOriginalPhoto) {
            _SFZPositivePhotos = [NSMutableArray arrayWithArray:photos];
            NSData *imageData = UIImagePNGRepresentation(_SFZPositivePhotos[0]);
            [BaChoose setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

-(void)ImageTap:(UITapGestureRecognizer *)TAp
{
    GaoDeMap *map = [[GaoDeMap alloc]init];
    [self.navigationController pushViewController:map animated:YES];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"完善信息";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 15, 40, 20);
    [button2 setTitle:@"确定" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(BAddClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [NavBarview addSubview:button2];
    [self.view addSubview:NavBarview];
    
}

-(void)BAddClick:(UIButton *)Bt
{
    FbwManager *Manger = [FbwManager shareManager];
    _CompanyNameTextField  = _EndTextFieldArr[0];
    _CompanyNamePeopleTextField  = _EndTextFieldArr[1];
    _CompanyNameAddressTextField     = _EndTextFieldArr[2];
    _CompanyNameXingXiAddressTextField  = _EndXiangXiTextArr[0];
    if (_CompanyNameTextField.text.length != 0) {
        if (_CompanyNamePeopleTextField.text.length != 0) {
            if (_CompanyNameAddressTextField.text.length    != 0) {
                if (_selectedPhotos.count  != 0 || (_SFZPositivePhotos.count != 0&&_SFZTheOtherSidePhotos.count != 0)) {
                    if (_selectedPhotos.count != 0) {
                        NSLog(@"地图选址%@ 详细地址%@",_CompanyNameAddressTextField.text,_CompanyNameXingXiAddressTextField.text);
                        NSLog(@"这是详细拼接地址:%@",[NSString stringWithFormat:@"%@%@",_CompanyNameAddressTextField.text,_CompanyNameXingXiAddressTextField.text]);
                        NSLog(@"这是企业法人%@",_CompanyNamePeopleTextField.text);
                        __weak typeof(self) weakSelf = self;
                        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":self.UserInfoId,@"nickName":_CompanyNameTextField.text,@"intro":@"",@"x":[NSString stringWithFormat:@"%f",Manger.LocationLatitude],@"y":[NSString stringWithFormat:@"%f",Manger.LocationLongitude],@"legalPersonName":_CompanyNamePeopleTextField.text,@"address":[NSString stringWithFormat:@"%@%@",_CompanyNameAddressTextField.text,_CompanyNameXingXiAddressTextField.text]} url:UrL_WanShanUserInfo success:^(id responseObject) {
                            NSLog(@"这是上传详细拼接地址:%@",[NSString stringWithFormat:@"%@%@",_CompanyNameAddressTextField.text,_CompanyNameXingXiAddressTextField.text]);
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSData *imageData  = UIImagePNGRepresentation(_selectedPhotos[0]);
                                NSDictionary *Dict = @{@"fileType":@"image",@"filePurpose":@"businessLicense",@"fkPurposeId":self.UserInfoId};
                                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                [manager POST:UrL_UploadFile
                                   parameters:Dict
                                  constructingBodyWithBlock:
                                 ^(id<AFMultipartFormData>_Nonnull formData) {
                                     [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:@"userInfoYingYe.png" mimeType:@"image/png"];
                                 } progress:nil
                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                          [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                                          NSLog(@"图片上传成功啦");
                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                          NSLog(@"图片上传失败啦");
                                      }];
                            });
                            if (_SFZPositivePhotos.count != 0&&_SFZTheOtherSidePhotos.count != 0){
                                NSLog(@"这是身份证正反面");
                                __weak typeof(self) weakSelf = self;
                                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":self.UserInfoId,@"nickName":_CompanyNameTextField.text,@"intro":@"",@"x":[NSString stringWithFormat:@"%f",Manger.LocationLatitude],@"y":[NSString stringWithFormat:@"%f",Manger.LocationLongitude],@"legalPersonName":_CompanyNamePeopleTextField.text,@"address":_CompanyNameAddressTextField.text} url:UrL_WanShanUserInfo success:^(id responseObject) {
//                                    [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        NSData *imageData  = UIImagePNGRepresentation(_SFZPositivePhotos[0]);
                                        NSDictionary *Dict = @{@"fileType":@"image",@"filePurpose":@"legalPersonIDCardPositive",@"fkPurposeId":self.UserInfoId};
                                        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                        [manager POST:UrL_UploadFile
                                           parameters:Dict
                            constructingBodyWithBlock:
                                         ^(id<AFMultipartFormData>_Nonnull formData) {
                                             [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:@"legalPersonIDCardPositive.png" mimeType:@"image/png"];
                                         } progress:nil
                                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                                  [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                                                  NSLog(@"图片上传成功啦");
                                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                  NSLog(@"图片上传失败啦");
                                              }];
                                    });
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        NSData *imageData  = UIImagePNGRepresentation(_SFZTheOtherSidePhotos[0]);
                                        
                                        NSDictionary *Dict = @{@"fileType":@"image",@"filePurpose":@"legalPersonIDCardOpposite",@"fkPurposeId":self.UserInfoId};
                                        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                        [manager POST:UrL_UploadFile
                                           parameters:Dict
                            constructingBodyWithBlock:
                                         ^(id<AFMultipartFormData>_Nonnull formData) {
                                             [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:@"legalPersonIDCardOpposite.png" mimeType:@"image/png"];
                                              } progress:nil
                                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                                  [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                                                  NSLog(@"图片上传成功啦");
                                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                  NSLog(@"图片上传失败啦");
                                              }];
                                    });
                                    [SVProgressHUD showSuccessWithStatus:@"注册资料提交成功，我们预计24小时内完成审核"];
                                    LoginVC *login = [[LoginVC alloc]init];
                                    [weakSelf.navigationController pushViewController:login animated:YES];
                                } failure:^(NSError *error) {
                                    NSLog(@"完善失败");
                                }];
                            }else{
                            [SVProgressHUD showSuccessWithStatus:@"注册资料提交成功，我们预计24小时内完成审核"];
                            LoginVC *login = [[LoginVC alloc]init];
                            [weakSelf.navigationController pushViewController:login animated:YES];
                            }
                        } failure:^(NSError *error) {
                            NSLog(@"完善失败");
                        }];
                    }else if (_SFZPositivePhotos.count != 0&&_SFZTheOtherSidePhotos.count != 0){
                        __weak typeof(self) weakSelf = self;
                        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":self.UserInfoId,@"nickName":_CompanyNameTextField.text,@"intro":@"",@"x":[NSString stringWithFormat:@"%f",Manger.LocationLatitude],@"y":[NSString stringWithFormat:@"%f",Manger.LocationLongitude],@"legalPersonName":_CompanyNamePeopleTextField.text,@"address":_CompanyNameAddressTextField.text} url:UrL_WanShanUserInfo success:^(id responseObject) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSData *imageData  = UIImagePNGRepresentation(_SFZPositivePhotos[0]);
                                NSDictionary *Dict = @{@"fileType":@"image",@"filePurpose":@"legalPersonIDCardPositive",@"fkPurposeId":self.UserInfoId};
                                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                [manager POST:UrL_UploadFile
                                   parameters:Dict
                                 constructingBodyWithBlock:
                                 ^(id<AFMultipartFormData>_Nonnull formData) {
                                     [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:@"legalPersonIDCardPositive.png" mimeType:@"image/png"];
                                 } progress:nil
                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                          [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                                          NSLog(@"图片上传成功啦");
                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                          NSLog(@"图片上传失败啦");
                                      }];
                            });
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSData *imageData  = UIImagePNGRepresentation(_SFZTheOtherSidePhotos[0]);
                                
                                NSDictionary *Dict = @{@"fileType":@"image",@"filePurpose":@"legalPersonIDCardOpposite",@"fkPurposeId":self.UserInfoId};
                                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                [manager POST:UrL_UploadFile
                                   parameters:Dict
                                 constructingBodyWithBlock:
                                 ^(id<AFMultipartFormData>_Nonnull formData) {
                                     [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:@"legalPersonIDCardOpposite.png" mimeType:@"image/png"];
                                 } progress:nil
                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                          [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                                          NSLog(@"图片上传成功啦");
                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                          NSLog(@"图片上传失败啦");
                                      }];
                            });
                            [SVProgressHUD showSuccessWithStatus:@"注册资料提交成功，我们预计24小时内完成审核"];
                            LoginVC *login = [[LoginVC alloc]init];
                            [weakSelf.navigationController pushViewController:login animated:YES];
                        } failure:^(NSError *error) {
                            NSLog(@"完善失败");
                        }];
                    }
//                        else if (_selectedPhotos.count  != 0 && (_SFZPositivePhotos.count != 0&&_SFZTheOtherSidePhotos.count != 0)){
//                        NSLog(@"这是身份证正反面和营业执照");
//                        __weak typeof(self) weakSelf = self;
//                        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":self.UserInfoId,@"nickName":_CompanyNameTextField.text,@"intro":@"",@"x":[NSString stringWithFormat:@"%f",Manger.LocationLatitude],@"y":[NSString stringWithFormat:@"%f",Manger.LocationLongitude],@"legalPersonName":_CompanyNamePeopleTextField.text,@"address":_CompanyNameAddressTextField.text} url:UrL_WanShanUserInfo success:^(id responseObject) {
//                            [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                NSData *imageData  = UIImagePNGRepresentation(_selectedPhotos[0]);
//                                NSDictionary *Dict = @{@"fileType":@"image",@"filePurpose":@"businessLicense",@"fkPurposeId":self.UserInfoId};
//                                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//                                [manager POST:UrL_UploadFile
//                                   parameters:Dict
//                    constructingBodyWithBlock:
//                                 ^(id<AFMultipartFormData>_Nonnull formData) {
//                                     [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:@"userInfoYingYe.png" mimeType:@"image/png"];
//                                 } progress:nil
//                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                          [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
//                                          NSLog(@"图片上传成功啦");
//                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                          NSLog(@"图片上传失败啦");
//                                      }];
//                            });
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                NSData *imageData  = UIImagePNGRepresentation(_SFZPositivePhotos[0]);
//                                NSDictionary *Dict = @{@"fileType":@"image",@"filePurpose":@"legalPersonIDCardPositive",@"fkPurposeId":self.UserInfoId};
//                                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//                                [manager POST:UrL_UploadFile
//                                   parameters:Dict
//                                 constructingBodyWithBlock:
//                                 ^(id<AFMultipartFormData>_Nonnull formData) {
//                                     [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:@"legalPersonIDCardPositive.png" mimeType:@"image/png"];
//                                 } progress:nil
//                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                          [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
//                                          NSLog(@"图片上传成功啦");
//                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                          NSLog(@"图片上传失败啦");
//                                      }];
//                            });
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                NSData *imageData  = UIImagePNGRepresentation(_SFZTheOtherSidePhotos[0]);
//                                
//                                NSDictionary *Dict = @{@"fileType":@"image",@"filePurpose":@"legalPersonIDCardOpposite",@"fkPurposeId":self.UserInfoId};
//                                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//                                [manager POST:UrL_UploadFile
//                                   parameters:Dict
//                    constructingBodyWithBlock:
//                                 ^(id<AFMultipartFormData>_Nonnull formData) {
//                                     [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:@"userInfoYingYe.png" mimeType:@"image/png"];
//                                 } progress:nil
//                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                          [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
//                                          NSLog(@"图片上传成功啦");
//                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                          NSLog(@"图片上传失败啦");
//                                      }];
//                            });
//                            LoginVC *login = [[LoginVC alloc]init];
//                            [weakSelf.navigationController pushViewController:login animated:YES];
//                        } failure:^(NSError *error) {
//                            NSLog(@"完善失败");
//                        }];
//                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"请上传营业执照或身份证机构门面2选1"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"公司地址不能为空"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"企业法人不能为空"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"企业名称不能为空"];
    }
}

-(void)BaCklick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
