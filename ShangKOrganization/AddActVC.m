//
//  AddActVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/9.
//  Copyright © 2016年 Fbw. All rights reserved.
//
#define MAX_STARWORDS_LENGTH 100
#import "AddActVC.h"
#import "SecondsTableViewCell.h"
#import "ZhengWenTableViewCell.h"
#import "AppDelegate.h"
#import "ThirdAddCell.h"
#import "ShelvesCourse.h"
#import "FbwManager.h"
//#import "TZImagePickerController.h"
#import <TZImagePickerController.h>
#import "UITextField+Extension.h"
#import "ShelvesModel.h"
#import "ShelvesCourseCell.h"
#import "ArrowView.h"
#import "PayMoneyOrderVC.h"

@interface AddActVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
{
    NSMutableArray *_selectedPhotos;
    UIImageView    *imageGa;
    ArrowView      *_arrowView;
    UIView         *TitleFootView;
    UILabel        *_FirstLabelNum;
    UILabel        *_SecondLabelNum;
}
@property(nonatomic,strong)UILabel     * activityName;
@property(nonatomic,strong)UITextField * nameTextField;
@property(nonatomic,strong)UIView      * firstView;
@property(nonatomic,strong)UILabel     * firstPlaceLabel;
@property(nonatomic,strong)UILabel     * secondPlaceLabel;
@property(nonatomic,strong)UILabel     * accountLabel;
@property(nonatomic,strong)UIButton    * resultBtn;
@end


@implementation AddActVC
{
    UIView                  * view;
    
    
    UIAlertController       * _alertActionSheet;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    _DataArray = [NSMutableArray array];
    FbwManager *Manager = [FbwManager shareManager];
    _DataArray =  Manager.AddActivityModelArray;
    [_tableView reloadData];
    NSLog(@"过来了%ld %@",(long)Manager.AddActivityModelArray.count,Manager.AddActivityModelArray);
//    [self createData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    self.view.backgroundColor= kAppGrayColor;
    _selectedPhotos = [NSMutableArray array];
    [self createNav];
    [self createTableView];
    [self createHeader];
}

//-(void)createData
//{NSLog(@"--%ld",(long)_DataArray.count);
//    for (NSDictionary *dic in _DataArray) {
//        ShelvesModel *Model= [[ShelvesModel alloc]init];
//        Model = _DataArray[0];
//        _DataArray[0].ShelvesName = [dic objectForKey:@"name"];
//        Model.ShelvesName = [dic objectForKey:@"name"];
//        NSLog(@"交啊%@",[dic objectForKey:@"name"]);
//        NSLog(@"交啊%@",[dic objectForKey:@"id"]);
//       
//        [Model setDic:dic];
//        [_DataArray addObject:Model];
//    }
//            
//    [_tableView reloadData];
//}

