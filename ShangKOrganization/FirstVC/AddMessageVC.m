//
//  AddMessageVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//
#define MAX_STARWORDS_LENGTH 200
#import "AddMessageVC.h"
#import "UIView+Layout.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "AppDelegate.h"
#import <TZImagePickerController.h>
#import "TZTestCell.h"
#import "LxGridViewFlowLayout.h"
#import "TZImageManager.h"
#import "LookPhotoViewController.h"
#import "UITextField+Extension.h"
@interface AddMessageVC ()<UITextViewDelegate,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    NSMutableArray *_selectedPhotos;
    CGFloat         _itemWH;
    CGFloat         _margin;
    NSMutableArray *_selectedAssets;
    UILabel        * _FirstLabelNum;
    UITextView     * _firstTextView;
    UILabel        * _activityName;
    UITextField    * ActivitMess;
    UIButton       *button2;
}
@property (nonatomic, strong)  UIImagePickerController *imagePickerVc;
@property (nonatomic, strong)  UICollectionView *collectionView;
@property (nonatomic,strong)   UIImageView *photoimage;
@end

@implementation AddMessageVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    self.view.backgroundColor = KAppBackBgColor;
    [self createHeadView];
}

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}


-(void)createHeadView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 50)];
    headView.backgroundColor = kAppWhiteColor;
    headView.userInteractionEnabled = YES;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 20)];
    label.text = @"标题";
    label.font = [UIFont systemFontOfSize:17];
    ActivitMess = [[UITextField alloc]initWithFrame:CGRectMake(75, 10, kScreenWidth - 100, 20)];
    ActivitMess.placeholder = @"请输入活动名称";
    ActivitMess.delegate = self;
    ActivitMess.ex_heightToKeyboard = 0;
    ActivitMess.ex_moveView = self.view;
    ActivitMess.adjustsFontSizeToFitWidth = YES;
    ActivitMess.clearsOnBeginEditing = NO;
    UILabel *ZutLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(headView.frame)+6, 50, 30)];
    ZutLabel.text = @"内容";
    ZutLabel.textAlignment = NSTextAlignmentLeft;
    ZutLabel.font = [UIFont systemFontOfSize:17];
    
    _firstTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(ZutLabel.frame)+6, kScreenWidth, 200)];
    _firstTextView.backgroundColor = kAppWhiteColor;
    _firstTextView.tag = 10;
    //    _firstTextView. = 1;
    _firstTextView.delegate = self;
    _activityName = [[UILabel alloc]initWithFrame:CGRectMake(6, CGRectGetMaxY(ZutLabel.frame)+6, 150, 30)];
    _activityName.text = @"请输入文字...";
    _activityName.font = [UIFont systemFontOfSize:15];
    _activityName.textColor = [UIColor lightGrayColor];
    UILabel *PicLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_firstTextView.frame)+10,kScreenWidth - 100, 20)];
    PicLabel.text = @"添加图片(最多上传3张图片)";
    PicLabel.font = [UIFont systemFontOfSize:17];
    _FirstLabelNum = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-110, 170, 100, 20)];
    _FirstLabelNum.textAlignment = NSTextAlignmentCenter;
    _FirstLabelNum.font = [UIFont systemFontOfSize:16];
    _FirstLabelNum.text = @"0/200";

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(PicLabel.frame)+20, self.view.tz_width, kScreenHeight/2.5) collectionViewLayout:layout];
    CGFloat rgb = 244 / 255.0;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = KAppBackBgColor;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    
   
    
    [_firstTextView addSubview:_FirstLabelNum];
    [self.view addSubview:PicLabel];
    [headView addSubview:label];
    [self.view addSubview:_firstTextView];
    [self.view addSubview:_activityName];
    [self.view addSubview:ZutLabel];
    [headView addSubview:ActivitMess];
    [self.view addSubview:headView];
    [self.view addSubview:_collectionView];

}

#pragma mark --------照片------

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(_selectedPhotos.count+1 <= 3)
    {
        return _selectedPhotos.count+1;
    }
    else
    {
        return 3;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    if(indexPath.item == _selectedPhotos.count)
    {
        cell.imageView.image = [UIImage imageNamed:@"矩形-2-拷贝@2x.png"];
        cell.deleteBtn.hidden = YES;
    }
    else
    {
        cell.imageView.image = _selectedPhotos[indexPath.item];
        [cell.deleteBtn addTarget:self action:@selector(deletepic:) forControlEvents:UIControlEventTouchUpInside];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = 200 + indexPath.item;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.item == _selectedPhotos.count)
    {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
            
        }];
        
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            _imagePickerVc = [[UIImagePickerController alloc] init];
            _imagePickerVc.delegate = self;
            _imagePickerVc.allowsEditing = YES;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                _imagePickerVc.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        }];
        
        UIAlertAction *picture = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            TZImagePickerController *TZvc = [[TZImagePickerController alloc]initWithMaxImagesCount:3 delegate:self];
            [self presentViewController:TZvc animated:YES completion:nil];
        }];
        [alertVc addAction:cancle];
        [alertVc addAction:picture];
        [alertVc addAction:camera];
        [self presentViewController:alertVc animated:YES completion:nil];
    }
    else
    {
        UIImageView *image = [[UIImageView alloc]initWithImage:_selectedPhotos[indexPath.row]];
        LookPhotoViewController *look = [[LookPhotoViewController alloc]init];
        look.image = image;
        [self.navigationController pushViewController:look animated:YES];
    }
}

