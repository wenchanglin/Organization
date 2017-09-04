//
//  Addobject.m
//  ShangKOrganization
//
//  Created by apple on 16/9/9.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "Addobject.h"
#import "AddObjectCell.h"
#import "AddObjeTwoCell.h"
#import "LunBoPicTableViewCell.h"
#import "AppDelegate.h"
#import "UITextField+Extension.h"
#import "ListOfTeachersVC.h"
#import "UIView+Layout.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <TZImagePickerController.h>
#import "TZTestCell.h"
#import "LxGridViewFlowLayout.h"
#import "TZImageManager.h"
#import "FbwManager.h"
#import "LookPhotoViewController.h"
#import "ListOfTeachersModel.h"
#import "PayMoneyOrderVC.h"
@interface Addobject ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    NSString *TEacherId;
}
//    TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate>//SDCycleScrollViewDelegate

@property(nonatomic,strong)UILabel  * activityName;
@property(nonatomic,strong)UITextField * nameTextField;
@property(nonatomic,strong)UILabel  * activityHome;
@property(nonatomic,strong)UILabel  * activitySecondHome;
@property(nonatomic,strong)UIButton * firstButton;
@property(nonatomic,strong)UIView   * firstView;
@property(nonatomic,strong)UILabel  * firstPlaceLabel;
@property(nonatomic,strong)UILabel  * secondPlaceLabel;
@property (nonatomic,strong) UIImageView *photoimage;


@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UITextField      *maxCountTF; ///< 照片最大可选张数，设置为1即为单选模式
@property (strong, nonatomic) UITextField      *columnNumberTF;
@end