-(void)createHeader
{
    view                        = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,50)];
    [self.view addSubview:view];
    view.userInteractionEnabled = YES;
    view.backgroundColor        = kAppWhiteColor;
    _activityName               = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 80, 30)];
    _activityName.font          = [UIFont boldSystemFontOfSize:16];
    [view addSubview:_activityName];
    _activityName.text          = @"活动名称";
    _nameTextField              = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_activityName.frame)+10, 10, [UIScreen mainScreen].bounds.size.width-105, 30)];
    [view addSubview:_nameTextField];
    _nameTextField.placeholder  = @"请输入活动名称";
    _nameTextField.font         = [UIFont boldSystemFontOfSize:16];
    _nameTextField.ex_heightToKeyboard = 0;
    _nameTextField.ex_moveView = self.view;
    _firstView                  = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_activityName.frame)+10, kScreenWidth, 1)];
    [view addSubview:_firstView];
    _firstView.backgroundColor  = kAppLineColor;
    _tableView.tableHeaderView = view;
}
-(void)createTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[ZhengWenTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[SecondsTableViewCell class] forCellReuseIdentifier:@"secondCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [self CreateFootView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_DataArray.count != 0) {
        return 2+_DataArray.count;
    }else{
    return 3+_DataArray.count;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UIView *)CreateFootView
{
    UITextField *shareIncome     = [self.view viewWithTag:100];
    UITextField *maxCount        = [self.view viewWithTag:101];
//    NSLog(@"分享一次%.2f",[shareIncome.text doubleValue]);
//    NSLog(@"最多分享%d",[maxCount.text intValue]);
    TitleFootView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-44, kScreenWidth, 54)];
    TitleFootView.backgroundColor = kAppWhiteColor;
    _accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 140, 34)];
    [TitleFootView addSubview:_accountLabel];
    _accountLabel.text = [NSString stringWithFormat:@"总计:¥%.2f",[maxCount.text intValue] *[shareIncome.text doubleValue]];//[maxCount.text intValue] *[shareIncome.text doubleValue]
    _accountLabel.numberOfLines =0;
    _resultBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-100, 5, 100, 43)];
    [TitleFootView addSubview:_resultBtn];
    [_resultBtn setTitle:@"发布" forState:UIControlStateNormal];
    _resultBtn.tag = 5;
    [_resultBtn addTarget:self action:@selector(PicZeroClick:) forControlEvents:UIControlEventTouchUpInside];
    _resultBtn.backgroundColor = kAppBlueColor;
    
    return TitleFootView;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==1)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 20)];
        UILabel * lable1       = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 80, 20)];
        lable1.text            = @"悬赏分享";
        lable1.font            = [UIFont boldSystemFontOfSize:16];
        [imageView addSubview:lable1];
        return imageView;
    }
    else if(section == 0)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 20)];
        UILabel * lable2       = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 80, 20)];
        lable2.text            = @"活动内容";
        lable2.font            = [UIFont boldSystemFontOfSize:16];
        [imageView addSubview:lable2];
        return imageView;
    }else if(section == 2)
    {
       UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 20)];
       UILabel * lable3       = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 80, 20)];
       lable3.text            = @"相关课程";
       lable3.font            = [UIFont boldSystemFontOfSize:16];
       UIButton *btn          = [UIButton buttonWithType:UIButtonTypeCustom];
       btn.frame              = CGRectMake(kScreenWidth-40, 5, 20, 20);
       btn.tag                = 7;
       [btn setBackgroundImage:[UIImage imageNamed:@"添加-(1)@2x.png"] forState:UIControlStateNormal];
       [btn addTarget:self action:@selector(PicZeroClick:) forControlEvents:UIControlEventTouchUpInside];
       imageView.userInteractionEnabled = YES;
       [imageView addSubview:btn];
       [imageView addSubview:lable3];
       return imageView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3 || section == 4||section == 5) {
        return 5;
    }
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3 || section == 4||section == 5) {
        return 5;
    }
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    FbwManager *Manager = [FbwManager shareManager];
    if (indexPath.section==1) {
        SecondsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame] ;
            cell.selectedBackgroundView.backgroundColor = kAppWhiteColor;
        
        cell.firstTF.delegate  = self;
        cell.firstTF.tag       = 100;
        cell.firstTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        cell.firstTF.ex_heightToKeyboard = 0;
        cell.firstTF.ex_moveView = self.view;
        cell.secondTF.delegate = self;
        cell.secondTF.tag      = 101;
        cell.secondTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        cell.secondTF.ex_heightToKeyboard = 0;
        cell.secondTF.ex_moveView = self.view;
        cell.threeTF.delegate  = self;
        cell.threeTF.tag       = 102;
        cell.threeTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        cell.threeTF.ex_heightToKeyboard = 0;
        cell.threeTF.ex_moveView = self.view;
        
        return cell;
    }
    else if(indexPath.section == 0)
    {
       ZhengWenTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
       cell.selectedBackgroundView  = [[UIView alloc] initWithFrame:cell.frame] ;
       cell.selectedBackgroundView.backgroundColor = kAppWhiteColor;
       cell.firstButton.tag         = 10;
       cell.firstTextView.tag       = 1000;
       _firstPlaceLabel             = cell.activityName;
       cell.firstTextView.delegate  = self;
       [cell.firstButton addTarget:self action:@selector(PicZeroClick:) forControlEvents:UIControlEventTouchUpInside];
//        _FirstLabelNum = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-125, 90, 100, 20)];
        _SecondLabelNum = cell.FirstLabelNum;
       return cell;
   }
    ShelvesCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdCe"];
    if (!cell) {
        cell = [[ShelvesCourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdCe"];
    }
    if (_DataArray.count != 0) {
    imageGa.hidden = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.backgroundColor = kAppBlueColor;
    [startBtn setTitle:@"删除课程" forState:UIControlStateNormal];
    startBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [startBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    startBtn.frame = CGRectMake(kScreenWidth - 100, 105, 70, 40);
    startBtn.tag = indexPath.section-2;
    [startBtn addTarget:self action:@selector(DeleteZeroClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:startBtn];
    ShelvesModel *Model = _DataArray[indexPath.section-2];
    [cell configWithModel:Model];
    }else{
//        imageGa = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
//        imageGa.image = [UIImage imageNamed:@"哭脸.png"];
//        [cell.contentView addSubview:imageGa];
    }
    return cell;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    NSString  * nsTextContent = textView.text;
    NSInteger   existTextNum = [nsTextContent length];
    _SecondLabelNum.text = [NSString stringWithFormat:@"%ld/100",(long)0+existTextNum];
    if (existTextNum > 99) {
        _SecondLabelNum.text = @"100/100";
        [SVProgressHUD showErrorWithStatus:@"输入内容过长咯"];
    }
    //        NSLog(@"剩余：%ld",100-existTextNum);
    //        NSLog(@"剩余：%ld",0+existTextNum);
    NSString *toBeString               = textView.text;
    NSArray *current                   = [UITextInputMode activeInputModes];
    UITextInputMode *currentInputMode  = [current firstObject];
    NSString *lang = [currentInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange     = [textView markedTextRange];
        UITextPosition *position       = [textView positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (toBeString.length > MAX_STARWORDS_LENGTH)
            {
                NSRange rangeIndex     = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
                if (rangeIndex.length  == 1){
                    textView.text      = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
                }else{
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                    textView.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }else{
        }
    }else {
        if (toBeString.length > MAX_STARWORDS_LENGTH){
            NSRange rangeIndex     = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length  == 1){
                textView.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }else{
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textView.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

-(void)DeleteZeroClick:(UIButton *)Delete
{
    ShelvesModel *Model = _DataArray[Delete.tag];
    __weak typeof(self) weakSelf = self;
        _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
        [_arrowView setBackgroundColor:[UIColor clearColor]];
        [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定要开始删除课程吗？"];
        [_arrowView setSelectBlock:^(UIButton *button){
            if (button.tag == 10) {
            }else if (button.tag == 11){
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"courseId":Model.ShelvesId} url:UrL_DeleteCourse success:^(id responseObject) {
//                    [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.DataArray removeObject:weakSelf.DataArray[Delete.tag]];
                        [weakSelf.tableView reloadData];
//                        [weakSelf createTableView];
                    });
                } failure:^(NSError *error) {
                }];
            }
        }];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
        [_arrowView showArrowView:YES];

}
-(void)PicZeroClick:(UIButton *)button
{
    
    switch (button.tag) {
            case 5:
        {
            
            FbwManager *Manager          = [FbwManager shareManager];
            UITextView *textView         = [self.view viewWithTag:1000];
            UITextField *shareIncome     = [self.view viewWithTag:100];
            UITextField *maxCount        = [self.view viewWithTag:101];
            UITextField *ShareCount      = [self.view viewWithTag:102];
            __weak typeof(self) weakSelf = self;
            if (textView.text.length        != 0) {
                if (_nameTextField.text.length  != 0) {
                    if (_selectedPhotos.count      != 0) {
                         if (_DataArray.count        != 0) {
                              if ([shareIncome.text isEqualToString:@"0"]|| shareIncome.text.length == 0 ||[shareIncome.text isKindOfClass:[NSNull class]]) {
                                  button.userInteractionEnabled = NO;
                                      [SVProgressHUD showWithStatus:@"上传中"];
                                        NSMutableArray *arr = [NSMutableArray array];
                                        for (ShelvesModel *Model in _DataArray) {
                                            [arr addObject:Model.ShelvesId];
                                        }
                                        NSString *str = [arr componentsJoinedByString:@","];
                                        NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                                        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkOrgId":Manager.UUserId,@"name":_nameTextField.text,@"content":textView.text,@"courseList":str} url:UrL_AddActivity success:^(id responseObject) {
                                            NSDictionary *RootDic = [responseObject objectForKey:@"data"];
                                            NSString *Str = [RootDic objectForKey:@"id"];
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"idValue":Str,@"shareType":@"shareOrgActivity",@"fkOrgId":Manager.UUserId} url:UrL_AddShareCommon success:^(id responseObject) {
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        NSDictionary *Dict = @{@"fileType":@"image",
                                                                               @"filePurpose":@"imageOrgActivity",
                                                                               @"fkPurposeId":Str};
                                                        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                        [manager POST:UrL_UploadFile
                                                           parameters:Dict
                                                         constructingBodyWithBlock:
                                                         ^(id<AFMultipartFormData>_Nonnull formData) {
                                                             [formData appendPartWithFileData:imageData
                                                                                         name:@"uploadFile"
                                                                                     fileName:@"OrgActivity.png"
                                                                                     mimeType:@"image/png"];
                                                         } progress:nil
                                                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                  [SVProgressHUD dismiss];
                                                                  Manager.IsListPulling = 3;
                                                                  [weakSelf.navigationController popViewControllerAnimated:YES];
                                                                  NSLog(@"图片上传成功啦");
                                                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                  NSLog(@"图片上传出错啦");
                                                              }];
//                                                        [self.navigationController popViewControllerAnimated:YES];
                                                    });
                                                } failure:^(NSError *error) {
                                                }];
                                            });
                                            
                                        } failure:^(NSError *error) {
                                        }];
                                        }else{
                                            button.userInteractionEnabled = NO;
                                            NSMutableArray *arr = [NSMutableArray array];
                                            for (ShelvesModel *Model in _DataArray) {
                                                [arr addObject:Model.ShelvesId];
                                            }
                                            [SVProgressHUD showWithStatus:@"上传中"];
                                            NSString *str = [arr componentsJoinedByString:@","];
                                            NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
//                                            NSLog(@"你妹的%@",Manager.UUserId);
                                            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkOrgId":Manager.UUserId,@"name":_nameTextField.text,@"content":textView.text,@"courseList":str} url:UrL_AddActivity success:^(id responseObject) {
                                                NSDictionary *RootDic = [responseObject objectForKey:@"data"];
                                                NSString *Str = [RootDic objectForKey:@"id"];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"idValue":Str,@"shareType":@"shareOrgActivity",@"shareCount":[NSString stringWithFormat:@"%d",[ShareCount.text intValue]],@"maxCount":[NSString stringWithFormat:@"%d",[maxCount.text intValue]],@"shareIncome":[NSString stringWithFormat:@"%.2f",[shareIncome.text floatValue]],@"fkOrgId":Manager.UUserId} url:UrL_AddShareCommon success:^(id responseObject) {
                                                        NSDictionary *DRict = [responseObject objectForKey:@"data"];
                                                        NSString *OrderId = [DRict objectForKey:@"id"];
                                                        PayMoneyOrderVC *Order = [[PayMoneyOrderVC alloc]init];
                                                        Order.PayMoneyChoose = @"AddActivity";
                                                        Order.OrderId = OrderId;
                                                        Order.SumPrice = [maxCount.text intValue] *[shareIncome.text doubleValue];
//                                                        NSLog(@"你看要交多少钱%.2f",Order.SumPrice);
                                                        [SVProgressHUD dismiss];
                                                        [weakSelf.navigationController pushViewController:Order animated:YES];
                                                        
                                                    } failure:^(NSError *error) {
                                                    }];
                                                });
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    NSDictionary *Dict = @{@"fileType":@"image",
                                                                           @"filePurpose":@"imageOrgActivity",
                                                                           @"fkPurposeId":Str};
                                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                    [manager POST:UrL_UploadFile
                                                       parameters:Dict
                                                     constructingBodyWithBlock:
                                                     ^(id<AFMultipartFormData>_Nonnull formData) {
                                                         [formData appendPartWithFileData:imageData
                                                                                     name:@"uploadFile"
                                                                                 fileName:@"OrgActivity.png"
                                                                                 mimeType:@"image/png"];
                                                     } progress:nil
                                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                              
                                                              NSLog(@"图片上传成功啦");
                                                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                              NSLog(@"图片上传出错啦");
                                                          }];
