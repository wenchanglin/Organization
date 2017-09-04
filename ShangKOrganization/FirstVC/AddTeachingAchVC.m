//
//  AddTeachingAchVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "AddTeachingAchVC.h"
#import "AddTeachCell.h"
#import "TZImagePickerController.h"
#import "UITextField+Extension.h"
@interface AddTeachingAchVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong)UILabel     * activityName;
@property(nonatomic,strong)UITextField * nameTextField;
@property(nonatomic,strong)UILabel     * activityHome;
@property(nonatomic,strong)UILabel     * activitySecondHome;
@property(nonatomic,strong)UIButton    * firstButton;
@property(nonatomic,strong)UIView      * firstView;
@property(nonatomic,strong)UILabel     * firstPlaceLabel;
@property(nonatomic,strong)UILabel     * secondPlaceLabel;
@end

@implementation AddTeachingAchVC
{
    UIView         * view;
    UITableView    * _TableView;
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedSecondPhotos;
    NSMutableArray *_selectedThirdPhotos;
    UIButton       *button2;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    [self createNav];
    [self createTableView];
    [self createHeader];
    
}

-(void)createTableView
{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    
    [self.view addSubview:_TableView];
}
-(void)createHeader
{
    view                        = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,271)];
    [self.view addSubview:view];
    view.userInteractionEnabled = YES;
    view.backgroundColor        = kAppWhiteColor;
    _activityName               = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 80, 30)];
    _activityName.font          = [UIFont boldSystemFontOfSize:16];
    [view addSubview:_activityName];
    _activityName.text          = @"成果名称";
    _nameTextField              = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_activityName.frame)+10, 10, [UIScreen mainScreen].bounds.size.width-105, 30)];
    [view addSubview:_nameTextField];
    _nameTextField.placeholder  = @"请输入活动名称";
    _nameTextField.ex_heightToKeyboard = 0;
    _nameTextField.ex_moveView = self.view;
    _nameTextField.font         = [UIFont boldSystemFontOfSize:16];
    _firstView                  = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_activityName.frame)+10, [UIScreen mainScreen].bounds.size.width, 1)];
    [view addSubview:_firstView];
    _firstView.backgroundColor  = kAppLineColor;
    _activityHome               = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_firstView.frame)+10, 70, 30)];
    [view addSubview:_activityHome];
    _activityHome.font          = [UIFont boldSystemFontOfSize:16];
    _activityHome.text          = @"成果首页";
    _activitySecondHome         = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_activityHome.frame)+10, CGRectGetMaxY(_firstView.frame)+10,[UIScreen mainScreen].bounds.size.width-100, 30)];
    [view addSubview:_activitySecondHome];
    _activitySecondHome.text    = @"(为便于宣传请务必上传一张活动首页)";
    _activitySecondHome.font    = [UIFont systemFontOfSize:14];
    _activitySecondHome.textColor = [UIColor lightGrayColor];
    _firstButton                = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_activitySecondHome.frame)+10, 160, 160)];
    [view addSubview:_firstButton];
    [_firstButton setBackgroundImage:[UIImage imageNamed:@"矩形-2-拷贝@2x.png"] forState:UIControlStateNormal];
    _firstButton.backgroundColor = [UIColor cyanColor];
    _firstButton.tag           = 9;
    [_firstButton addTarget:self action:@selector(PicZero:) forControlEvents:UIControlEventTouchUpInside];
    _TableView.tableHeaderView = view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 20)];
    UILabel * lable1       = [[UILabel alloc]initWithFrame:CGRectMake(10, 4, 80, 20)];
    lable1.text            = @"成果内容";
    lable1.font            = [UIFont boldSystemFontOfSize:16];
    [imageView addSubview:lable1];
    return imageView;
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddTeachCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddTea"];
    if (!cell) {
        cell = [[AddTeachCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddTea"];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame] ;
    cell.selectedBackgroundView.backgroundColor = kAppWhiteColor;
    cell.FourButton.tag   = 10;
    cell.FiveButton.tag   = 11;
    cell.FourTextView.tag = 1000;
    cell.FiveTextView.tag = 1001;
    _firstPlaceLabel      = cell.FouractivityName;
    _secondPlaceLabel     = cell.FiveName;
    cell.FourTextView.delegate = self;
    cell.FiveTextView.delegate = self;
    [cell.FourButton addTarget:self action:@selector(PicZero:) forControlEvents:UIControlEventTouchUpInside];
    [cell.FiveButton addTarget:self action:@selector(PicZero:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)PicZero:(UIButton *)PicLick
{
     TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    if (PicLick.tag       == 9) {
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *photosArr ,BOOL isSelectOriginalPhoto) {
            _selectedPhotos = [NSMutableArray arrayWithArray:photos];
            NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
            [PicLick setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
        }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else if (PicLick.tag == 10){
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *photosArr ,BOOL isSelectOriginalPhoto) {
            _selectedSecondPhotos = [NSMutableArray arrayWithArray:photos];
            NSData *imageData = UIImagePNGRepresentation(_selectedSecondPhotos[0]);
            [PicLick setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else{
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *photosArr ,BOOL isSelectOriginalPhoto) {
            _selectedThirdPhotos = [NSMutableArray arrayWithArray:photos];
            NSData *imageData = UIImagePNGRepresentation(_selectedThirdPhotos[0]);
            [PicLick setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
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
                _firstPlaceLabel.text =@"";
            }
                break;
            case 1001:
            {
                _secondPlaceLabel.text =@"";

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
                _firstPlaceLabel.text =@"请输入文字...";
            }
                break;
            case 1001:
            {
                _secondPlaceLabel.text =@"请输入文字...";
            }
                break;
            default:
                break;
        }
    }
    return YES;
}
#pragma mark - textField 代理
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 102:
//            _TableView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height-271-64);
            break;
        default:
            break;
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    _TableView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height-64-49);
    [textField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - tableview 代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1)
    {
        return 330;
    }
    else
    {
        return 930;
    }
}

- (void)firstBtn:(UIButton *)button {
    NSLog(@"这里是第一张图片");
}
//
//
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;//260+
}

-(void)createNav
{
    
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"添加成果";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 40, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button2 setTitle:@"保存" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(AddAchieveClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)BaClick:(UIButton *)btn
{
    FbwManager *Manager = [FbwManager shareManager];
    Manager.IsListPulling = 3;
    Manager.PullPage = 3;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)AddAchieveClick:(UIButton *)btn1
{
//    button2.userInteractionEnabled = NO;
//    btn1.userInteractionEnabled = NO;
    [_TableView reloadData];
    
    UITextView *NumOneTextView = [self.view viewWithTag:1000];
    UITextView *NumTwoTextView = [self.view viewWithTag:1001];
    FbwManager *Manager        = [FbwManager shareManager];
    NSData *OneImageData       = UIImagePNGRepresentation(_selectedPhotos[0]);
    NSData *TwomageData        = UIImagePNGRepresentation(_selectedSecondPhotos[0]);
    NSData *ThirdImageData     = UIImagePNGRepresentation(_selectedThirdPhotos[0]);
    
    if (_nameTextField.text.length != 0)  {
        if (NumOneTextView.text.length != 0)  {
            if (NumTwoTextView.text.length != 0)  {
                if (_selectedPhotos.count !=       0) {
                    if (_selectedSecondPhotos.count != 0) {
                        if (_selectedThirdPhotos.count != 0)  {
                            button2.userInteractionEnabled = NO;
                            btn1.userInteractionEnabled = NO;
                            NSLog(@"你是不是炸了 你说啊！！！！！！！！！");
                            __weak typeof(self) weakSelf = self;
                            [SVProgressHUD showWithStatus:@"上传中"];
                            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkOrgId":Manager.UUserId,@"name":_nameTextField.text} url:UrL_AddOrgTeachResult success:^(id responseObject) {
                                NSDictionary *RootDic = [responseObject objectForKey:@"data"];
                                NSString *Str = [RootDic objectForKey:@"id"];
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    NSDictionary *Dict = @{@"fileType":@"image",
                                                        @"filePurpose":@"imageOrgResult",
                                                        @"fkPurposeId":Str};
                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                    [manager POST:UrL_UploadFile
                                       parameters:Dict
                                       constructingBodyWithBlock:
                                     ^(id<AFMultipartFormData>_Nonnull formData) {
                                         [formData appendPartWithFileData:OneImageData  name:@"uploadFile"
                                             fileName:@"OrgResultTeachFirst.png"
                                             mimeType:@"image/png"];
                                          }  progress:nil
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                  NSLog(@"图片上传成果啦");
                                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                              NSLog(@"图片上传出错啦");
                                          }];
                                });
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkResultId":Str,@"content":NumOneTextView.text} url:UrL_AddOrgTeachResultItem success:^(id responseObject) {
                                        NSDictionary *dict = [responseObject objectForKey:@"data"];
                                        NSString *SR = [dict objectForKey:@"id"];
                                            NSDictionary *Dict = @{@"fileType":@"image",
                                                                   @"filePurpose":@"imageOrgResultItem",
                                                                   @"fkPurposeId":SR};
                                            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                            [manager POST:UrL_UploadFile
                                               parameters:Dict
                                constructingBodyWithBlock:
                                             ^(id<AFMultipartFormData>_Nonnull formData) {
                                                 [formData appendPartWithFileData:ThirdImageData
                                                                             name:@"uploadFile"
                                                                         fileName:@"OrgResultTeachThird.png"
                                                                         mimeType:@"image/png"];
                                             }      progress:nil
                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                      
                                        
                                                      NSLog(@"图片上传成果啦");
                                                  }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                      NSLog(@"图片上传出错啦");
                                                  }];
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkResultId":Str,@"content":NumTwoTextView.text} url:UrL_AddOrgTeachResultItem success:^(id responseObject) {
                                                NSDictionary *dict = [responseObject objectForKey:@"data"];
                                                NSString *STR = [dict objectForKey:@"id"];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    NSDictionary *Dict = @{@"fileType":@"image",
                                                             @"filePurpose":@"imageOrgResultItem",
                                                                           @"fkPurposeId":STR};
                                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                    [manager POST:UrL_UploadFile
                                                       parameters:Dict
                                                       constructingBodyWithBlock:
                                                     ^(id<AFMultipartFormData>_Nonnull formData) {
                                                         [formData appendPartWithFileData:TwomageData  name:@"uploadFile"
                                                             fileName:@"OrgResultTeachSecond.png"
                                                             mimeType:@"image/png"];
                                                          }  progress:nil
                                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                  NSLog(@"图片上传成果啦");
                                                                 [SVProgressHUD dismiss];
                                                                 Manager.IsListPulling = 3;
                                                                  [weakSelf.navigationController popViewControllerAnimated:YES];
                                                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                              NSLog(@"图片上传出错啦");
                                                          }];
                                                });
                                                
                                            } failure:^(NSError *error) {
                                            }];
                                        });
                                        
                                    } failure:^(NSError *error) {
                                    }];
                                });
                            } failure:^(NSError *error) {
                            }];
                        }else{
                            [SVProgressHUD showErrorWithStatus:@"段落二图片不能为空"];
                        }
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"段落一图片不能为空"];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"成果首页图片不能为空"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"成果内容段落二不能为空"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"成果内容段落一不能为空"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"活动名称不能为空"];
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