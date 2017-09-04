//
//  MainBusinessVC.m
//  ShangKOrganization
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MainBusinessVC.h"
#import "ColumnViewController.h"
#import "MainBusinessCell.h"
#import "MainBusinessSecondCell.h"
#import "MainBusinessModel.h"
@interface MainBusinessVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView    *_tableView;
    NSMutableArray *_dataNumArray;
    NSMutableArray *_NameSectionDataArray;
    NSMutableArray *_dataOneArray;
    NSMutableArray *_dataIdOneArray;
    NSMutableArray *_dataTwoArray;
    NSMutableArray *_dataThreeArray;
    NSMutableArray *YiXuanArray;
    NSMutableArray *WeiXuanXuanArray;
    NSMutableArray *TwoYiXuanArray;
    NSMutableArray *TwoWeiXuanXuanArray;
    NSMutableArray *ThreeYiXuanArray;
    NSMutableArray *ThreeWeiXuanXuanArray;
    NSMutableArray *OneIdArray;
    NSMutableArray *TwoIdArray;
    NSMutableArray *ThreeIdArray;
    UIButton       *BtnYY;
    UIButton       *YiXuanBtnYY;
    UIButton       *TwoBtnYY;
    MainBusinessModel *XCModel;
    NSInteger      AddTwoTiger;
    NSString       *StrId;
}
@end
@implementation MainBusinessVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataNumArray         = [NSMutableArray array];
    _NameSectionDataArray = [NSMutableArray array];
    YiXuanArray           = [NSMutableArray array];
    WeiXuanXuanArray      = [NSMutableArray array];
    _dataTwoArray         = [NSMutableArray array];
    TwoYiXuanArray        = [NSMutableArray array];
    TwoWeiXuanXuanArray   = [NSMutableArray array];
    _dataThreeArray       = [NSMutableArray array];
    ThreeYiXuanArray      = [NSMutableArray array];
    ThreeWeiXuanXuanArray = [NSMutableArray array];
    OneIdArray            = [NSMutableArray array];
    TwoIdArray            = [NSMutableArray array];
    ThreeIdArray          = [NSMutableArray array];
    [self createNav];
    [self createDAta];
//    [self createData];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createDataThree
{
    [ThreeWeiXuanXuanArray removeAllObjects];
    [ThreeYiXuanArray removeAllObjects];
    for (int i = 0; i<_dataThreeArray.count; i++) {
        XCModel = _dataThreeArray[i];
        if (XCModel.BusinessIsHad == 1) {
            [ThreeYiXuanArray addObject:XCModel];
        }else{
            [ThreeWeiXuanXuanArray addObject:XCModel];
        }
    }
}

-(void)createDataTwo
{
    [TwoWeiXuanXuanArray removeAllObjects];
    [TwoYiXuanArray removeAllObjects];
    for (int i = 0; i<_dataTwoArray.count; i++) {
        XCModel = _dataTwoArray[i];
        if (XCModel.BusinessIsHad == 1) {
            [TwoYiXuanArray addObject:XCModel];
        }else{
            [TwoWeiXuanXuanArray addObject:XCModel];
        }
    }
}

-(void)createDataOne
{
    [WeiXuanXuanArray removeAllObjects];
    [YiXuanArray removeAllObjects];
    for (int i = 0; i<_dataOneArray.count; i++) {
        XCModel = _dataOneArray[i];
        if (XCModel.BusinessIsHad == 1) {
            [YiXuanArray addObject:XCModel];
        }else{
            [WeiXuanXuanArray addObject:XCModel];
        }
    }
}

-(void)createData
{
//    FbwManager *Manager = [FbwManager shareManager];
//    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId} url:UrL_LookOrgDetail success:^(id responseObject) {
//        NSLog(@"醉醉哒%@",responseObject);
//    } failure:^(NSError *error) {
//        
//    }];
}