//                                                    [self.navigationController popViewControllerAnimated:YES];
                                                });
                                            } failure:^(NSError *error) {
                                            }];
                                        }
                                    }else{
                                        [SVProgressHUD showErrorWithStatus:@"请添加相关课程"];
                                    }
                                }else{
                                  [SVProgressHUD showErrorWithStatus:@"段落一图片不能为空"];
                             }
                     }else{
                       [SVProgressHUD showErrorWithStatus:@"活动名称不能为空"];
                 }
               }else{
                   [SVProgressHUD showErrorWithStatus:@"活动段落一内容不能为空"];
             }
          }
            break;
            case 7:
        {
            NSLog(@"你点击了相关课程➕按钮");
            ShelvesCourse *course = [[ShelvesCourse alloc]init];
            [self.navigationController pushViewController:course animated:YES];
        }
            break;
            case 8:
        {
            NSLog(@"你点击了第一分区的发布按钮");
        }
            break;
        case 10:
        {
            NSLog(@"这是第0分区的第一个图片");
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *photosArr ,BOOL isSelectOriginalPhoto) {
                _selectedPhotos = [NSMutableArray arrayWithArray:photos];
                NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                [button setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
            break;
        default:
            break;
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
                _firstPlaceLabel.text =@"";
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
//             _tableView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height-271-64);
            break;
        default:
            break;
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    UITextField *shareIncome     = [self.view viewWithTag:100];
    UITextField *maxCount        = [self.view viewWithTag:101];
//    NSLog(@"分享一次%.2f",[shareIncome.text doubleValue]);
//    NSLog(@"最多分享%d",[maxCount.text intValue]);
    _accountLabel.text = [NSString stringWithFormat:@"总计:¥%.2f",[maxCount.text intValue] *[shareIncome.text doubleValue]];
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
        return 300;
    }
    else if(indexPath.section == 0)
    {
        return 360;
    }
        return 150;
}

