//
//  AddTeacher.m
//  ShangKOrganization
//
//  Created by apple on 16/9/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "AddTeacher.h"
#import "AddTeacherCell.h"
#import "UITextField+Extension.h"
#import "TZImagePickerController.h"
#import "TeacherManager.h"
#import "FbwManager.h"
@interface AddTeacher ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,TZImagePickerControllerDelegate>
{

    UITableView   *_tableView;
    NSInteger      Sex;
    NSArray       *_TitleArray;
    NSArray       *_TextFieldArray;
    UITextField   *_NameTextField;
    UITextField   *_PhoneTextField;
    UITextField   *_AgeTextField;
    UITextField   *_ZhangHaoTextField;
    UITextField   *_PassWordTextField;
    UITextField   *_QrPassWordTextField;
    UITextField   *_OrgPasswordTextField;
    NSMutableArray *_EndTextFieldArr;
    NSMutableArray *_selectedPhotos;
    NSString      *_FkPurposeId;
    UIImageView   *_imageView;
    UITextField   *TeacherMess;
    NSArray       *_UseInfoArray;
    UIButton      *BCButton;
    UIView        *NavBarview;
    AddTeacherCell *cell;
}
@property(nonatomic, strong)UIButton *btnSelected;
@end

@implementation AddTeacher

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    [self createTableview];
    self.view.backgroundColor = kAppWhiteColor;
    _NameTextField        = [[UITextField alloc]init];
    _PhoneTextField       = [[UITextField alloc]init];
    _AgeTextField         = [[UITextField alloc]init];
    _PassWordTextField    = [[UITextField alloc]init];
    _QrPassWordTextField  = [[UITextField alloc]init];
    _ZhangHaoTextField    = [[UITextField alloc]init];
    _UseInfoArray         = [NSMutableArray array];
    _TitleArray           = [NSArray array];
    _EndTextFieldArr      = [NSMutableArray array];
    _TextFieldArray       = [NSArray array];
    _TitleArray     = @[@"头像",@"性别",@"姓名",@"手机号",@"年龄",@"账号",@"密码",@"确认密码",@"管理员密码"];
    _TextFieldArray = @[@"请输入教师姓名",@"请输入教师手机号",@"请输入教师年龄",@"请输入教师账号",@"请输入教师账号密码",@"请输入教师账号密码"];
    if ([self.NAvTit isEqualToString:@"修改教师"]) {
        _PhoneTextField.text = self.TeacherInfoDic[@"phone"];
        _AgeTextField.text   = [NSString stringWithFormat:@"%@",self.TeacherInfoDic[@"age"]];
        _ZhangHaoTextField.text   = self.TeacherInfoDic[@"username"];
        _PassWordTextField.text   = self.TeacherInfoDic[@"password"];
        _QrPassWordTextField.text = self.TeacherInfoDic[@"password"];
        _QrPassWordTextField.text = @"123456";
        _PassWordTextField.text = @"123456";
        _UseInfoArray = @[self.TeacherOverName,_PhoneTextField.text,_AgeTextField.text,_ZhangHaoTextField.text,_PassWordTextField.text,_QrPassWordTextField.text];
    }
    [self createNav];
}

-(void)createTableview
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 194) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [self createView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = YES;
    [self.view addSubview:_tableView];
    
}