-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    [_selectedPhotos addObjectsFromArray:photos];
    [_selectedAssets addObjectsFromArray:assets];
    if(_selectedPhotos.count > 3)
    {
        for(int i =3 ; i < _selectedPhotos.count; i++)
        {
            [_selectedPhotos removeObjectAtIndex:i];
        }
    }
    if(_selectedPhotos.count == 4)
    {
        [_selectedPhotos removeLastObject];
    }
    [_collectionView reloadData];
    if(_selectedAssets.count > 3)
    {
        for(int i =3 ; i < _selectedAssets.count; i++)
        {
            [_selectedAssets removeObjectAtIndex:i];
        }
    }
    if(_selectedAssets.count == 4)
    {
        [_selectedAssets removeLastObject];
    }
}
-(void)deletepic:(UIButton*)btn
{
    NSInteger i = btn.tag - 200;
    [_selectedPhotos removeObjectAtIndex:i];
    [_collectionView reloadData];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"选择完成");
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        _photoimage = [[UIImageView alloc]init];
        _photoimage.image = info[UIImagePickerControllerEditedImage];
        if(_selectedPhotos.count<3)
        {
            [_selectedPhotos addObject:info[UIImagePickerControllerEditedImage]];
        }
        UIImageWriteToSavedPhotosAlbum(_photoimage.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }
}

