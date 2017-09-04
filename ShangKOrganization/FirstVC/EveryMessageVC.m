//
//  EveryMessageVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/12.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EveryMessageVC.h"
#import "EveryMessageCell.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>

@interface EveryMessageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString         *NoticeSTR;
    NSMutableArray   *PicArray;
    UITableView      *_tableView;
    EveryMessageCell *Xcell;
    CGFloat          ImageHeight;
    CGFloat          SecondImageHeight;
}
@end

@implementation EveryMessageVC
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
    PicArray = [NSMutableArray array];
    [self createNav];
    [self createData];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return PicArray.count + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Xcell = [[EveryMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MEssA"];
    if (indexPath.row == 0) {
        Xcell.TitleLAbel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth, 20)];
        Xcell.TitleLAbel.text = NoticeSTR;
        Xcell.TitleLAbel.numberOfLines = 0;
        Xcell.TitleLAbel.adjustsFontSizeToFitWidth = YES;
        CGRect textFrame = Xcell.TitleLAbel.frame;
        Xcell.TitleLAbel.frame = CGRectMake(10, 5, kScreenWidth-20, textFrame.size.height = [Xcell.TitleLAbel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:Xcell.TitleLAbel.font,NSFontAttributeName ,nil] context:nil].size.height);
        return textFrame.size.height+10;
    }else if (indexPath.row == 1){
        [Xcell.ImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,PicArray[0]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //宽图
            CGSize size = image.size;
            CGFloat width = kScreenWidth;
            ImageHeight = width * size.height / size.width;
            if (ImageHeight > kScreenHeight) {
                ImageHeight = kScreenHeight;
                width = ImageHeight * size.width / size.height;
            }
            Xcell.ImageView.frame = CGRectMake(0, 0, width, ImageHeight);
            if (ImageHeight > kScreenHeight) {
                CGPoint center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.f);
                Xcell.ImageView.center = center;
            }
        }];
        return ImageHeight;
    }else if (indexPath.row == 2){
        [Xcell.SecondImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,PicArray[1]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //宽图
            CGSize size = image.size;
            CGFloat width = kScreenWidth;
            SecondImageHeight = width * size.height / size.width;
            if (SecondImageHeight > kScreenHeight) {
                SecondImageHeight = kScreenHeight;
                width = SecondImageHeight * size.width / size.height;
            }
            Xcell.SecondImageView.frame = CGRectMake(0, 0, width, SecondImageHeight);
            if (SecondImageHeight > kScreenHeight) {
                CGPoint center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.f);
                Xcell.SecondImageView.center = center;
            }
        }];
        return SecondImageHeight;
    }
    return kScreenHeight+50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *CellIdentifier = @"MEssA";
        Xcell = [tableView cellForRowAtIndexPath:indexPath];
        if (!Xcell) {
            Xcell = [[EveryMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        Xcell.TitleLAbel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth, 20)];
        Xcell.TitleLAbel.text = NoticeSTR;
        Xcell.TitleLAbel.numberOfLines = 0;
        Xcell.TitleLAbel.adjustsFontSizeToFitWidth = YES;
        CGRect textFrame = Xcell.TitleLAbel.frame;
        Xcell.TitleLAbel.frame = CGRectMake(10, 5, kScreenWidth-20, textFrame.size.height = [Xcell.TitleLAbel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:Xcell.TitleLAbel.font,NSFontAttributeName ,nil] context:nil].size.height);
        Xcell.TitleLAbel.frame = CGRectMake(10, 5, kScreenWidth-20, textFrame.size.height);
            [Xcell.contentView addSubview:Xcell.TitleLAbel];
        return Xcell;
    }else{
        static NSString *CellIdentifier = @"MEssB";
    Xcell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.ImageViewHeight = 0;
    if (!Xcell) {
        Xcell = [[EveryMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if (indexPath.row == 1){
            if ([PicArray[0] isKindOfClass:[NSNull class]]) {
                Xcell.ImageView.image = [UIImage imageNamed:@"哭脸.png"];
            }else{
                /**
                 [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,_PhotoUrl]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                 if (!image) {
                 image = [UIImage imageNamed:@"哭脸.png"];
                 imageView.image = image;
                 }
                 //高图
                 if (image.size.height > image.size.width) {
                 CGFloat ImgeViewHeight = image.size.height / image.size.width * kScreenWidth;
                 imageView.frame = CGRectMake(0, 0, kScreenWidth, ImgeViewHeight);
                 _TAbView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ImgeViewHeight+50)];
                 _TAbView.backgroundColor = kAppRedColor;
                 [_TAbView addSubview:imageView];
                 }else{
                 //宽图
                 CGSize size = image.size;
                 CGFloat width = kScreenWidth;
                 CGFloat height = width * size.height / size.width;
                 if (height > kScreenHeight) {
                 height = kScreenHeight;
                 width = height * size.width / size.height;
                 }
                 _TAbView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height+50)];
                 _TAbView.backgroundColor = kAppRedColor;
                 imageView.frame = CGRectMake(0, 0, width, height);
                 if (height > kScreenHeight) {
                 CGPoint center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.f);
                 imageView.center = center;
                 }
                 [_TAbView addSubview:imageView];
                 }
                 
                 }]
                 */
                [Xcell.ImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,PicArray[0]]] placeholderImage:[UIImage imageNamed:@"PicDownload.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (!image) {
                        image = [UIImage imageNamed:@"哭脸.png"];
                        Xcell.ImageView.image = image;
                    }
                    //高图
                    if (image.size.height > image.size.width) {
                        CGFloat ImgeViewHeight = image.size.height / image.size.width * kScreenWidth;
                        Xcell.ImageView.frame = CGRectMake(0, 0, kScreenWidth, ImgeViewHeight);
                        [Xcell.contentView addSubview:Xcell.ImageView];
                    }else{
                        //宽图
                        CGSize size = image.size;
                        CGFloat width = kScreenWidth;
                        CGFloat height = width * size.height / size.width;
                        if (height > kScreenHeight) {
                            height = kScreenHeight;
                            width = height * size.width / size.height;
                        }
                        Xcell.ImageView.frame = CGRectMake(0, 0, width, height);
                        if (height > kScreenHeight) {
                            CGPoint center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.f);
                            Xcell.ImageView.center = center;
                        }
                        [Xcell.contentView addSubview:Xcell.ImageView];
                    }
                }];
            }
            [Xcell.contentView addSubview:Xcell.ImageView];
        }else if (indexPath.row == 2){
            if ([PicArray[1] isKindOfClass:[NSNull class]]) {
                Xcell.SecondImageView.image = [UIImage imageNamed:@"哭脸.png"];
            }else{
                [Xcell.SecondImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,PicArray[1]]] placeholderImage:[UIImage imageNamed:@"PicDownload.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (!image) {
                        image = [UIImage imageNamed:@"哭脸.png"];
                        Xcell.SecondImageView.image = image;
                    }
                    //高图
                    if (image.size.height > image.size.width) {
                        CGFloat ImgeViewHeight = image.size.height / image.size.width * kScreenWidth;
                        Xcell.SecondImageView.frame = CGRectMake(0, 0, kScreenWidth, ImgeViewHeight);
                        [Xcell.contentView addSubview:Xcell.SecondImageView];
                    }else{
                        //宽图
                        CGSize size = image.size;
                        CGFloat width = kScreenWidth;
                        CGFloat height = width * size.height / size.width;
                        if (height > kScreenHeight) {
                            height = kScreenHeight;
                            width = height * size.width / size.height;
                        }
                        Xcell.SecondImageView.frame = CGRectMake(0, 0, width, height);
                        if (height > kScreenHeight) {
                            CGPoint center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.f);
                            Xcell.SecondImageView.center = center;
                        }
                        [Xcell.contentView addSubview:Xcell.SecondImageView];
                    }
                    
                }];
            }
            [Xcell.contentView addSubview:Xcell.SecondImageView];
        }else if (indexPath.row == 3){
            if ([PicArray[2] isKindOfClass:[NSNull class]]) {
                Xcell.ThreeImageView.image = [UIImage imageNamed:@"哭脸.png"];
            }else{
                [Xcell.ThreeImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,PicArray[2]]] placeholderImage:[UIImage imageNamed:@"PicDownload.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (!image) {
                        image = [UIImage imageNamed:@"哭脸.png"];
                        Xcell.ThreeImageView.image = image;
                    }
                    //高图
                    if (image.size.height > image.size.width) {
                        CGFloat ImgeViewHeight = image.size.height / image.size.width * kScreenWidth;
                        Xcell.ThreeImageView.frame = CGRectMake(0, 0, kScreenWidth, ImgeViewHeight);
                        [Xcell.contentView addSubview:Xcell.ThreeImageView];
                    }else{
                        //宽图
                        CGSize size = image.size;
                        CGFloat width = kScreenWidth;
                        CGFloat height = width * size.height / size.width;
                        if (height > kScreenHeight) {
                            height = kScreenHeight;
                            width = height * size.width / size.height;
                        }
                        Xcell.ThreeImageView.frame = CGRectMake(0, 0, width, height);
                        if (height > kScreenHeight) {
                            CGPoint center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.f);
                            Xcell.ThreeImageView.center = center;
                        }
                        [Xcell.contentView addSubview:Xcell.ThreeImageView];
                    }
                    
                }];
            }
            [Xcell.contentView addSubview:Xcell.ThreeImageView];
        }

        }
