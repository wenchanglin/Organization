//
//  CompanyProfileVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/15.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "CompanyProfileVC.h"
#import "AppDelegate.h"
#import "CompanyProfileCell.h"
#import "CompanyProfileSecondCell.h"
#import <TZImagePickerController.h>
#import "CompanyProfileThirdCell.h"
@interface CompanyProfileVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,TZImagePickerControllerDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_selectedFirstPhotos;
    NSMutableArray *_selectedSecondPhotos;
    NSMutableArray *_selectedThirdPhotos;
    UIButton       *button2;
}
@property(nonatomic,strong)UILabel    * FirstPlaceLabel;
@property(nonatomic,strong)UILabel    * SecondPlaceLabel;
@property(nonatomic,strong)UILabel    * ThirdPlaceLabel;
@end

@implementation CompanyProfileVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kAppWhiteColor;
    [self createNav];
    [self createTableView];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CompanyProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"File"];
        if (!cell) {
            cell = [[CompanyProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"File"];
        }
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame] ;
        cell.selectedBackgroundView.backgroundColor = kAppWhiteColor;
        cell.FirstButton.tag      = 10;
        cell.FirstTextView.tag    = 1000;
        _FirstPlaceLabel          = cell.ActivityName;
        cell.FirstTextView.delegate = self;
        [cell.FirstButton addTarget:self action:@selector(PictureZero:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 1){
        CompanyProfileSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Choos"];
        if (!cell) {
            cell = [[CompanyProfileSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Choos"];
        }
        cell.CompanyProfileSecondFirstButton.tag = 11;
        cell.CompanyProfileSecondFirstTextView.tag = 1001;
        _SecondPlaceLabel = cell.CompanyProfileSecondActivityName;
        cell.CompanyProfileSecondFirstTextView.delegate = self;
        [cell.CompanyProfileSecondFirstButton addTarget:self action:@selector(PictureZero:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    CompanyProfileThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OSx"];
    if (!cell) {
        cell = [[CompanyProfileThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OSx"];
    }
    cell.CompanyProfileThirdFirstButton.tag = 12;
    cell.CompanyProfileThirdFirstTextView.tag = 1002;
    _ThirdPlaceLabel = cell.CompanyProfileThirdActivityName;
    cell.CompanyProfileThirdFirstTextView.delegate = self;
    [cell.CompanyProfileThirdFirstButton addTarget:self action:@selector(PictureZero:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)PictureZero:(UIButton *)Pic
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    if (Pic.tag == 10) {
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *photosArr ,BOOL isSelectOriginalPhoto) {
            _selectedFirstPhotos = [NSMutableArray arrayWithArray:photos];
            NSData *imageData = UIImagePNGRepresentation(_selectedFirstPhotos[0]);
            [Pic setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else if (Pic.tag == 11){
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *photosArr ,BOOL isSelectOriginalPhoto) {
            _selectedSecondPhotos = [NSMutableArray arrayWithArray:photos];
            NSData *imageData = UIImagePNGRepresentation(_selectedSecondPhotos[0]);
            [Pic setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else{
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *photosArr ,BOOL isSelectOriginalPhoto) {
            _selectedThirdPhotos = [NSMutableArray arrayWithArray:photos];
            NSData *imageData = UIImagePNGRepresentation(_selectedThirdPhotos[0]);
            [Pic setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - textView 代理
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
    {
        switch (textView.tag) {
            case 1000:
            {
                _FirstPlaceLabel.text = @"";
            }
                break;
            case 1001:
            {
                _SecondPlaceLabel.text = @"";
                
            }
                break;
            case 1002:
            {
                _ThirdPlaceLabel.text = @"";
            }
                break;
            default:
                break;
        }
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        switch (textView.tag) {
            case 1000:
            {
                _FirstPlaceLabel.text  = @"请输入文字...";
            }
                break;
            case 1001:
            {
                _SecondPlaceLabel.text = @"请输入文字...";
            }
                break;
            case 1002:
            {
                _ThirdPlaceLabel.text  = @"请输入文字...";
            }
                break;
            default:
                break;
        }
    }
    return YES;
}

-(void)createNav
{
    
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"企业简介";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BackClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 40, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button2 setTitle:@"保存" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(SaveClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
}

-(void)BackClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)SaveClick:(UIButton *)SaveBtn
{
    NSLog(@"你是不是炸了 你妹的");
    NSUserDefaults *defaults   = [NSUserDefaults standardUserDefaults];
    UITextView *FirstTextView  = [self.view viewWithTag:1000];
    UITextView *SecondTextView = [self.view viewWithTag:1001];
    UITextView *ThirdTextView  = [self.view viewWithTag:1002];
    __weak typeof(self) weakSelf = self;
    FbwManager *Manager        = [FbwManager shareManager];
    NSData *OneImageData       = UIImagePNGRepresentation(_selectedFirstPhotos[0]);
    NSData *TwomageData        = UIImagePNGRepresentation(_selectedSecondPhotos[0]);
    NSData *ThirdImageData     = UIImagePNGRepresentation(_selectedThirdPhotos[0]);
    if (_selectedFirstPhotos.count != 0 && FirstTextView.text.length != 0) {
        if (_selectedFirstPhotos.count != 0 && FirstTextView.text.length != 0 &&_selectedSecondPhotos.count != 0 && SecondTextView.text.length != 0 && _selectedThirdPhotos.count != 0 && ThirdTextView.text.length != 0) {
            button2.userInteractionEnabled = NO;
            SaveBtn.userInteractionEnabled = NO;
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkOrgId":Manager.UUserId,@"content":FirstTextView.text} url:UrL_AddCompanyDetail success:^(id responseObject) {               [SVProgressHUD showWithStatus:@"上传中"];
                                                NSDictionary *Dict = [responseObject objectForKey:@"data"];
                                                NSString *Str = [Dict objectForKey:@"id"];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    NSDictionary *Dict = @{@"fileType":@"image",
                                                                           @"filePurpose":@"imageOrgDetailIntro",
                                                                           @"fkPurposeId":Str};
                                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                    [manager POST:UrL_UploadFile
                                                       parameters:Dict
                                                      constructingBodyWithBlock:
                                                     ^(id<AFMultipartFormData>_Nonnull formData) {
                                                         [formData appendPartWithFileData:OneImageData  name:@"uploadFile"
                                                             fileName:@"imageOrgDetailIntroOne.png"
                                                             mimeType:@"image/png"];
                                                     }  progress:nil
                                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                              NSLog(@"图片上传成果啦");
                                                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                              NSLog(@"图片上传出错啦");
                                                          }];
                                                });
                                            } failure:^(NSError *error) {
                                            }];
                                            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkOrgId":Manager.UUserId,@"content":SecondTextView.text} url:UrL_AddCompanyDetail success:^(id responseObject) {
                                                NSDictionary *Dict = [responseObject objectForKey:@"data"];
                                                NSString *Sr = [Dict objectForKey:@"id"];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    NSDictionary *Dict = @{@"fileType":@"image",
                                                                           @"filePurpose":@"imageOrgDetailIntro",
                                                                           @"fkPurposeId":Sr};
                                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                    [manager POST:UrL_UploadFile
                                                       parameters:Dict
                                                        constructingBodyWithBlock:
                                                     ^(id<AFMultipartFormData>_Nonnull formData) {
                                                         [formData appendPartWithFileData:TwomageData  name:@"uploadFile"
                                                             fileName:@"imageOrgDetailIntroTwo.png"
                                                             mimeType:@"image/png"];
                                                     }  progress:nil
                                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                              NSLog(@"图片上传成果啦");
                                                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                              NSLog(@"图片上传出错啦");
                                                          }];
                                                });
                                            } failure:^(NSError *error) {
                                            }];
                                            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkOrgId":Manager.UUserId,@"content":ThirdTextView.text} url:UrL_AddCompanyDetail success:^(id responseObject) {
                                                NSDictionary *Dict = [responseObject objectForKey:@"data"];
                                                NSString *STr = [Dict objectForKey:@"id"];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    NSDictionary *Dict = @{@"fileType":@"image",
                                                                           @"filePurpose":@"imageOrgDetailIntro",
                                                                           @"fkPurposeId":STr};
                                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                    [manager POST:UrL_UploadFile
                                                       parameters:Dict
                                                      constructingBodyWithBlock:
                                                     ^(id<AFMultipartFormData>_Nonnull formData) {
                                                         [formData appendPartWithFileData:ThirdImageData  name:@"uploadFile"
                                                             fileName:@"imageOrgDetailIntroThere.png"
                                                             mimeType:@"image/png"];
                                                       }  progress:nil
                                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                              NSLog(@"图片上传成果啦");
                                                              [SVProgressHUD dismiss];
                                                              [defaults setObject:@"GTR" forKey:@"GT"];
                                                              [defaults synchronize];
                                                              [weakSelf.navigationController popViewControllerAnimated:YES];
                                                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                              NSLog(@"图片上传出错啦");
                                                          }];
                                                });
                                            } failure:^(NSError *error) {
                                            }];
        }else if (_selectedFirstPhotos.count != 0 && FirstTextView.text.length != 0 &&_selectedSecondPhotos.count != 0 && SecondTextView.text.length != 0){
            button2.userInteractionEnabled = NO;
            SaveBtn.userInteractionEnabled = NO;
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkOrgId":Manager.UUserId,@"content":FirstTextView.text} url:UrL_AddCompanyDetail success:^(id responseObject) {
                [SVProgressHUD showWithStatus:@"上传中"];
                NSDictionary *Dict = [responseObject objectForKey:@"data"];
                NSString *Str = [Dict objectForKey:@"id"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary *Dict = @{@"fileType":@"image",
                                           @"filePurpose":@"imageOrgDetailIntro",
                                           @"fkPurposeId":Str};
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    [manager POST:UrL_UploadFile
                       parameters:Dict
                      constructingBodyWithBlock:
                     ^(id<AFMultipartFormData>_Nonnull formData) {
                         [formData appendPartWithFileData:OneImageData  name:@"uploadFile"
                                                 fileName:@"imageOrgDetailIntroOne.png"
                                                 mimeType:@"image/png"];
                     }  progress:nil
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              NSLog(@"图片上传成果啦");
                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                              NSLog(@"图片上传出错啦");
                          }];
                });
            } failure:^(NSError *error) {
            }];
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkOrgId":Manager.UUserId,@"content":SecondTextView.text} url:UrL_AddCompanyDetail success:^(id responseObject) {
                NSDictionary *Dict = [responseObject objectForKey:@"data"];
                NSString *Sr = [Dict objectForKey:@"id"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary *Dict = @{@"fileType":@"image",
                                           @"filePurpose":@"imageOrgDetailIntro",
                                           @"fkPurposeId":Sr};
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    [manager POST:UrL_UploadFile
                       parameters:Dict
                     constructingBodyWithBlock:
                     ^(id<AFMultipartFormData>_Nonnull formData) {
                         [formData appendPartWithFileData:TwomageData  name:@"uploadFile"
                                                 fileName:@"imageOrgDetailIntroTwo.png"
                                                 mimeType:@"image/png"];
                     }  progress:nil
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              NSLog(@"图片上传成果啦");
                              [SVProgressHUD dismiss];
                              [weakSelf.navigationController popViewControllerAnimated:YES];
                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                              NSLog(@"图片上传出错啦");
                          }];
                });
            } failure:^(NSError *error) {
            }];
        }else{
            button2.userInteractionEnabled = NO;
            SaveBtn.userInteractionEnabled = NO;
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkOrgId":Manager.UUserId,@"content":FirstTextView.text} url:UrL_AddCompanyDetail success:^(id responseObject) {
                [SVProgressHUD showWithStatus:@"上传中"];
                NSDictionary *Dict = [responseObject objectForKey:@"data"];
                NSString *Str = [Dict objectForKey:@"id"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary *Dict = @{@"fileType":@"image",
                                           @"filePurpose":@"imageOrgDetailIntro",
                                           @"fkPurposeId":Str};
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    [manager POST:UrL_UploadFile
                       parameters:Dict
                     constructingBodyWithBlock:
                     ^(id<AFMultipartFormData>_Nonnull formData) {
                         [formData appendPartWithFileData:OneImageData  name:@"uploadFile"
                                                 fileName:@"imageOrgDetailIntroOne.png"
                                                 mimeType:@"image/png"];
                     }  progress:nil
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              NSLog(@"图片上传成果啦");
                              [SVProgressHUD dismiss];
                              [weakSelf.navigationController popViewControllerAnimated:YES];
                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                              NSLog(@"图片上传出错啦");
                          }];
                });
            } failure:^(NSError *error) {
            }];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请至少上传一段图文简介或按顺序上传"];
    }