-(UIView *)createView
{
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame)+10, kScreenWidth, 120)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 20)];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = kAppBlackColor;
    label.text = @"教师简介";
    TeacherMess = [[UITextField alloc]initWithFrame:CGRectMake(10, 50, kScreenWidth, 20)];
    if ([self.NAvTit isEqualToString:@"修改教师"]) {
        TeacherMess.text = self.TeacherInfoDic[@"intro"];
        TeacherMess.userInteractionEnabled = NO;
    }
    TeacherMess.placeholder = @"请输入教师简介...";
    TeacherMess.adjustsFontSizeToFitWidth = YES;
    TeacherMess.clearsOnBeginEditing = YES;
    TeacherMess.ex_heightToKeyboard = 0;
    TeacherMess.ex_moveView = self.view;
    
    [View addSubview:label];
    [View addSubview:TeacherMess];
    return View;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }
    return kScreenHeight/14.5;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"Teacher"];
    if (!cell) {
        cell = [[AddTeacherCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Teacher"];
    }
    cell.MessLabel.text = _TitleArray[indexPath.row];
    if (indexPath.row == 0) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 80, 10, 60, 60)];
        _imageView.tag = 199;
        _imageView.layer.cornerRadius = 30;
        _imageView.layer.masksToBounds = YES;
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapImage:)];
        if ([self.NAvTit isEqualToString:@"修改教师"]) {
            _imageView.userInteractionEnabled = NO;
            if (self.PhotoHead != nil) {
                [_imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,self.PhotoHead]] placeholderImage:nil];
            }else{
//                if (self.PhotoHeadData == nil) {
//                    [_imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,self.PhotoHead]] placeholderImage:nil];
//                }else{
                     _imageView.image = [UIImage imageWithData:self.PhotoHeadData];
//                }
            }
        }else{
        if (_selectedPhotos.count == 0) {
            _imageView.image = [UIImage imageNamed:@"默认头像@2x.png"];
        }else{
            NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
            _imageView.image = [UIImage imageWithData:imageData];
          }
        }
        [_imageView addGestureRecognizer:tap];
        [cell.contentView addSubview:_imageView];
    }else if (indexPath.row == 1){
        NSArray *TitleArr = @[@"男",@"女"];
        for (int i=0; i<2; i++) {
            UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(kScreenWidth - 120+i*60, (kScreenHeight/14.5-20)/2, 20, 20);
            button.tag  = 10+i;
            [button setImage:[UIImage imageNamed:@"椭圆-3-拷贝-2@2x.png"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"椭圆-3-拷贝@2x.png"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(BClose:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *ZFLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 95+i*60, (kScreenHeight/14.5-20)/2, 20, 20)];
            ZFLabel.text     = TitleArr[i];
            ZFLabel.font     = [UIFont systemFontOfSize:16];
            if ([self.NAvTit isEqualToString:@"修改教师"]) {
                if ([self.TeacherInfoDic[@"sex"]integerValue] == 0) {
                    if (button.tag   == 11) {
                    button.selected = YES;
                    Sex = 0;
                    NSLog(@"这是女生");
                    self.btnSelected = button;
                    }
                }
                else if ([self.TeacherInfoDic[@"sex"]integerValue] == 1){
                    if (button.tag   == 10) {
                    button.selected = YES;
                    Sex = 1;
                     NSLog(@"这是男生");
                    self.btnSelected = button;
                    }
                }
            }else{
            if (button.tag   == 10) {
                button.selected  = YES;
                Sex = 1;
                self.btnSelected = button;
             }
            }
            [cell.contentView addSubview:button];
            [cell.contentView addSubview:ZFLabel];
        }
    }else{
        if ([self.NAvTit isEqualToString:@"修改教师"]) {
            cell.textFieldMess.text = _UseInfoArray[indexPath.row-2];
            if (indexPath.row == 6 || indexPath.row == 7) {
                cell.textFieldMess.secureTextEntry = YES;
            }
        }
        cell.textFieldMess.placeholder = _TextFieldArray[indexPath.row-2];
    
        [_EndTextFieldArr addObject:cell.textFieldMess];
    }
    if (indexPath.row == 1||indexPath.row == 0) {
        cell.textFieldMess.enabled = NO;
    }
    if (indexPath.row == 6 || indexPath.row == 7) {
        cell.textFieldMess.secureTextEntry = YES;
    }
    if (indexPath.row == 3 || indexPath.row == 4) {
        cell.textFieldMess.keyboardType = UIKeyboardTypeNumberPad;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textFieldMess.ex_heightToKeyboard = 0;
    cell.textFieldMess.ex_moveView = self.view;
    return cell;
}

-(void)TapImage:(UITapGestureRecognizer *)Tap
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    UIImageView *imageView = [self.view viewWithTag:199];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *photosArr ,BOOL isSelectOriginalPhoto) {
        _selectedPhotos = [NSMutableArray arrayWithArray:photos];
        NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
        imageView.image = [UIImage imageWithData:imageData];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)BClose:(UIButton *)btnSJ
{
    self.btnSelected.selected = NO;
    if (btnSJ.tag == 10) {
        Sex = 1;
        btnSJ.selected = YES;
    }else
    {
        Sex = 0;
        btnSJ.selected = YES;
    }
    self.btnSelected = btnSJ;
}