-(void)createDAta
{
    __weak typeof(self) weakSelf = self;
    FbwManager *Manager = [FbwManager shareManager];
    _dataIdOneArray = [NSMutableArray array];
    _dataOneArray   = [NSMutableArray array];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId} url:UrL_LookOrgDetail success:^(id responseObject) {
//        NSLog(@"机构分类%@",responseObject);
        [_dataOneArray removeAllObjects];
        [_dataTwoArray removeAllObjects];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in Arr) {
            NSString *Str = [dict objectForKey:@"name"];
            [_NameSectionDataArray addObject:Str];
            [_dataNumArray addObject:dict];
            if (_dataNumArray.count == 1) {
                 NSArray *ListArr = [Arr[0] objectForKey:@"list"];
                for (NSDictionary *Dit in ListArr) {
                    XCModel = [[MainBusinessModel alloc]init];
                    [XCModel setWithDic:Dit];
                    [_dataOneArray addObject:XCModel];
                }
            }
            if (_dataNumArray.count == 2) {
                NSArray *ListArr = [Arr[1] objectForKey:@"list"];
                for (NSDictionary *Dit in ListArr) {
                    XCModel = [[MainBusinessModel alloc]init];
                    [XCModel setWithDic:Dit];
                    [_dataTwoArray addObject:XCModel];
                }
            }
            if (_dataNumArray.count == 3) {
                NSArray *ListArr = [Arr[2] objectForKey:@"list"];
                for (NSDictionary *Dit in ListArr) {
                    XCModel = [[MainBusinessModel alloc]init];
                    [XCModel setWithDic:Dit];
                    [_dataThreeArray addObject:XCModel];
                }
            }
            [self createDataOne];
            [self createDataTwo];
            [self createDataThree];
            [weakSelf createtableView];
        }
    } failure:^(NSError *error) {
    }];
}