//    if (FirstTextView.text.length != 0) {
//        if (SecondTextView.text.length != 0) {
//            if (ThirdTextView.text.length != 0) {
//                if (_selectedFirstPhotos.count != 0) {
//                    if (_selectedSecondPhotos.count != 0) {
//                        if (_selectedThirdPhotos.count != 0) {
//                            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkOrgId":Manager.UUserId,@"content":FirstTextView.text} url:UrL_AddCompanyDetail success:^(id responseObject) {
//                                NSDictionary *Dict = [responseObject objectForKey:@"data"];
//                                NSString *Str = [Dict objectForKey:@"id"];
//                                dispatch_async(dispatch_get_main_queue(), ^{
//                                    NSDictionary *Dict = @{@"fileType":@"image",
//                                                           @"filePurpose":@"imageOrgDetailIntro",
//                                                           @"fkPurposeId":Str};
//                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//                                    [manager POST:UrL_UploadFile
//                                       parameters:Dict
//                                      constructingBodyWithBlock:
//                                     ^(id<AFMultipartFormData>_Nonnull formData) {
//                                         [formData appendPartWithFileData:OneImageData  name:@"uploadFile"
//                                             fileName:@"imageOrgDetailIntroOne.png"
//                                             mimeType:@"image/png"];
//                                     }  progress:nil
//                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                              NSLog(@"图片上传成果啦");
//                                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                              NSLog(@"图片上传出错啦");
//                                          }];
//                                });
//                            } failure:^(NSError *error) {
//                            }];
//                            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkOrgId":Manager.UUserId,@"content":SecondTextView.text} url:UrL_AddCompanyDetail success:^(id responseObject) {
//                                NSDictionary *Dict = [responseObject objectForKey:@"data"];
//                                NSString *Sr = [Dict objectForKey:@"id"];
//                                dispatch_async(dispatch_get_main_queue(), ^{
//                                    NSDictionary *Dict = @{@"fileType":@"image",
//                                                           @"filePurpose":@"imageOrgDetailIntro",
//                                                           @"fkPurposeId":Sr};
//                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//                                    [manager POST:UrL_UploadFile
//                                       parameters:Dict
//                                        constructingBodyWithBlock:
//                                     ^(id<AFMultipartFormData>_Nonnull formData) {
//                                         [formData appendPartWithFileData:TwomageData  name:@"uploadFile"
//                                             fileName:@"imageOrgDetailIntroTwo.png"
//                                             mimeType:@"image/png"];
//                                     }  progress:nil
//                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                              NSLog(@"图片上传成果啦");
//                                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                              NSLog(@"图片上传出错啦");
//                                          }];
//                                });
//                            } failure:^(NSError *error) {
//                            }];
//                            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkOrgId":Manager.UUserId,@"content":ThirdTextView.text} url:UrL_AddCompanyDetail success:^(id responseObject) {
//                                NSDictionary *Dict = [responseObject objectForKey:@"data"];
//                                NSString *STr = [Dict objectForKey:@"id"];
//                                dispatch_async(dispatch_get_main_queue(), ^{
//                                    NSDictionary *Dict = @{@"fileType":@"image",
//                                                           @"filePurpose":@"imageOrgDetailIntro",
//                                                           @"fkPurposeId":STr};
//                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//                                    [manager POST:UrL_UploadFile
//                                       parameters:Dict
//                                      constructingBodyWithBlock:
//                                     ^(id<AFMultipartFormData>_Nonnull formData) {
//                                         [formData appendPartWithFileData:ThirdImageData  name:@"uploadFile"
//                                             fileName:@"imageOrgDetailIntroThere.png"
//                                             mimeType:@"image/png"];
//                                       }  progress:nil
//                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                              NSLog(@"图片上传成果啦");
//                                              [defaults setObject:@"GTR" forKey:@"GT"];
//                                              [defaults synchronize];
//                                              [weakSelf.navigationController popViewControllerAnimated:YES];
//                                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                              NSLog(@"图片上传出错啦");
//                                          }];
//                                });
//                            } failure:^(NSError *error) {
//                            }];
//                        }else{
//                            [SVProgressHUD showErrorWithStatus:@"请上传段落三图片"];
//                        }
//                    }else{
//                        [SVProgressHUD showErrorWithStatus:@"请上传段落二图片"];
//                    }
//                }else{
//                    [SVProgressHUD showErrorWithStatus:@"请上传段落一图片"];
//                }
//            }else{
//                [SVProgressHUD showErrorWithStatus:@"请输入段落三内容"];
//            }
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"请输入段落二内容"];
//        }
//    }else{
//        [SVProgressHUD showErrorWithStatus:@"请输入段落一内容"];
//    }
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