@implementation Addobject
{
    UIView         *view;
    UIButton       *button2;
    UITableView    *_tableView;
    NSMutableArray *_selectedPhotos;
    CGFloat         _itemWH;
    CGFloat         _margin;
    NSMutableArray *_selectedAssets;
    BOOL            _isSelectOriginalPhoto;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    FbwManager *Manager =[FbwManager shareManager];
    if (Manager.TeacherArray.count == 0) {
        
    }else{
        [_tableView reloadData];
    }
    NSLog(@"过来了%@",Manager.TeacherArray);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= kAppGrayColor;
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    [self createNav];
    [self createTableView];
    [self createHeader];
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

-(void)createHeader
{
    view                 = [[UIView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width,60)];
    [self.view addSubview:view];
    view.userInteractionEnabled = YES;
    view.backgroundColor = kAppWhiteColor;
    _activityName        = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 80, 30)];
    _activityName.font   = [UIFont systemFontOfSize:17];
    [view addSubview:_activityName];
    _activityName.text   = @"课程名称";
    
    _nameTextField       = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_activityName.frame)+10, 10, [UIScreen mainScreen].bounds.size.width-105, 30)];
    [view addSubview:_nameTextField];
    _nameTextField.placeholder = @"请输入课程名称";
    _nameTextField.delegate =self;
    _nameTextField.tag   = 10000;
    _nameTextField.font  = [UIFont systemFontOfSize:16];
    _tableView.tableHeaderView = view;
    _nameTextField.ex_heightToKeyboard = 0;
    _nameTextField.ex_moveView = self.view;
}
-(void)createTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height  - 44) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [self createCollectionView];
    [_tableView registerClass:[AddObjeTwoCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[AddObjectCell  class] forCellReuseIdentifier:@"secondCell"];
//    [_tableView registerClass:[LunBoPicTableViewCell class] forCellReuseIdentifier:@"LBCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(UIView *)createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame)+10, self.view.tz_width, (kScreenWidth/3)*2+20) collectionViewLayout:layout];
    CGFloat rgb = 244 / 255.0;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = KAppBackBgColor;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    return _collectionView;
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
    NSLog(@"选择照片张数%lu",(unsigned long)_selectedPhotos.count);
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==1)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 20)];
        UILabel * lable1       = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 80, 20)];
        lable1.text            = @"任课教师";
        lable1.font            = [UIFont systemFontOfSize:16];
        [imageView addSubview:lable1];
        return imageView;
    }
    else if(section == 0)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 20)];
        UILabel * lable2       = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 80, 20)];
        lable2.text            = @"基本信息";
        lable2.font            = [UIFont systemFontOfSize:16];
        [imageView addSubview:lable2];
        return imageView;
    }else if(section == 2)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 20)];
        UILabel * lable3       = [[UILabel alloc]initWithFrame:CGRectMake(15, 3, kScreenWidth-30, 20)];
        lable3.text            = @"轮播图片(请上传1~3张图片)";
        lable3.font            = [UIFont systemFontOfSize:16];
        [imageView addSubview:lable3];
        return imageView;
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FbwManager *Manager =[FbwManager shareManager];
    if (indexPath.section==1) {
        AddObjectCell * cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
        if (Manager.TeacherArray == 0) {
             cell.teacherName.text =@"教师姓名:李智恩";
             cell.teacherAge.text = @"年龄:未知";
             cell.headerImgView.image = [UIImage imageNamed:@"哭脸.png"];

        }else{
            for (ListOfTeachersModel *Model in Manager.TeacherArray) {
                TEacherId = Model.ListOfTeacherId;
                cell.teacherAge.text = [NSString stringWithFormat:@"年龄:%@",Model.ListOfTeacherAge];
                [cell.headerImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.ListOfTeacherUserPhotoHead]] placeholderImage:nil];
                [cell configWithModel:Model];
                
            }
        }
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame] ;
        cell.selectedBackgroundView.backgroundColor = kAppWhiteColor;
        [cell.contentView addSubview:cell.teacherName];
        [cell.contentView addSubview:cell.teacherAge];
        [cell.contentView addSubview:cell.headerImgView];
        
        return cell;
    }
    else if(indexPath.section==0)
    {
        AddObjeTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame] ;
        cell.selectedBackgroundView.backgroundColor = kAppWhiteColor;
        cell.firstTF .tag       = 15;
        cell.firstTF .delegate  = self;
        cell.firstTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        cell.FirstTF .tag       = 11;
        cell.FirstTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        cell.FirstTF .delegate  = self;
        cell.SecondTF.tag       = 12;
        cell.SecondTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        cell.SecondTF.delegate  = self;
        cell.ThreeTF.keyboardType  = UIKeyboardTypeNumbersAndPunctuation;
        cell.ThreeTF .tag       = 13;
        cell.ThreeTF .delegate  = self;
        cell.firstTextView.tag = 1000;
        cell.firstTextView.delegate  = self;
        cell.FFirstTextView.tag      = 1001;
        cell.FFirstTextView.delegate = self;
        _firstPlaceLabel  = cell.firstName;
        _secondPlaceLabel = cell.FFirstName;
        cell.firstTF.ex_heightToKeyboard  = 0;
        cell.firstTF.ex_moveView = self.view;
        cell.FirstTF.ex_heightToKeyboard  = 0;
        cell.FirstTF.ex_moveView = self.view;
        cell.SecondTF.ex_heightToKeyboard = 0;
        cell.SecondTF.ex_moveView = self.view;
        cell.ThreeTF.ex_heightToKeyboard  = 0;
        cell.ThreeTF.ex_moveView = self.view;
        return cell;
    }
