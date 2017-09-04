//
//  EveryAchievementVC.m
//  ShangKOrganization
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EveryAchievementVC.h"
#import "EveryAchievementModel.h"
#import "EveryAchievementCell.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
@interface EveryAchievementVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArray;
    NSMutableArray *_PicArray;
    UITableView    *_tableView;
    EveryAchievementCell *Xcell;
    CGFloat ImageHeight;
    CGFloat SecondImageHeight;
    CGRect textFrameTT;
}
@end
@implementation EveryAchievementVC
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    _dataArray = [NSMutableArray array];
    _PicArray = [NSMutableArray array];
    [self createNav];
    [self createData];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Xcell = [[EveryAchievementCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    if (indexPath.row == 0) {
        [Xcell.FirstImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,_PicArray[0]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //宽图
            CGSize size = image.size;
            CGFloat width = kScreenWidth;
            ImageHeight = width * size.height / size.width;
            if (ImageHeight > kScreenHeight) {
                ImageHeight = kScreenHeight;
                width = ImageHeight * size.width / size.height;
            }
            Xcell.FirstImage.frame = CGRectMake(0, 0, width, ImageHeight);
            if (ImageHeight > kScreenHeight) {
                CGPoint center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.f);
                Xcell.FirstImage.center = center;
            }
        }];
        return ImageHeight;
    }else if (indexPath.row == 1){
        Xcell.FirstLabel.text = _dataArray[0];
        Xcell.FirstLabel.numberOfLines = 0;
        CGRect textFrame = Xcell.FirstLabel.frame;
        Xcell.FirstLabel.frame = CGRectMake(10, 5, kScreenWidth-20, textFrame.size.height = [Xcell.FirstLabel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:Xcell.FirstLabel.font,NSFontAttributeName ,nil] context:nil].size.height);
        return textFrame.size.height+10;
    }else if (indexPath.row == 2){
        [Xcell.SecondImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,_PicArray[1]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //宽图
            CGSize size = image.size;
            CGFloat width = kScreenWidth;
            SecondImageHeight = width * size.height / size.width;
            if (SecondImageHeight > kScreenHeight) {
                SecondImageHeight = kScreenHeight;
                width = SecondImageHeight * size.width / size.height;
            }
            Xcell.SecondImage.frame = CGRectMake(0, 0, width, SecondImageHeight);
            if (SecondImageHeight > kScreenHeight) {
                CGPoint center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.f);
                Xcell.SecondImage.center = center;
            }
        }];
        return SecondImageHeight;
    }else if (indexPath.row == 3){
        dispatch_async(dispatch_get_main_queue(), ^{
            Xcell.SecondLabel.text = _dataArray[1];
            Xcell.SecondLabel.numberOfLines = 0;
            textFrameTT = Xcell.SecondLabel.frame;
            Xcell.SecondLabel.frame = CGRectMake(10, 5, kScreenWidth-20, textFrameTT.size.height = [Xcell.SecondLabel.text boundingRectWithSize:CGSizeMake(textFrameTT.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:Xcell.SecondLabel.font,NSFontAttributeName ,nil] context:nil].size.height);
        });
        return textFrameTT.size.height + 10;
    }
    
    return 100;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)createData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"resultId":self.AchienementId} url:UrL_EveryAchienement success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [SVProgressHUD showWithStatus:@"图片加载中..."];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [RootDic objectForKey:@"items"];
        for (NSDictionary *Dict in arr) {
            NSString *ST = [Dict objectForKey:@"content"];
            NSString *Photo = [Dict objectForKey:@"contentPhotoUrl"];
            [_PicArray addObject:Photo];
            [_dataArray addObject:ST];
            NSLog(@"%@",_dataArray);
        }
        [self createTableView];
    } failure:^(NSError *error) {
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString *CellIdentifier = @"Cell";
    Xcell = [tableView cellForRowAtIndexPath:indexPath];//防止复用
    if (!Xcell) {
        Xcell = [[EveryAchievementCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        if ([_PicArray[0] isKindOfClass:[NSNull class]]) {
            Xcell.FirstImage.image = [UIImage imageNamed:@"哭脸.png"];
        }else{
//            [cell.FirstImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,_PicArray[0]]] placeholderImage:nil];
            [Xcell.FirstImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,_PicArray[0]]] placeholderImage:[UIImage imageNamed:@"PicDownload.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //宽图
                CGSize size = image.size;
                CGFloat width = kScreenWidth;
                CGFloat height = width * size.height / size.width;
                if (height > kScreenHeight) {
                    height = kScreenHeight;
                    width = height * size.width / size.height;
                }
                Xcell.FirstImage.frame = CGRectMake(0, 0, width, height);
                if (height > kScreenHeight) {
                    CGPoint center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.f);
                    Xcell.FirstImage.center = center;
                }
            }];
        }
        [Xcell.contentView addSubview:Xcell.FirstImage];
    }else if (indexPath.row == 1){
        /**
         //宽图
         CGSize size = image.size;
         CGFloat width = kScreenWidth;
         CGFloat height = width * size.height / size.width;
         if (height > kScreenHeight) {
         height = kScreenHeight;
         width = height * size.width / size.height;
         }
         cell.FirstImage.frame = CGRectMake(0, 0, width, height);
         if (height > kScreenHeight) {
         CGPoint center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.f);
         cell.FirstImage.center = center;
         }
         */
        Xcell.FirstLabel.text = _dataArray[0];
        Xcell.FirstLabel.numberOfLines = 0;
        CGRect textFrame = Xcell.FirstLabel.frame;
        Xcell.FirstLabel.frame = CGRectMake(10, 5, kScreenWidth-20, textFrame.size.height = [Xcell.FirstLabel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:Xcell.FirstLabel.font,NSFontAttributeName ,nil] context:nil].size.height);
        Xcell.FirstLabel.frame = CGRectMake(10, 5, kScreenWidth-20, textFrame.size.height);
        [Xcell.contentView addSubview:Xcell.FirstLabel];
    }else if (indexPath.row == 2){
        if ([_PicArray[1] isKindOfClass:[NSNull class]]) {
            Xcell.SecondImage.image = [UIImage imageNamed:@"哭脸.png"];
        }else{
            [Xcell.SecondImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,_PicArray[1]]] placeholderImage:[UIImage imageNamed:@"PicDownload.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //宽图
                CGSize size = image.size;
                CGFloat width = kScreenWidth;
                CGFloat height = width * size.height / size.width;
                if (height > kScreenHeight) {
                    height = kScreenHeight;
                    width = height * size.width / size.height;
                }
                Xcell.SecondImage.frame = CGRectMake(0, 0, width, height);
                if (height > kScreenHeight) {
                    CGPoint center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.f);
                    Xcell.SecondImage.center = center;
                }
            }];
//            [cell.SecondImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,_PicArray[1]]] placeholderImage:nil];
        }
        [Xcell.contentView addSubview:Xcell.SecondImage];
    }else if (indexPath.row == 3){
//        [SVProgressHUD showWithStatus:@"图片加载中..."];
        Xcell.SecondLabel.text = _dataArray[1];
        Xcell.SecondLabel.numberOfLines = 0;
        CGRect textFrame = Xcell.SecondLabel.frame;
        Xcell.SecondLabel.frame = CGRectMake(10, 5, kScreenWidth-20, textFrame.size.height = [Xcell.SecondLabel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:Xcell.SecondLabel.font,NSFontAttributeName ,nil] context:nil].size.height);
        Xcell.SecondLabel.frame = CGRectMake(10, 5, kScreenWidth-20, textFrame.size.height);
        [Xcell.contentView addSubview:Xcell.SecondLabel];
    }
    return Xcell;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"成果详情";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)BaCklick:(UIButton *)btn
{
    FbwManager *Manager = [FbwManager shareManager];
    Manager.IsListPulling = 3;
    Manager.PullPage = 3;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