//    if (indexPath.row == 0) {
//        UILabel *TitleLAbel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth, 20)];
//        TitleLAbel.text = NoticeSTR;
//        TitleLAbel.backgroundColor = kAppRedColor;
//        TitleLAbel.numberOfLines = 0;
//        CGRect textFrame = TitleLAbel.frame;
//        TitleLAbel.frame = CGRectMake(10, 5, kScreenWidth-20, textFrame.size.height = [TitleLAbel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:TitleLAbel.font,NSFontAttributeName ,nil] context:nil].size.height);
//        TitleLAbel.frame = CGRectMake(10, 5, kScreenWidth-20, textFrame.size.height);
//        [cell.contentView addSubview:TitleLAbel];
//    }
        return Xcell;
    }
}


-(void)createData
{
    __weak typeof(self) weakSelf = self;
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"noticeId":self.EveryMessId} url:UrL_EveryPushMessage success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NoticeSTR = [RootDic objectForKey:@"fkOrgNotice"];
        NSArray *arr = [RootDic objectForKey:@"photoList"];
        for (NSDictionary *Dic in arr) {
            NSString *PicStr = [Dic objectForKey:@"location"];
            [PicArray addObject:PicStr];
        }
//        NSLog(@"看几张%ld",PicArray.count);
        [weakSelf createTableView];
    } failure:^(NSError *error) {
    }];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 200)/2, 10, 200, 30)];
    label.text = self.NavTitle;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    label.textAlignment = NSTextAlignmentCenter;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(PushEvelick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)PushEvelick:(UIButton *)btn
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