//    else
//    {
//        LunBoPicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LBCell" forIndexPath:indexPath];
//        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame] ;
//        cell.selectedBackgroundView.backgroundColor = kAppWhiteColor;
//        
//        return cell;
//    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HA"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HA"];
    }
    return cell;
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
            case 1001:
            {
                _secondPlaceLabel.text =@"";
            }
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
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (![string isEqualToString:@""])
    {
        switch (textField.tag) {
            case 15:
            {
                textField.placeholder =@"";
            }
                break;
            case 11:
            {
                textField.placeholder =@"";
            }
                break;
            case 12:
            {
                textField.placeholder =@"";
            }
                break;
            case 13:
            {
                textField.placeholder =@"";
            }
                break;
                case 10000:
            {
                textField.placeholder =@"";
            }
                break;
            default:
                break;
        }
    }
    if ([string isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        switch (textField.tag) {
            case 15:
            {
                textField.placeholder =@"请输入价格...";
            }
                break;
            case 11:
            {
                textField.placeholder =@"请输入1-10000";
            }
                break;
            case 12:
            {
                textField.placeholder =@"请输入1-10000";
            }
                break;
            case 13:
            {
                textField.placeholder =@"请输入1-10000";
            }
                break;
            default:
                break;
        }
    }
    return YES;
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
    if (indexPath.section == 1) {
        ListOfTeachersVC *Teachers = [[ListOfTeachersVC alloc]init];
        [self.navigationController pushViewController:Teachers animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1)
    {
        return 140;
    }
    else if (indexPath.section==0)
    {
        return 630;
    }
    else
    {
        return 0.1;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        return 18;
    }
    return 30;//260+
}

-(void)createNav
{
    UIView *NavBarview         = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label   = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text              = @"添加课程";
    label.font              =  [UIFont boldSystemFontOfSize:16];
    label.textColor         = kAppWhiteColor;
    UIButton *button1       = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(Balick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    button2       = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 40, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button2 setTitle:@"保存" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(SaveClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
}
//保存
-(void)SaveClick:(UIButton *)SaveBtn
{
    [_tableView reloadData];
    UITextField *ShareCount     = [self.view viewWithTag:12];
    UITextField *maxCount       = [self.view viewWithTag:13];
    UITextField *shareIncome    = [self.view viewWithTag:11];
    UITextView *TextJianJie     = [self.view viewWithTag:1001];
    UITextView *Textpeople      = [self.view viewWithTag:1000];
    UITextField *textFieldPrice = [self.view viewWithTag:15];
    NSLog(@"速速来访%@ %@ %@",ShareCount.text,maxCount.text,shareIncome.text);
    FbwManager *Manager         = [FbwManager shareManager];
     __weak typeof(self) weakSelf = self;
//    NSLog(@"我也是醉了%@",shareIncome.text);
    if (_nameTextField.text.length != 0)    {
        if (TextJianJie.text.length      != 0) {
            if (Textpeople.text.length      != 0) {
                if (textFieldPrice.text.length != 0) {
                    if (_selectedPhotos.count     != 0) {
                        if (TEacherId.length         != 0) {
                            if ([shareIncome.text isEqualToString:@"0"]|| shareIncome.text.length == 0 ||[shareIncome.text isKindOfClass:[NSNull class]]) {
                                button2.userInteractionEnabled = NO;
                                SaveBtn.userInteractionEnabled = NO;
                                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"name":_nameTextField.text,@"briefIntro":TextJianJie.text,@"fitPeople":Textpeople.text,@"price":textFieldPrice.text,@"orgId":Manager.UUserId,@"teacherId":TEacherId} url:UrL_AddObject success:^(id responseObject) {
                                    NSDictionary *RootDic = [responseObject objectForKey:@"data"];
                                    NSString *STr = [RootDic objectForKey:@"id"];
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"idValue":STr,@"shareType":@"shareCourse",@"shareCount":@"",@"maxCount":@"",@"shareIncome":@"",@"fkOrgId":Manager.UUserId} url:UrL_AddShareCommon success:^(id responseObject) {
                                        } failure:^(NSError *error) {
                                        }];
                                    });
                                    NSLog(@"看看是所%@",STr);
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        NSArray *arr = @[@{@"id":TEacherId}];
                                        NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
                                        NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"name":_nameTextField.text,@"intro":TextJianJie.text,@"createUserId":Manager.UUserId,@"administratorsId":jsonStr,@"fkCourseId":STr} url:UrL_ChatGroups success:^(id responseObject) {
                                            if (_selectedPhotos.count == 1) {
                                                [SVProgressHUD showWithStatus:@"上传中"];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    NSDictionary *Dict = @{@"fileType":@"image",
                                                                           @"filePurpose":@"imageCourseCarousel",
                                                                           @"fkPurposeId":STr};
                                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                    [manager POST:UrL_UploadFile
                                                       parameters:Dict
                                        constructingBodyWithBlock:
                                                     ^(id<AFMultipartFormData>_Nonnull formData) {
                                                         NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                                                         [formData appendPartWithFileData:imageData
                                                                                     name:@"uploadFile"
                                                                    fileName:[NSString stringWithFormat:@"imageCourseCarousel0.png"]
                                                                    mimeType:@"image/png"];
                                                         
                                                         }progress:nil
                                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                              NSLog(@"图片上传成果啦");
                                                              [SVProgressHUD dismiss];
                                                              Manager.IsListPulling = 3;
                                                              Manager.PullPage = 3;
                                                              [weakSelf.navigationController popViewControllerAnimated:YES];
                                                              
                                                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                              NSLog(@"图片上传出错啦");
                                                          }];
                                                });
                                            }else if (_selectedPhotos.count == 2){
                                                [SVProgressHUD showWithStatus:@"上传中"];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    NSDictionary *Dict = @{@"fileType":@"image",
                                                                           @"filePurpose":@"imageCourseCarousel",
                                                                           @"fkPurposeId":STr};
                                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                    [manager POST:UrL_UploadFile
                                                       parameters:Dict
                                        constructingBodyWithBlock:
                                                     ^(id<AFMultipartFormData>_Nonnull formData) {
                                                         //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                                         NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                                                         [formData appendPartWithFileData:imageData
                                                                                     name:@"uploadFile"
                                                                                 fileName:[NSString stringWithFormat:@"imageCourseCarousel0.png"]
                                                                                 mimeType:@"image/png"];
                                                          }progress:nil
                                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                              NSLog(@"图片上传成果啦");
                                                              
                                                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                              NSLog(@"图片上传出错啦");
                                                          }];
                                                });
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    NSDictionary *Dict = @{@"fileType":@"image",
                                                                           @"filePurpose":@"imageCourseCarousel",
                                                                           @"fkPurposeId":STr};
                                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                    [manager POST:UrL_UploadFile
                                                       parameters:Dict
                                                     constructingBodyWithBlock:
                                                     ^(id<AFMultipartFormData>_Nonnull formData) {
                                                         //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                                         NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[1]);
                                                         [formData appendPartWithFileData:imageData
                                                                                     name:@"uploadFile"
                                                                    fileName:[NSString stringWithFormat:@"imageCourseCarousel1.png"]
                                                                     mimeType:@"image/png"];
                                                         //                                 }
                                                          }progress:nil
                                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                              NSLog(@"图片上传成果啦");
                                                              [SVProgressHUD dismiss];
                                                              Manager.IsListPulling = 3;
                                                              Manager.PullPage = 3;
                                                              [weakSelf.navigationController popViewControllerAnimated:YES];
                                                              
                                                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                              NSLog(@"图片上传出错啦");
                                                          }];
                                                });
                                            }else if (_selectedPhotos.count == 3){
                                                [SVProgressHUD showWithStatus:@"上传中"];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    NSDictionary *Dict = @{@"fileType":@"image",
                                                                           @"filePurpose":@"imageCourseCarousel",
                                                                           @"fkPurposeId":STr};
                                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                    [manager POST:UrL_UploadFile
                                                       parameters:Dict
                                        constructingBodyWithBlock:
                                                     ^(id<AFMultipartFormData>_Nonnull formData) {
                                                         //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                                         NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                                                         [formData appendPartWithFileData:imageData
                                                                                     name:@"uploadFile"
                                                                                 fileName:[NSString stringWithFormat:@"imageCourseCarousel0.png"]
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
                                                                           @"filePurpose":@"imageCourseCarousel",
                                                                           @"fkPurposeId":STr};
                                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                    [manager POST:UrL_UploadFile
                                                       parameters:Dict
                                        constructingBodyWithBlock:
                                                     ^(id<AFMultipartFormData>_Nonnull formData) {
                                                         //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                                         NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[1]);
                                                         [formData appendPartWithFileData:imageData
                                                                                     name:@"uploadFile"
                                                                                 fileName:[NSString stringWithFormat:@"imageCourseCarousel1.png"]
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
                                                                           @"filePurpose":@"imageCourseCarousel",
                                                                           @"fkPurposeId":STr};
                                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                    [manager POST:UrL_UploadFile
                                                       parameters:Dict
                                        constructingBodyWithBlock:
                                                     ^(id<AFMultipartFormData>_Nonnull formData) {
                                                         //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                                         NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[2]);
                                                         [formData appendPartWithFileData:imageData
                                                                                     name:@"uploadFile"
                                                                                 fileName:[NSString stringWithFormat:@"imageCourseCarousel2.png"]
                                                                                 mimeType:@"image/png"];
                                                         //                                 }
                                                         }progress:nil
                                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                              NSLog(@"图片上传成果啦");
                                                              [SVProgressHUD dismiss];
                                                              Manager.IsListPulling = 3;
                                                              Manager.PullPage = 3;
                                                              [weakSelf.navigationController popViewControllerAnimated:YES];
                                                              
                                                          }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                              NSLog(@"图片上传出错啦");
                                                    }];
                                                });
                                            }
                                        } failure:^(NSError *error) {
                                        }];
                                    });
                                } failure:^(NSError *error) {
                                }];
