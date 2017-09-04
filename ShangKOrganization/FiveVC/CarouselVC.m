//
//  CarouselVC.m
//  ShangKOrganization
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "CarouselVC.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "AppDelegate.h"
#import <TZImagePickerController.h>
#import "TZTestCell.h"
#import "LxGridViewFlowLayout.h"
#import "TZImageManager.h"
#import "UIView+Layout.h"
#import "LookPhotoViewController.h"
@interface CarouselVC ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *_selectedPhotos;
    CGFloat         _itemWH;
    CGFloat         _margin;
    NSMutableArray *_selectedAssets;
    UIButton       *button2;
}
@property (nonatomic, strong)  UIImagePickerController *imagePickerVc;
@property (nonatomic, strong)  UICollectionView *collectionView;
@property (nonatomic,strong)   UIImageView *photoimage;
@end
@implementation CarouselVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    [self createNav];
    [self createUI];
    self.view.backgroundColor = kAppWhiteColor;
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

-(void)createUI
{
    UILabel *LianLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 79, kScreenWidth-200, 20)];
    LianLabel.backgroundColor = kAppClearColor;
    LianLabel.text = @"请上传1-3张轮播图片";
    LianLabel.textColor = kAppLineColor;
    LianLabel.textAlignment = NSTextAlignmentCenter;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(LianLabel.frame)+15, self.view.tz_width, kScreenHeight/2.5) collectionViewLayout:layout];
    CGFloat rgb = 244 / 255.0;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = kAppWhiteColor;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    
    [self.view addSubview:LianLabel];
    [self.view addSubview:_collectionView];
}

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

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 110)/2, 10, 110, 30)];
    label.text = @"上传轮播图片";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 40, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button2 setTitle:@"保存" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(BCClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)BCClick:(UIButton *)Btn
{
    NSLog(@"保存");
    __weak typeof(self) weakSelf = self;
    FbwManager *Manager = [FbwManager shareManager];
    if (_selectedPhotos.count      != 0) {
        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId} url:UrL_MyOrgDetails success:^(id responseObject) {
            NSDictionary *RootDic = [responseObject objectForKey:@"data"];
            NSString *FkUserId = [RootDic objectForKey:@"fkUserId"];
            [SVProgressHUD showWithStatus:@"上传中"];
            if (_selectedPhotos.count == 1) {
                button2.userInteractionEnabled = NO;
                Btn.userInteractionEnabled = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary *Dict = @{@"fileType":@"image",
                                           @"filePurpose":@"imageOrgCarousel",
                                           @"fkPurposeId":FkUserId};
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    [manager POST:UrL_UploadFile
                       parameters:Dict
        constructingBodyWithBlock:
                     ^(id<AFMultipartFormData>_Nonnull formData) {
                         NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                         [formData appendPartWithFileData:imageData
                                                     name:@"uploadFile"
                                                 fileName:[NSString stringWithFormat:@"imageOrgCarousel0.png"]
                                                 mimeType:@"image/png"];
                         
                     }progress:nil
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              NSLog(@"图片上传成果啦");
                              [SVProgressHUD dismiss];
                              [weakSelf.navigationController popViewControllerAnimated:YES];
                              
                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                              NSLog(@"图片上传出错啦");
                          }];
                });
            }else if (_selectedPhotos.count == 2){
                button2.userInteractionEnabled = NO;
                Btn.userInteractionEnabled = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary *Dict = @{@"fileType":@"image",
                                           @"filePurpose":@"imageOrgCarousel",
                                           @"fkPurposeId":FkUserId};
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    [manager POST:UrL_UploadFile
                       parameters:Dict
        constructingBodyWithBlock:
                     ^(id<AFMultipartFormData>_Nonnull formData) {
                         //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                         NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                         [formData appendPartWithFileData:imageData
                                                     name:@"uploadFile"
                                                 fileName:[NSString stringWithFormat:@"imageOrgCarousel0.png"]
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
                                           @"filePurpose":@"imageOrgCarousel",
                                           @"fkPurposeId":FkUserId};
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    [manager POST:UrL_UploadFile
                       parameters:Dict
        constructingBodyWithBlock:
                     ^(id<AFMultipartFormData>_Nonnull formData) {
                         //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                         NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[1]);
                         [formData appendPartWithFileData:imageData
                                                     name:@"uploadFile"
                                                 fileName:[NSString stringWithFormat:@"imageOrgCarousel1.png"]
                                                 mimeType:@"image/png"];
                         //                                 }
                     }progress:nil
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              NSLog(@"图片上传成果啦");
                              [SVProgressHUD dismiss];
                              [weakSelf.navigationController popViewControllerAnimated:YES];
                              
                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                              NSLog(@"图片上传出错啦");
                          }];
                });
            }else if (_selectedPhotos.count == 3){
                button2.userInteractionEnabled = NO;
                Btn.userInteractionEnabled = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary *Dict = @{@"fileType":@"image",
                                           @"filePurpose":@"imageOrgCarousel",
                                           @"fkPurposeId":FkUserId};
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    [manager POST:UrL_UploadFile
                       parameters:Dict
        constructingBodyWithBlock:
                     ^(id<AFMultipartFormData>_Nonnull formData) {
                         //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                         NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                         [formData appendPartWithFileData:imageData
                                                     name:@"uploadFile"
                                                 fileName:[NSString stringWithFormat:@"imageOrgCarousel0.png"]
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
                                           @"filePurpose":@"imageOrgCarousel",
                                           @"fkPurposeId":FkUserId};
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    [manager POST:UrL_UploadFile
                       parameters:Dict
        constructingBodyWithBlock:
                     ^(id<AFMultipartFormData>_Nonnull formData) {
                         //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                         NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[1]);
                         [formData appendPartWithFileData:imageData
                                                     name:@"uploadFile"
                                                 fileName:[NSString stringWithFormat:@"imageOrgCarousel1.png"]
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
                                           @"filePurpose":@"imageOrgCarousel",
                                           @"fkPurposeId":FkUserId};
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    [manager POST:UrL_UploadFile
                       parameters:Dict
        constructingBodyWithBlock:
                     ^(id<AFMultipartFormData>_Nonnull formData) {
                         //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                         NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[2]);
                         [formData appendPartWithFileData:imageData
                                                     name:@"uploadFile"
                                                 fileName:[NSString stringWithFormat:@"imageOrgCarousel2.png"]
                                                 mimeType:@"image/png"];
                         //                                 }
                     }progress:nil
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              NSLog(@"图片上传成果啦");
                              [SVProgressHUD dismiss];
                              [weakSelf.navigationController popViewControllerAnimated:YES];
                              
                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                              NSLog(@"图片上传出错啦");
                          }];
                });
            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSDictionary *Dict = @{@"fileType":@"image",
//                                       @"filePurpose":@"imageOrgCarousel",
//                                       @"fkPurposeId":FkUserId};
//                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//                [manager POST:UrL_UploadFile
//                   parameters:Dict
//                   constructingBodyWithBlock:
//                 ^(id<AFMultipartFormData>_Nonnull formData) {
//                     for (int i = 0; i<_selectedPhotos.count; i++) {
//                         NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[i]);
//                         [formData appendPartWithFileData:imageData
//                                                     name:@"uploadFile"
//                                                 fileName:[NSString stringWithFormat:@"imageOrgCarousel%d.png",i]
//                                                 mimeType:@"image/png"];
//                          }
//                       }progress:nil
//                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////                          [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
//                          NSLog(@"图片上传成果啦");
//                          [weakSelf.navigationController popViewControllerAnimated:YES];
//                          
//                      }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                          NSLog(@"图片上传出错啦");
//                      }];
//            });
        } failure:^(NSError *error) {
            
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请至少上传一张轮播图片"];
    }
}

-(void)BaCklick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