- (void) image: (UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInf{
    [_collectionView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark --------TextViewDelegate------
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

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
            case 10:
            {
                _activityName.text =@"";
            }
                break;
            default:
                break;
        }
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        switch (textView.tag) {
            case 10:
            {
                _activityName.text =@"请输入文字";
            }
                break;
            default:
                break;
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    NSString  * nsTextContent = textView.text;
    NSInteger   existTextNum = [nsTextContent length];
    _FirstLabelNum.text = [NSString stringWithFormat:@"%ld/200",(long)0+existTextNum];
    if (existTextNum > 199) {
        _FirstLabelNum.text = @"200/200";
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
#pragma mark --------TextViewDelegate------

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)createNav
{
    UIView *NavBarview         = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label        = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text            = @"消息推送";
    label.font            = [UIFont boldSystemFontOfSize:16];
    label.textColor       = kAppWhiteColor;
    UIButton *button1     = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    button2       = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame           = CGRectMake(kScreenWidth - 50, 10, 40, 30);
    [button2 setTitle:@"发布" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:15];
    [button2 addTarget:self action:@selector(BtnMessClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
    
}
//发布
-(void)BtnMessClick:(UIButton *)BtnMess
{
    __weak typeof(self) weakSelf = self;
    FbwManager *Manager         = [FbwManager shareManager];
//    NSLog(@"标题%@",ActivitMess.text);
//    NSLog(@"内容%@",_firstTextView.text);
    if (ActivitMess.text.length != 0) {
        if (_firstTextView.text.length != 0) {
            if (_selectedPhotos.count      != 0) {
                button2.userInteractionEnabled = NO;
                BtnMess.userInteractionEnabled = NO;
                [SVProgressHUD showWithStatus:@"上传中"];
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkOrgId":Manager.UUserId,@"title":ActivitMess.text,@"fkOrgNotice":_firstTextView.text} url:UrL_SendPushMessage success:^(id responseObject) {
                    NSDictionary *RootDic = [responseObject objectForKey:@"data"];
                    NSString *STRId = [RootDic objectForKey:@"id"];
                    if (_selectedPhotos.count == 1) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSDictionary *Dict = @{@"fileType":@"image",
                                                   @"filePurpose":@"imageMessageOrgNotice",
                                                   @"fkPurposeId":STRId};
                            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                            [manager POST:UrL_UploadFile
                               parameters:Dict
                constructingBodyWithBlock:
                             ^(id<AFMultipartFormData>_Nonnull formData) {
                                 NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                                 [formData appendPartWithFileData:imageData
                                                             name:@"uploadFile"
                                                         fileName:[NSString stringWithFormat:@"imageMessageOrgNotice0.png"]
                                                         mimeType:@"image/png"];
                                
                             }progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      NSLog(@"图片上传成果啦");
                                      [SVProgressHUD dismiss];
                                      Manager.IsListPulling = 3;
                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                      
                                  }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      NSLog(@"图片上传出错啦");
                                  }];
                        });
                    }else if (_selectedPhotos.count == 2){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSDictionary *Dict = @{@"fileType":@"image",
                                                   @"filePurpose":@"imageMessageOrgNotice",
                                                   @"fkPurposeId":STRId};
                            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                            [manager POST:UrL_UploadFile
                               parameters:Dict
                constructingBodyWithBlock:
                             ^(id<AFMultipartFormData>_Nonnull formData) {
                                 //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                 NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                                 [formData appendPartWithFileData:imageData
                                                             name:@"uploadFile"
                                                         fileName:[NSString stringWithFormat:@"imageMessageOrgNotice0.png"]
                                                         mimeType:@"image/png"];
                                 //                                 }
                             }progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      NSLog(@"图片上传成果啦");
//                                      [SVProgressHUD dismiss];
//                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                      
                                  }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      NSLog(@"图片上传出错啦");
                                  }];
                        });
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSDictionary *Dict = @{@"fileType":@"image",
                                                   @"filePurpose":@"imageMessageOrgNotice",
                                                   @"fkPurposeId":STRId};
                            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                            [manager POST:UrL_UploadFile
                               parameters:Dict
                constructingBodyWithBlock:
                             ^(id<AFMultipartFormData>_Nonnull formData) {
                                 //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                 NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[1]);
                                 [formData appendPartWithFileData:imageData
                                                             name:@"uploadFile"
                                                         fileName:[NSString stringWithFormat:@"imageMessageOrgNotice1.png"]
                                                         mimeType:@"image/png"];
                                 //                                 }
                             }progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      NSLog(@"图片上传成果啦");
                                      [SVProgressHUD dismiss];
                                      Manager.IsListPulling = 3;
                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                      
                                  }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      NSLog(@"图片上传出错啦");
                                  }];
                        });
                    }else if (_selectedPhotos.count == 3){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSDictionary *Dict = @{@"fileType":@"image",
                                                   @"filePurpose":@"imageMessageOrgNotice",
                                                   @"fkPurposeId":STRId};
                            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                            [manager POST:UrL_UploadFile
                               parameters:Dict
                constructingBodyWithBlock:
                             ^(id<AFMultipartFormData>_Nonnull formData) {
                                 //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                 NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                                 [formData appendPartWithFileData:imageData
                                                             name:@"uploadFile"
                                                         fileName:[NSString stringWithFormat:@"imageMessageOrgNotice0.png"]
                                                         mimeType:@"image/png"];
                                 //                                 }
                             }progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      NSLog(@"图片上传成果啦");
//                                      [SVProgressHUD dismiss];
//                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                      
                                  }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      NSLog(@"图片上传出错啦");
                                  }];
                        });
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSDictionary *Dict = @{@"fileType":@"image",
                                                   @"filePurpose":@"imageMessageOrgNotice",
                                                   @"fkPurposeId":STRId};
                            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                            [manager POST:UrL_UploadFile
                               parameters:Dict
                constructingBodyWithBlock:
                             ^(id<AFMultipartFormData>_Nonnull formData) {
                                 //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                 NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[1]);
                                 [formData appendPartWithFileData:imageData
                                                             name:@"uploadFile"
                                                         fileName:[NSString stringWithFormat:@"imageMessageOrgNotice1.png"]
                                                         mimeType:@"image/png"];
                                 //                                 }
                             }progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      NSLog(@"图片上传成果啦");
//                                      [SVProgressHUD dismiss];
//                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                      
                                  }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      NSLog(@"图片上传出错啦");
                                  }];
                        });
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSDictionary *Dict = @{@"fileType":@"image",
                                                   @"filePurpose":@"imageMessageOrgNotice",
                                                   @"fkPurposeId":STRId};
                            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                            [manager POST:UrL_UploadFile
                               parameters:Dict
                constructingBodyWithBlock:
                             ^(id<AFMultipartFormData>_Nonnull formData) {
                                 //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                 NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[2]);
                                 [formData appendPartWithFileData:imageData
                                                             name:@"uploadFile"
                                                         fileName:[NSString stringWithFormat:@"imageMessageOrgNotice2.png"]
                                                         mimeType:@"image/png"];
                                 //                                 }
                             }progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      NSLog(@"图片上传成果啦");
                                      [SVProgressHUD dismiss];
                                      Manager.IsListPulling = 3;
                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                      
                                  }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      NSLog(@"图片上传出错啦");
                                  }];
                        });
                    }
                   } failure:^(NSError *error) {
                           NSLog(@"发送失败");
                  }];
            }else{
                [SVProgressHUD showErrorWithStatus:@"请添加图片"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"内容不能为空"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"标题不能为空"];
    }
}

-(void)BaCklick:(UIButton *)BaBtn
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