-(void)createtableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataNumArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        return 160;
    }
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 20)];
    UIImageView *image     = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    image.image            = [UIImage imageNamed:@"多边形-1-拷贝@2x.png"];
    UILabel * lable1       = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(image.frame)+5, 5, 100, 20)];
    lable1.text            = _NameSectionDataArray[section];
    lable1.font            = [UIFont boldSystemFontOfSize:15];
    [imageView addSubview:image];
    [imageView addSubview:lable1];
    return imageView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataNumArray.count == 3) {
        if (indexPath.section == 0) {
            
    if (indexPath.row == 0) {
        MainBusinessCell *Main = [tableView dequeueReusableCellWithIdentifier:@"MainOne"];
        if (!Main) {
            Main = [[MainBusinessCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainOne"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
           
            for (int i = 0; i<YiXuanArray.count; i++) {
                UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(-10, 0, 20, 20)];
                image.image = [UIImage imageNamed:@"关闭-拷贝@2x.png"];
                YiXuanBtnYY = [UIButton buttonWithType:UIButtonTypeCustom];
                YiXuanBtnYY.frame = CGRectMake(20+(kScreenWidth/3.7)*i+20*i, CGRectGetMaxY(Main.AlerdayChoose.frame)+10, kScreenWidth/3.7, 20);
                if (i > 2) {
                    YiXuanBtnYY.frame = CGRectMake(20+(i % 3)*((kScreenWidth/3.7)*(i % 3)+20*(i % 3)), CGRectGetMaxY(Main.AlerdayChoose.frame)+40, kScreenWidth/3.7, 20);
                }
                YiXuanBtnYY.tag = i;
                XCModel = YiXuanArray[i];
                [YiXuanBtnYY setTitle:XCModel.BusinessName forState:UIControlStateNormal];
                [YiXuanBtnYY setTitleColor:kAppBlackColor forState:UIControlStateNormal];
                YiXuanBtnYY.titleLabel.textAlignment = NSTextAlignmentCenter;
                YiXuanBtnYY.titleLabel.font = [UIFont systemFontOfSize:16];
                YiXuanBtnYY.backgroundColor = kAppWhiteColor;
                [YiXuanBtnYY addTarget:self action:@selector(DeleteOne:) forControlEvents:UIControlEventTouchUpInside];
                [YiXuanBtnYY addSubview:image];
                [Main addSubview:YiXuanBtnYY];
            }
        });
        [Main configWithModel:XCModel];
        return Main;
    }else if (indexPath.row == 1){
        MainBusinessSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellOne"];
        if (!cell) {
            cell = [[MainBusinessSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellOne"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            for (int i = 0; i<WeiXuanXuanArray.count; i++) {
                UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(-10, 0, 20, 20)];
                image.image = [UIImage imageNamed:@"加好-拷贝@2x"];
                BtnYY = [UIButton buttonWithType:UIButtonTypeCustom];
                BtnYY.frame = CGRectMake(20+(kScreenWidth/3.7)*i+20*i, CGRectGetMaxY(cell.SecondAlerdayChoose.frame)+10, kScreenWidth/3.7, 20);
                if (i > 2) {
                    BtnYY.frame = CGRectMake(20+(i % 3)*((kScreenWidth/3.7)*(i % 3)+20*(i % 3)), CGRectGetMaxY(cell.SecondAlerdayChoose.frame)+40, kScreenWidth/3.7, 20);
                }
                BtnYY.tag = i;
                XCModel = WeiXuanXuanArray[i];
                [BtnYY setTitle:XCModel.BusinessName forState:UIControlStateNormal];
                [BtnYY setTitleColor:kAppBlackColor forState:UIControlStateNormal];
                BtnYY.backgroundColor = kAppWhiteColor;
                BtnYY.titleLabel.textAlignment = NSTextAlignmentCenter;
                BtnYY.titleLabel.font = [UIFont systemFontOfSize:16];
                [BtnYY addTarget:self action:@selector(AddOne:) forControlEvents:UIControlEventTouchUpInside];
                [BtnYY addSubview:image];
                [cell addSubview:BtnYY];
            }
        });
             [cell configWithModel:XCModel];
             return cell;
            }
        }else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                MainBusinessCell *Main = [tableView dequeueReusableCellWithIdentifier:@"MainTwo"];
                if (!Main) {
                    Main = [[MainBusinessCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainTwo"];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    for (int i = 0; i<TwoYiXuanArray.count; i++) {
                        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(-10, 0, 20, 20)];
                        image.image = [UIImage imageNamed:@"关闭-拷贝@2x.png"];
                        TwoBtnYY = [UIButton buttonWithType:UIButtonTypeCustom];
                        TwoBtnYY.frame = CGRectMake(20+(kScreenWidth/3.7)*i+20*i, CGRectGetMaxY(Main.AlerdayChoose.frame)+10, kScreenWidth/3.7, 20);
                        if (i > 2) {
                            TwoBtnYY.frame = CGRectMake(20+(i % 3)*((kScreenWidth/3.7)*(i % 3)+20*(i % 3)), CGRectGetMaxY(Main.AlerdayChoose.frame)+40, kScreenWidth/3.7, 20);
                        }
                        TwoBtnYY.tag = i;
                        XCModel = TwoYiXuanArray[i];
                        [TwoBtnYY setTitle:XCModel.BusinessName forState:UIControlStateNormal];
                        [TwoBtnYY setTitleColor:kAppBlackColor forState:UIControlStateNormal];
                        TwoBtnYY.backgroundColor = kAppWhiteColor;
                        [TwoBtnYY addTarget:self action:@selector(DeleteTwo:) forControlEvents:UIControlEventTouchUpInside];
                        TwoBtnYY.titleLabel.textAlignment = NSTextAlignmentCenter;
                        TwoBtnYY.titleLabel.font = [UIFont systemFontOfSize:16];
                        [TwoBtnYY addSubview:image];
                        [Main addSubview:TwoBtnYY];
                    }
                });
                [Main configWithModel:XCModel];
                return Main;
            }else if (indexPath.row == 1){
                MainBusinessSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTwo"];
                if (!cell) {
                    cell = [[MainBusinessSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellTwo"];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    for (int i = 0; i<TwoWeiXuanXuanArray.count; i++) {
                        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(-10, 0, 20, 20)];
                        image.image = [UIImage imageNamed:@"加好-拷贝@2x"];
                        TwoBtnYY = [UIButton buttonWithType:UIButtonTypeCustom];
                        TwoBtnYY.frame = CGRectMake(20+(kScreenWidth/3.7)*i+20*i, CGRectGetMaxY(cell.SecondAlerdayChoose.frame)+10, kScreenWidth/3.7, 20);
                        if (i > 2) {
                            TwoBtnYY.frame = CGRectMake(20+(i % 3)*((kScreenWidth/3.7)*(i % 3)+20*(i % 3)), CGRectGetMaxY(cell.SecondAlerdayChoose.frame)+40, kScreenWidth/3.7, 20);
                        }
                        TwoBtnYY.tag = i;
                        XCModel = TwoWeiXuanXuanArray[i];
                        [TwoBtnYY setTitle:XCModel.BusinessName forState:UIControlStateNormal];
                        [TwoBtnYY setTitleColor:kAppBlackColor forState:UIControlStateNormal];
                        TwoBtnYY.backgroundColor = kAppWhiteColor;
                        TwoBtnYY.titleLabel.textAlignment = NSTextAlignmentCenter;
                        TwoBtnYY.titleLabel.font = [UIFont systemFontOfSize:16];
                        [TwoBtnYY addTarget:self action:@selector(AddTwo:) forControlEvents:UIControlEventTouchUpInside];
                        [TwoBtnYY addSubview:image];
                        [cell addSubview:TwoBtnYY];
                    }
                });
                [cell configWithModel:XCModel];
                return cell;
            }
        }else if (indexPath.section == 2) {
            
            if (indexPath.row == 0) {
                MainBusinessCell *Main = [tableView dequeueReusableCellWithIdentifier:@"MainThree"];
                if (!Main) {
                    Main = [[MainBusinessCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainThree"];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    for (int i = 0; i<ThreeYiXuanArray.count; i++) {
                        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(-10, 0, 20, 20)];
                        image.image = [UIImage imageNamed:@"关闭-拷贝@2x.png"];
                        BtnYY = [UIButton buttonWithType:UIButtonTypeCustom];
                        BtnYY.frame = CGRectMake(20+(kScreenWidth/3.7)*i+20*i, CGRectGetMaxY(Main.AlerdayChoose.frame)+10, kScreenWidth/3.7, 20);
                        if (i > 2 && i < 6) {
                            BtnYY.frame = CGRectMake(20+(i % 3)*((kScreenWidth/3.7)+20), CGRectGetMaxY(Main.AlerdayChoose.frame)+40, kScreenWidth/3.7, 20);
                        }else if (i >= 6 && i < 9){
                            BtnYY.frame = CGRectMake(20+(i % 6)*((kScreenWidth/3.7)+20), CGRectGetMaxY(Main.AlerdayChoose.frame)+70, kScreenWidth/3.7, 20);
                        }else if (i >= 9){
                            BtnYY.frame = CGRectMake(20+(i % 9)*((kScreenWidth/3.7)+20), CGRectGetMaxY(Main.AlerdayChoose.frame)+100, kScreenWidth/3.7, 20);
                        }
                        BtnYY.tag = i;
                        XCModel = ThreeYiXuanArray[i];
                        [BtnYY setTitle:XCModel.BusinessName forState:UIControlStateNormal];
                        [BtnYY setTitleColor:kAppBlackColor forState:UIControlStateNormal];
                        BtnYY.backgroundColor = kAppWhiteColor;
                        [BtnYY addTarget:self action:@selector(DeleteThree:) forControlEvents:UIControlEventTouchUpInside];
                        BtnYY.titleLabel.textAlignment = NSTextAlignmentCenter;
                        BtnYY.titleLabel.font = [UIFont systemFontOfSize:16];
                        [BtnYY addSubview:image];
                        [Main addSubview:BtnYY];
                    }
                });
                [Main configWithModel:XCModel];
                return Main;
            }else if (indexPath.row == 1){
                MainBusinessSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellThree"];
                if (!cell) {
                    cell = [[MainBusinessSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellThree"];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    for (int i = 0; i<ThreeWeiXuanXuanArray.count; i++) {
                        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(-10, 0, 20, 20)];
                        image.image = [UIImage imageNamed:@"加好-拷贝@2x"];
                        BtnYY = [UIButton buttonWithType:UIButtonTypeCustom];
                        BtnYY.frame = CGRectMake(20+(kScreenWidth/3.7)*i+20*i, CGRectGetMaxY(cell.SecondAlerdayChoose.frame)+10, kScreenWidth/3.7,20);
                        if (i > 2 && i < 6) {
                            BtnYY.frame = CGRectMake(20+(i % 3)*((kScreenWidth/3.7)+20), CGRectGetMaxY(cell.SecondAlerdayChoose.frame)+40, kScreenWidth/3.7, 20);
                        }else if (i >= 6 && i < 9){
                            BtnYY.frame = CGRectMake(20+(i % 6)*((kScreenWidth/3.7)+20), CGRectGetMaxY(cell.SecondAlerdayChoose.frame)+70, kScreenWidth/3.7, 20);
                        }else if (i >= 9){
                            BtnYY.frame = CGRectMake(20+(i % 9)*((kScreenWidth/3.7)+20), CGRectGetMaxY(cell.SecondAlerdayChoose.frame)+100, kScreenWidth/3.7, 20);
                        }
                        BtnYY.tag = i;
                        XCModel = ThreeWeiXuanXuanArray[i];
                        [BtnYY setTitle:XCModel.BusinessName forState:UIControlStateNormal];
                        [BtnYY setTitleColor:kAppBlackColor forState:UIControlStateNormal];
                        BtnYY.backgroundColor = kAppWhiteColor;
                        BtnYY.titleLabel.textAlignment = NSTextAlignmentCenter;
                        BtnYY.titleLabel.font = [UIFont systemFontOfSize:16];
                        [BtnYY addTarget:self action:@selector(AddThree:) forControlEvents:UIControlEventTouchUpInside];
                        [BtnYY addSubview:image];
                        [cell addSubview:BtnYY];
                    }
                });
                [cell configWithModel:XCModel];
                return cell;
            }
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouldYou"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CouldYou"];
    }
    return cell;
}