-(void)createNav
{
    NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label    = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth- 70)/2, 10, 70, 30)];
    label.text        = self.NAvTit;
    label.font        = [UIFont boldSystemFontOfSize:16];
    label.textColor   = [UIColor whiteColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BtnFanClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    if ([self.NAvTit isEqualToString:@"修改教师"]) {
        BCButton = [UIButton buttonWithType:UIButtonTypeCustom];
        BCButton.frame = CGRectMake(kScreenWidth - 70, 10, 50, 30);
        BCButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [BCButton setTitle:@"修改" forState:UIControlStateNormal];
        BCButton.tag = 10;
        [BCButton addTarget:self action:@selector(Fix:) forControlEvents:UIControlEventTouchUpInside];

    }else{
    BCButton = [UIButton buttonWithType:UIButtonTypeCustom];
    BCButton.frame = CGRectMake(kScreenWidth - 70, 10, 50, 30);
    BCButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [BCButton setTitle:@"保存" forState:UIControlStateNormal];
    [BCButton addTarget:self action:@selector(BtnBaoCunClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:BCButton];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
}

-(void)Fix:(UIButton *)BTn
{
    BCButton.hidden = YES;
    cell.textFieldMess.text = @"";
    cell.textFieldMess.enabled = YES;
    _imageView.userInteractionEnabled = YES;
    TeacherMess.userInteractionEnabled = YES;
    BTn = [UIButton buttonWithType:UIButtonTypeCustom];
    BTn.frame = CGRectMake(kScreenWidth - 70, 10, 50, 30);
    BTn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [BTn setTitle:@"保存" forState:UIControlStateNormal];
    [BTn addTarget:self action:@selector(BtnBaoCunClick:) forControlEvents:UIControlEventTouchUpInside];
    [NavBarview addSubview:BTn];
}

-(void)BtnFanClick:(UIButton *)btn
{
    FbwManager *Manager = [FbwManager shareManager];
    Manager.IsListPulling = 3;
    Manager.PullPage = 3;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)BtnBaoCunClick:(UIButton *)btn
{
    [_tableView reloadData];
    if ([self.NAvTit isEqualToString:@"修改教师"]) {
        FbwManager *Manager = [FbwManager shareManager];
        _NameTextField  = _EndTextFieldArr[0];
        _PhoneTextField  = _EndTextFieldArr[1];
        _AgeTextField     = _EndTextFieldArr[2];
        _ZhangHaoTextField = _EndTextFieldArr[3];
        _PassWordTextField  = _EndTextFieldArr[4];
        _QrPassWordTextField = _EndTextFieldArr[5];
       __weak typeof(self) weakSelf = self;
//        _OrgPasswordTextField = _EndTextFieldArr[6];
        if (_PassWordTextField.text.length != 0)    {
            if (_QrPassWordTextField.text.length!= 0)   {
                if (_NameTextField.text.length    != 0)     {
                    if (_ZhangHaoTextField.text.length != 0)    {
                        if (_PhoneTextField.text.length   != 0)    {
//                        if (_OrgPasswordTextField.text.length   != 0) {
                            if (_AgeTextField.text.length        !=  0)  {
                                if (TeacherMess.text.length         != 0)   {
                                    if ([_PassWordTextField.text isEqualToString:_QrPassWordTextField.text]) {
                                        BCButton.userInteractionEnabled = NO;
                                        btn.userInteractionEnabled = NO;
                                        NSLog(@"1%@",_NameTextField.text);
                                        Manager.FixUserInfoName = _NameTextField.text;
                                        NSLog(@"11%ld",(long)Sex);
                                        Manager.FixSex = Sex;
                                        Manager.JianTYeMian = 3;
                                        NSLog(@"8%@",self.TeacherOverId);
                                        NSLog(@"10%@",self.TeacherInfoDic[@"id"]);
                                        NSLog(@"9%@",TeacherMess.text);
                                        NSLog(@"2%@",_PhoneTextField.text);
                                        NSLog(@"3%@",_AgeTextField.text);
                                        NSLog(@"4%@",_ZhangHaoTextField.text);
                                        NSLog(@"5%@",_PassWordTextField.text);
                                        NSLog(@"6%@",_QrPassWordTextField.text);
                                        NSLog(@"7%ld",(long)Sex);
                                        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"teacherId":self.TeacherOverId,@"userName":_ZhangHaoTextField.text,@"password":_PassWordTextField.text,@"phone":_PhoneTextField.text,@"nickName":_NameTextField.text,@"sex":[NSString stringWithFormat:@"%ld",(long)Sex],@"intro":TeacherMess.text,@"orgId":Manager.UUserId,@"age":_AgeTextField.text,@"orgPassword":@""} url:UrL_FixOfTeacher success:^(id responseObject) {
                                            
                                            NSLog(@"修改成功%@",Manager.FixUserInfoName);
                                            if (_selectedPhotos.count != 0) {
                                                [SVProgressHUD showWithStatus:@"上传中"];
                                                Manager.FixUserInfoPhotoUrl = UIImagePNGRepresentation(_selectedPhotos[0]);
//                                                NSLog(@"%@",Manager.FixUserInfoPhotoUrl);
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    NSData *imageData  = UIImagePNGRepresentation(_selectedPhotos[0]);
                                                    NSDictionary *Dict = @{@"fileType":@"image",@"filePurpose":@"imageUserPhotoHead",@"fkPurposeId":self.TeacherOverId};
                                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                    [manager POST:UrL_UploadFile
                                                       parameters:Dict
                                                      constructingBodyWithBlock:
                                                     ^(id<AFMultipartFormData>_Nonnull formData) {
                                                         [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:@"FixuserInfoHead.png" mimeType:@"image/png"];
                                                     } progress:nil
                                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                              [SVProgressHUD dismiss];
//                                                              FbwManager *Manager = [FbwManager shareManager];
                                                              Manager.IsListPulling = 3;
                                                              Manager.PullPage = 3;
                                                              [weakSelf.navigationController popViewControllerAnimated:YES];
                                                              NSLog(@"修改头像成功了");
                                                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                              NSLog(@"修改头像失败了");
                                                          }];
                                                });
                                            }else{
//                                                FbwManager *Manager = [FbwManager shareManager];
                                                Manager.IsListPulling = 3;
                                                Manager.PullPage = 3;
                                                [weakSelf.navigationController popViewControllerAnimated:YES];
                                            }
                                        } failure:^(NSError *error) {
                                            NSLog(@"修改失败");
                                        }];
        
                                    }else{
                                        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致"];
                                    }
                                }else{
                                    [SVProgressHUD showErrorWithStatus:@"教师简介不能为空"];
                                }
                            }else{
                                [SVProgressHUD showErrorWithStatus:@"年龄不能为空"];
                            }
//                        }
//                        else{
//                            [SVProgressHUD showErrorWithStatus:@"管理员密码不能为空"];
//                        }
                        }else{
                            [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
                        }
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"账号不能为空"];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"姓名不能为空"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"确认密码不能为空"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        }
    }else{
         NSLog(@"哈哈哈%@",_OrgPasswordTextField.text);
        __weak typeof(self) weakSelf = self;
    _NameTextField  = _EndTextFieldArr[0];
    _PhoneTextField  = _EndTextFieldArr[1];
    _AgeTextField     = _EndTextFieldArr[2];
    _ZhangHaoTextField = _EndTextFieldArr[3];
    _PassWordTextField  = _EndTextFieldArr[4];
    _QrPassWordTextField = _EndTextFieldArr[5];
        FbwManager *Manager = [FbwManager shareManager];
        NSLog(@"%@ %@ %@ %@ %@ %@ %@",_NameTextField.text,_PhoneTextField.text,_AgeTextField.text,_ZhangHaoTextField.text,_PassWordTextField.text,_QrPassWordTextField.text,Manager.UUserId);
    if (_PassWordTextField.text.length != 0)    {
        if (_QrPassWordTextField.text.length!= 0)   {
            if (_NameTextField.text.length    != 0)     {
                if (_ZhangHaoTextField.text.length != 0)    {
                        if (_AgeTextField.text.length       !=  0)  {
                            if (TeacherMess.text.length        != 0)    {
                                if ([_PassWordTextField.text isEqualToString:_QrPassWordTextField.text]) {
                                    
                                    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{
                                                                                                      @"userName":_ZhangHaoTextField.text,
                                                                                                      @"password":_PassWordTextField.text,
                                                                                                      @"phone":   _PhoneTextField.text,
                                                                                                      @"nickName":_NameTextField.text,
                                                                                                      @"sex":[NSString stringWithFormat:@"%ld",(long)Sex],
                                                                     @"orgId":Manager.UUserId,
                                                                     @"orgPassword":@"",
                                                                     @"age":_AgeTextField.text,
                                                                                                      @"intro":TeacherMess.text} url:UrL_AddTeacher success:^(id responseObject) {
                                                                                                          NSLog(@"!!!%@",responseObject);
                                                                                                          if ([[responseObject objectForKey:@"errcode"]integerValue] != 0) {
                                                                                                              
                                                                                                              [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"msg"]];                             }else{
                                                                                                                  BCButton.userInteractionEnabled = NO;
                                                                                                                  btn.userInteractionEnabled = NO;                                    NSDictionary *rootDic  = [responseObject objectForKey:@"data"];
                                                                                                              _FkPurposeId = [rootDic objectForKey:@"id"];
                                                                                                              
                                                                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                                                                  [SVProgressHUD showWithStatus:@"上传中"];
                                                                                                                  NSData *imageData  = UIImagePNGRepresentation(_selectedPhotos[0]);
                                                                                                                  NSLog(@"ID:%@",[rootDic objectForKey:@"id"]);
                                                                                                                  NSLog(@"1%@",_ZhangHaoTextField.text);
                                                                                                                  NSLog(@"2%@",_PassWordTextField.text);
                                                                                                                  NSLog(@"3%@",_PhoneTextField.text);
                                                                                                                  NSLog(@"4%@",_NameTextField.text);
                                                                                                                  NSLog(@"5%@",_AgeTextField.text);
                                                                                                                  NSLog(@"6%@",TeacherMess.text);
                                                                                                                  NSLog(@"7性别%ld",Sex);
                                                                                                                  NSDictionary *Dict = @{@"fileType":@"image",@"filePurpose":@"imageUserPhotoHead",@"fkPurposeId":_FkPurposeId};
                                                                                                                  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                                                                                  [manager POST:UrL_UploadFile
                                                                                                                     parameters:Dict
                                                                                                      constructingBodyWithBlock:
                                                                                                                   ^(id<AFMultipartFormData>_Nonnull formData) {
                                                                                                                       [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:@"userInfoHead.png" mimeType:@"image/png"];
                                                                                                                   } progress:nil
                                                                                                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                                                                            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                                                                                                            [defaults setValue:  imageData
                                                                                                                                        forKey:@"iconImage"];
                                                                                                                            [defaults setValue:  _NameTextField.text forKey:@"userName"];
                                                                                                                            [defaults setValue:  _PhoneTextField.text forKey:@"userPhone"];
                                                                                                                            [defaults setValue:  _AgeTextField.text forKey:@"userAge"];
                                                                                                                            [defaults setValue:  _ZhangHaoTextField.text forKey:@"userZhangHao"];
                                                                                                                            [defaults setValue:  _PassWordTextField.text forKey:@"userPassWord"];
                                                                                                                            [defaults setValue:  _QrPassWordTextField.text forKey:@"userQRPassWord"];
                                                                                                                            //                                                      [defaults setValue:  _OrgPasswordTextField.text forKey:@"userOrgPassWord"];
                                                                                                                            [defaults synchronize];
                                                                                                                            NSLog(@"!!%@",responseObject);
                                                                                                                            [SVProgressHUD dismiss];
                                                                                                                            //                                                      FbwManager *Manager = [FbwManager shareManager];
                                                                                                                            Manager.IsListPulling = 3;
                                                                                                                            Manager.PullPage = 3;
                                                                                                                            [weakSelf.navigationController popViewControllerAnimated:YES];
                                                                                                                            
                                                                                                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                                                                            
                                                                                                                        }];
                                                                                                              });
                                                                                                          }
                                        
                                    } failure:^(NSError *error) {
                                    }];
                                }else{
                                    [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致"];
                                }
                            }else{
                                [SVProgressHUD showErrorWithStatus:@"教师简介不能为空"];
                            }
                        }else{
                            [SVProgressHUD showErrorWithStatus:@"年龄不能为空"];
                        }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"账号不能为空"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"姓名不能为空"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"确认密码不能为空"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
    }
  }
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