- (void)firstBtn:(UIButton *)button {
    NSLog(@"这里是第一张图片");
}

//-(void)setAlertActionSheet
//{
//    _alertActionSheet = [UIAlertController alertControllerWithTitle:@"添加图片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self presentViewController:_picker animated:YES completion:nil];
//    }];
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//        {
//            _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//            [self presentViewController:_picker animated:YES completion:nil];
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有相机功能" message:@"请换一个设备使用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//            [alert show];
//            return;
//        }
//    }];
//    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    
//    [_alertActionSheet addAction:action1];
//    [_alertActionSheet addAction:action2];
//    [_alertActionSheet addAction:action3];
//    [self presentViewController:_alertActionSheet animated:YES completion:nil];
//}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
//{
////    [_firstButton setImage:image forState:UIControlStateNormal];
////    [_picker dismissViewControllerAnimated:YES completion:nil];
//}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label    = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth- 70)/2, 10, 70, 30)];
    label.text        = @"添加活动";
    label.font        = [UIFont boldSystemFontOfSize:16];
    label.textColor   = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame     = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
    
}

-(void)BaCklick:(UIButton *)brn
{
    FbwManager *Manager = [FbwManager shareManager];
    Manager.IsListPulling = 3;
    Manager.PullPage = 3;
    [self.navigationController popViewControllerAnimated:YES];
}


@end