-(void)AddOne:(UIButton *)AddOne
{
    [YiXuanArray addObject:WeiXuanXuanArray[AddOne.tag]];
    [WeiXuanXuanArray removeObject:WeiXuanXuanArray[AddOne.tag]];
//     XCModel = YiXuanArray[YiXuanBtnYY.tag];
//    [OneIdArray addObject:XCModel.BusinessId];
    [self createtableView];
   
}

-(void)DeleteOne:(UIButton *)Addone
{
    [WeiXuanXuanArray addObject:YiXuanArray[Addone.tag]];
    [YiXuanArray removeObject:YiXuanArray[Addone.tag]];
    [self createtableView];
}

-(void)AddTwo:(UIButton *)AddTwo
{
    [TwoYiXuanArray addObject:TwoWeiXuanXuanArray[AddTwo.tag]];
    [TwoWeiXuanXuanArray removeObject:TwoWeiXuanXuanArray[AddTwo.tag]];
    
    [self createtableView];
//    XCModel = TwoYiXuanArray[TwoBtnYY.tag];
//    [TwoIdArray addObject:XCModel.BusinessId];
}

-(void)DeleteTwo:(UIButton *)AddTwo
{
    [TwoWeiXuanXuanArray addObject:TwoYiXuanArray[AddTwo.tag]];
    [TwoYiXuanArray removeObject:TwoYiXuanArray[AddTwo.tag]];
//    XCModel = TwoYiXuanArray[TwoBtnYY.tag];
//    [TwoIdArray removeObject:XCModel.BusinessId];
    [self createtableView];
}

