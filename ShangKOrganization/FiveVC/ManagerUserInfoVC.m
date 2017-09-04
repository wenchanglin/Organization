//
//  ManagerUserInfoVC.m
//  ShangKOrganization
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ManagerUserInfoVC.h"
#import "AppDelegate.h"
#import "CompanyCell.h"
#import "SecondManagerInfoCell.h"
#import "UITextField+Extension.h"
#import "ThirdManagerUSerCell.h"
@interface ManagerUserInfoVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>
{
    UITableView *_TableView;
    NSMutableArray *_FirstArray;
    NSMutableArray *_SecondArray;
    UITextField *_NickNameTextField;
    UITextField *_PhoneTextField;
    UITextField *_SexTextField;
    UITextField *_AgeTextField;
    UIButton    *button2;
    NSString    *SexStr;
    ThirdManagerUSerCell *Xcell;
    CompanyCell *Ocell;
    UIView *NavBarview;
}
@property(nonatomic,strong)UILabel    * firstPlaceLabel;
@end

@implementation ManagerUserInfoVC
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
    _FirstArray = [NSMutableArray array];
    _SecondArray = [NSMutableArray array];
    _NickNameTextField = [[UITextField alloc]init];
    _PhoneTextField = [[UITextField alloc]init];
    _SexTextField = [[UITextField alloc]init];
    _AgeTextField = [[UITextField alloc]init];
    [self createNav];
    self.view.backgroundColor = kAppBlueColor;
    [self createTableView];
}

-(void)createTableView
{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    _TableView.delegate   = self;
    _TableView.scrollEnabled = YES;
    _TableView.dataSource = self;
    [self.view addSubview:_TableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row ==2) {
        return 180;
    }
    return 70;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = @[@"昵称",@"手机号"];
    NSString *NickName ;
    NSString *Phone;
    if (self.UserNickName == nil) {
        NickName = @"暂无昵称";
    }else{
        NickName = self.UserNickName;
    }
    if (self.UserPhone == nil) {
        Phone = @"暂无手机号";
    }else{
        Phone = self.UserPhone;
    }
    NSArray *Info = @[NickName,Phone];
    if(indexPath.section == 0){
        Ocell = [tableView dequeueReusableCellWithIdentifier:@"Kinfo"];
        if (!Ocell) {
            Ocell = [[CompanyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Kinfo"];
        }
        Ocell.TitleLabel.text = arr[indexPath.row];
        Ocell.InfoLabel.ex_heightToKeyboard = 0;
        Ocell.InfoLabel.delegate = self;
        Ocell.InfoLabel.userInteractionEnabled = NO;
        Ocell.InfoLabel.ex_moveView = self.view;
        Ocell.InfoLabel.text  = Info[indexPath.row];
        [_FirstArray addObject:Ocell.InfoLabel];
        return Ocell;
    }
    if (self.UserSex == 0) {
        SexStr = @"女";
    }else{
        SexStr = @"男";
    }
    if (_UserAge == 0) {
    
    }
    NSArray *ar = @[@"性别",@"年龄"];
    NSArray *inAr = @[SexStr,[NSString stringWithFormat:@"%ld",(long)_UserAge]];
    SecondManagerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Info"];
    if (!cell) {
        cell = [[SecondManagerInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Info"];
    }
    if (indexPath.row == 2) {
        Xcell = [tableView dequeueReusableCellWithIdentifier:@"QQ"];
        if (!Xcell) {
            Xcell = [[ThirdManagerUSerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QQ"];
        }
        if (self.UserInfoIntro == nil) {
            Xcell.SecPerson.text = @"暂无简介";
        }else{
            Xcell.SecPerson.text = self.UserInfoIntro;
        }
        _firstPlaceLabel             = Xcell.activityName;
        Xcell.SecPerson.tag = 102;
        Xcell.SecPerson.delegate = self;
        Xcell.SecPerson.userInteractionEnabled = NO;
        return Xcell;
    }else{
        cell.SecTitleLabel.text = ar[indexPath.row];
        cell.SecInfoLabel.text  = inAr[indexPath.row];
        cell.SecInfoLabel.delegate = self;
        cell.SecInfoLabel.userInteractionEnabled = NO;
        cell.SecInfoLabel.ex_heightToKeyboard = 0;
        cell.SecInfoLabel.ex_moveView = self.view;
        [_SecondArray addObject:cell.SecInfoLabel];
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
            case 102:
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
            case 102:
            {
                _firstPlaceLabel.text =@"请输入个人简介...";
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
    NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"个人信息";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 70, 10, 50, 30);
    [button2 setTitle:@"修改" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:15];
    [button2 addTarget:self action:@selector(BtnMessClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
    
}
//编辑
-(void)BtnMessClick:(UIButton *)BtnMess
{
//    NSLog(@"看看数据%@",_FirstArray);
    UITextField *text1 = _FirstArray[0];
    UITextField *text2 = _FirstArray[1];
    UITextField *text3 = _SecondArray[0];
    UITextField *text4 = _SecondArray[1];
    button2.hidden = YES;
    Xcell.SecPerson.text = @"";
    Xcell.SecPerson.userInteractionEnabled = YES;
    text1.userInteractionEnabled = YES;
    text2.userInteractionEnabled = YES;
    text3.userInteractionEnabled = YES;
    text4.userInteractionEnabled = YES;
//    Ocell.InfoLabel.userInteractionEnabled = YES;
    [Xcell.contentView addSubview:Xcell.activityName];
    BtnMess = [UIButton buttonWithType:UIButtonTypeCustom];
    BtnMess.frame = CGRectMake(kScreenWidth - 70, 10, 50, 30);
    BtnMess.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [BtnMess setTitle:@"保存" forState:UIControlStateNormal];
    [BtnMess addTarget:self action:@selector(BtnBaCunClick:) forControlEvents:UIControlEventTouchUpInside];
    [NavBarview addSubview:BtnMess];
}
-(void)BtnBaCunClick:(UIButton *)Bt
{
    UITextView *textView = [self.view viewWithTag:102];
    FbwManager *Manager = [FbwManager shareManager];
    _NickNameTextField = _FirstArray[0];
    _PhoneTextField = _FirstArray[1];
    _SexTextField = _SecondArray[0];
    _AgeTextField = _SecondArray[1];
    __weak typeof(self) weakSelf = self;
    if (_NickNameTextField.text.length  != 0) {
        if (_PhoneTextField.text.length   != 0) {
            if (_SexTextField.text.length   != 0) {
                if (_AgeTextField.text.length != 0) {
                    if (textView.text.length    != 0) {
                        NSInteger GT;
                        if ([_SexTextField.text isEqualToString:@"男"]) {
                            GT = 1;
                        }else if ([_SexTextField.text isEqualToString:@"女"]){
                            GT = 0;
                        }else{
                            [SVProgressHUD showErrorWithStatus:@"请输入正确的性别"];
                        }
                        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"nickName":_NickNameTextField.text,@"sex":[NSString stringWithFormat:@"%ld",(long)GT],@"phone":_PhoneTextField.text,@"age":_AgeTextField.text,@"intro":textView.text} url:UrL_updateOrgInfo success:^(id responseObject) {
//                            [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                        } failure:^(NSError *error) {
                            
                        }];
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"请输入个人简介"];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"请输入年龄"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"请输入性别"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
    }
}

-(void)BaCklick:(UIButton *)BaBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