//                                Manager.IsListPulling = 3;
//                                Manager.PullPage = 3;
//                                [weakSelf.navigationController popViewControllerAnimated:YES];
                            }else{
                                        button2.userInteractionEnabled = NO;
                                        SaveBtn.userInteractionEnabled = NO;
                                        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"name":_nameTextField.text,@"briefIntro":TextJianJie.text,@"fitPeople":Textpeople.text,@"price":textFieldPrice.text,@"orgId":Manager.UUserId,@"teacherId":TEacherId} url:UrL_AddObject success:^(id responseObject) {
                                            NSDictionary *RootDic = [responseObject objectForKey:@"data"];
                                            NSString *STr = [RootDic objectForKey:@"id"];
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"idValue":STr,@"shareType":@"shareCourse",@"shareCount":[NSString stringWithFormat:@"%d",[ShareCount.text intValue]],@"maxCount":[NSString stringWithFormat:@"%d",[maxCount.text intValue]],@"shareIncome":[NSString stringWithFormat:@"%.2f",[shareIncome.text floatValue]],@"fkOrgId":Manager.UUserId} url:UrL_AddShareCommon success:^(id responseObject) {
                                                    NSLog(@"我醉了%.2f",[shareIncome.text floatValue]);
                                                    NSLog(@"收长头发发%@",responseObject);
                                                    NSDictionary *DRict = [responseObject objectForKey:@"data"];
                                                    
                                                    NSString *OrderId = [DRict objectForKey:@"id"];
                                                        PayMoneyOrderVC *Order = [[PayMoneyOrderVC alloc]init];
                                                        Order.PayMoneyChoose = @"AddObject";
                                                        Order.OrderId = OrderId;
                                                        Order.SumPrice = [ShareCount.text intValue] *[shareIncome.text doubleValue];
                                                        NSLog(@"你看要交多少钱%.2f",Order.SumPrice);
                                                        [weakSelf.navigationController pushViewController:Order animated:YES];
//                                                    }
                                                } failure:^(NSError *error) {
                                                }];
                                            });
                                            NSLog(@"看看是所%@",TEacherId);
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                NSArray *arr = @[@{@"id":TEacherId}];
                                                NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
                                                NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"name":_nameTextField.text,@"intro":TextJianJie.text,@"createUserId":Manager.UUserId,@"administratorsId":jsonStr,@"fkCourseId":STr} url:UrL_ChatGroups success:^(id responseObject) {
//                                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                                        NSDictionary *Dict = @{@"fileType":@"image",
//                                                                               @"filePurpose":@"imageCourseCarousel",
//                                                                               @"fkPurposeId":STr};
//                                                        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//                                                        [manager POST:UrL_UploadFile
//                                                           parameters:Dict
//                                                        constructingBodyWithBlock:
//                                                         ^(id<AFMultipartFormData>_Nonnull formData) {
//                                                             for (int i = 0; i<_selectedPhotos.count; i++) {
//                                                                 NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[i]);
//                                                                 [formData appendPartWithFileData:imageData          name:@"uploadFile"
//                                                                                         fileName:[NSString stringWithFormat:@"OrgCourseCarousel%d.png",i]
//                                                                                         mimeType:@"image/png"];
//                                                                  }
//                                                              }progress:nil
//                                                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////                                                                  NSLog(@"图片上传成果啦");
//                                                                                                                                }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                                                  NSLog(@"图片上传出错啦");
//                                                              }];
                                                        if (_selectedPhotos.count == 1) {
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                NSDictionary *Dict = @{@"fileType":@"image",
                                                                                       @"filePurpose":@"imageCourseCarousel",
                                                                                       @"fkPurposeId":STr};
                                                                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                                [manager POST:UrL_UploadFile
                                                                   parameters:Dict
                                                    constructingBodyWithBlock:
                                                                 ^(id<AFMultipartFormData>_Nonnull formData) {
                                                                     NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                                                                     [formData appendPartWithFileData:imageData
                                                                                                 name:@"uploadFile"
                                                                                             fileName:[NSString stringWithFormat:@"imageCourseCarousel0.png"]
                                                                                             mimeType:@"image/png"];
                                                                     
                                                                 }progress:nil
                                                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                          NSLog(@"图片上传成果啦");
                                                                          [SVProgressHUD dismiss];
//                                                                          [weakSelf.navigationController popViewControllerAnimated:YES];
                                                                          
                                                                      }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                          NSLog(@"图片上传出错啦");
                                                                      }];
                                                            });
                                                        }else if (_selectedPhotos.count == 2){
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                NSDictionary *Dict = @{@"fileType":@"image",
                                                                                       @"filePurpose":@"imageCourseCarousel",
                                                                                       @"fkPurposeId":STr};
                                                                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                                [manager POST:UrL_UploadFile
                                                                   parameters:Dict
                                                    constructingBodyWithBlock:
                                                                 ^(id<AFMultipartFormData>_Nonnull formData) {
                                                                     //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                                                     NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                                                                     [formData appendPartWithFileData:imageData
                                                                                                 name:@"uploadFile"
                                                                                             fileName:[NSString stringWithFormat:@"imageCourseCarousel0.png"]
                                                                                             mimeType:@"image/png"];
                                                                     //                                 }
                                                                 }progress:nil
                                                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                          NSLog(@"图片上传成果啦");
                                                                          
                                                                      }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                          NSLog(@"图片上传出错啦");
                                                                      }];
                                                            });
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                NSDictionary *Dict = @{@"fileType":@"image",
                                                                                       @"filePurpose":@"imageCourseCarousel",
                                                                                       @"fkPurposeId":STr};
                                                                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                                [manager POST:UrL_UploadFile
                                                                   parameters:Dict
                                                    constructingBodyWithBlock:
                                                                 ^(id<AFMultipartFormData>_Nonnull formData) {
                                                                     //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                                                     NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[1]);
                                                                     [formData appendPartWithFileData:imageData
                                                                                                 name:@"uploadFile"
                                                                    fileName:[NSString stringWithFormat:@"imageCourseCarousel1.png"]
                                                                                             mimeType:@"image/png"];
                                                                     //                                 }
                                                                 }progress:nil
                                                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                          NSLog(@"图片上传成果啦");
                                                                          [SVProgressHUD dismiss];
//                                                                          [weakSelf.navigationController popViewControllerAnimated:YES];
                                                                          
                                                                      }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                          NSLog(@"图片上传出错啦");
                                                                      }];
                                                            });
                                                        }else if (_selectedPhotos.count == 3){
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                NSDictionary *Dict = @{@"fileType":@"image",
                                                                                       @"filePurpose":@"imageCourseCarousel",
                                                                                       @"fkPurposeId":STr};
                                                                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                                [manager POST:UrL_UploadFile
                                                                   parameters:Dict
                                                    constructingBodyWithBlock:
                                                                 ^(id<AFMultipartFormData>_Nonnull formData) {
                                                                     //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                                                     NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                                                                     [formData appendPartWithFileData:imageData
                                                                                                 name:@"uploadFile"
                                                                                             fileName:[NSString stringWithFormat:@"imageCourseCarousel0.png"]
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
                                                                                       @"filePurpose":@"imageCourseCarousel",
                                                                                       @"fkPurposeId":STr};
                                                                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                                [manager POST:UrL_UploadFile
                                                                   parameters:Dict
                                                    constructingBodyWithBlock:
                                                                 ^(id<AFMultipartFormData>_Nonnull formData) {
                                                                     //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                                                     NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[1]);
                                                                     [formData appendPartWithFileData:imageData
                                                                                                 name:@"uploadFile"
                                                                                             fileName:[NSString stringWithFormat:@"imageCourseCarousel1.png"]
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
                                                                                       @"filePurpose":@"imageCourseCarousel",
                                                                                       @"fkPurposeId":STr};
                                                                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                                                [manager POST:UrL_UploadFile
                                                                   parameters:Dict
                                                    constructingBodyWithBlock:
                                                                 ^(id<AFMultipartFormData>_Nonnull formData) {
                                                                     //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                                                     NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[2]);
                                                                     [formData appendPartWithFileData:imageData
                                                                                                 name:@"uploadFile"
                                                                                             fileName:[NSString stringWithFormat:@"imageCourseCarousel2.png"]
                                                                                             mimeType:@"image/png"];
                                                                     //                                 }
                                                                 }progress:nil
                                                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                          NSLog(@"图片上传成果啦");
                                                                          [SVProgressHUD dismiss];
//                                                                          [weakSelf.navigationController popViewControllerAnimated:YES];
                                                                          
                                                                      }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                          NSLog(@"图片上传出错啦");
                                                                      }];
                                                            });
                                                        }
//                                                    });
                                                } failure:^(NSError *error) {
                                                }];
                                            });
                                            
                                        } failure:^(NSError *error) {
                                        }];
//                                    }else{
//                                        [SVProgressHUD showErrorWithStatus:@"请输入分享奖励"];
//                                    }
//                                }else{
//                                    [SVProgressHUD showErrorWithStatus:@"请输入最高每人次数"];
//                                }
//                            }else{
//                                [SVProgressHUD showErrorWithStatus:@"请输入有奖次数"];
                            }
                        }else{
                            [SVProgressHUD showErrorWithStatus:@"请选择教师"];
                        }
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"轮播图片至少上传一张"];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"课程价格不能为空"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"适用人群不能为空"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"课程简介不能为空"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"课程名称不能为空"];
    }
}

-(void)Balick:(UIButton *)BaBtn
{
    FbwManager *Manager = [FbwManager shareManager];
    Manager.IsListPulling = 3;
    Manager.PullPage = 3;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