-(void)AddThree:(UIButton *)AddThree
{
    [ThreeYiXuanArray addObject:ThreeWeiXuanXuanArray[AddThree.tag]];
    [ThreeWeiXuanXuanArray removeObject:ThreeWeiXuanXuanArray[AddThree.tag]];
    
    [self createtableView];
    
}

-(void)DeleteThree:(UIButton *)AddThree
{
    [ThreeWeiXuanXuanArray addObject:ThreeYiXuanArray[AddThree.tag]];
    [ThreeYiXuanArray removeObject:ThreeYiXuanArray[AddThree.tag]];
//    XCModel = ThreeYiXuanArray[BtnYY.tag];
//    [ThreeIdArray removeObject:XCModel.BusinessId];
    [self createtableView];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"课程分类";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton*button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2       = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 40, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button2 setTitle:@"保存" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(SavClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)SavClick:(UIButton *)Save
{
    [ThreeIdArray removeAllObjects];
    [TwoIdArray removeAllObjects];
    [OneIdArray removeAllObjects];
    
    if (YiXuanArray.count != 0) {
        for (int i=0; i<YiXuanArray.count; i++) {
            XCModel = YiXuanArray[i];
            [OneIdArray addObject:XCModel.BusinessId];
        }
    }
    if (TwoYiXuanArray.count != 0) {
        for (int i=0; i<TwoYiXuanArray.count; i++) {
            XCModel = TwoYiXuanArray[i];
            [TwoIdArray addObject:XCModel.BusinessId];
        }
//        XCModel = TwoYiXuanArray[TwoBtnYY.tag];
//        [TwoIdArray addObject:XCModel.BusinessId];
    }
    if (ThreeYiXuanArray.count != 0) {
        for (int i=0; i<ThreeYiXuanArray.count; i++) {
            XCModel = ThreeYiXuanArray[i];
            [ThreeIdArray addObject:XCModel.BusinessId];
        }
        
    }
//        NSLog(@"让我看看%@",OneIdArray);
//        NSLog(@"让我看看看%@",TwoIdArray);
//        NSLog(@"让我看看看看%@",ThreeIdArray);
    if (YiXuanArray.count != 0 || TwoYiXuanArray.count != 0 || ThreeYiXuanArray.count != 0) {
        for (StrId in OneIdArray) {
            NSArray *arr = @[@{@"id":StrId}];
//            NSLog(@"啧啧%@",StrId);
            NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            FbwManager *Manager = [FbwManager shareManager];
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"classIdListStr":jsonStr} url:UrL_AddOrgDetail success:^(id responseObject) {
//                NSLog(@"第一个分类跑几次");
//                NSLog(@"第一组的%@",jsonStr);
                [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
            } failure:^(NSError *error) {
            }];
        }
        for (StrId in TwoIdArray) {
            NSArray *arr = @[@{@"id":StrId}];
//            NSLog(@"啧啧啧%@",StrId);
            NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            FbwManager *Manager = [FbwManager shareManager];
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"classIdListStr":jsonStr} url:UrL_AddOrgDetail success:^(id responseObject) {
//                 NSLog(@"第二个分类跑几次%@",jsonStr);
                [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
            } failure:^(NSError *error) {
                
            }];
        }
        for (StrId in ThreeIdArray) {
            NSArray *arr = @[@{@"id":StrId}];
//            NSLog(@"啧啧啧啧%@",StrId);
            NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            FbwManager *Manager = [FbwManager shareManager];
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"classIdListStr":jsonStr} url:UrL_AddOrgDetail success:^(id responseObject) {
//                 NSLog(@"第三个分类跑几次%@",jsonStr);
                [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
            } failure:^(NSError *error) {
                
            }];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请至少选择一项课程分类"];
    }
}

-(void)BaCklick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
