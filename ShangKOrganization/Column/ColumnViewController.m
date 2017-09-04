//
//  ColumnViewController.m
//  Column
//
//  Created by fujin on 15/11/18.
//  Copyright © 2015年 fujin. All rights reserved.
//

#import "ColumnViewController.h"
#import "CoclumnCollectionViewCell.h"
#import "ColumnReusableView.h"
#import "Header.h"
#define RGBA(r,g,b,a)      [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
#define SPACE 10.0
static NSString *cellIdentifier = @"CoclumnCollectionViewCell";
static NSString *headOne = @"ColumnReusableViewOne";
static NSString *headTwo = @"ColumnReusableViewTwo";
@interface ColumnViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DeleteDelegate>
/**
 *  collectionView
 */
@property (nonatomic, strong)UICollectionView *collectionView;
/**
 *  Whether sort
 */
@property (nonatomic, assign)BOOL isSort;
/**
 * Whether hidden the last
 */
@property (nonatomic, assign)BOOL lastIsHidden;
/**
 *  animation label（insert）
 */
@property (nonatomic, strong)UILabel *animationLabel;
/**
 *  attributes of all cells
 */
@property (nonatomic, strong)NSMutableArray *cellAttributesArray;

@end

@implementation ColumnViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.selectedArray = [[NSMutableArray alloc] init];
        self.optionalArray = [[NSMutableArray alloc] init];
        self.AddSElectArray = [NSMutableArray array];
        
        self.cellAttributesArray = [[NSMutableArray alloc] init];
        
        self.animationLabel = [[UILabel alloc] init];
        self.animationLabel.textAlignment = NSTextAlignmentCenter;
        self.animationLabel.font = [UIFont systemFontOfSize:15];
        self.animationLabel.numberOfLines = 1;
        self.animationLabel.adjustsFontSizeToFitWidth = YES;
        self.animationLabel.minimumScaleFactor = 0.1;
        self.animationLabel.textColor = RGBA(101, 101, 101, 1);
        self.animationLabel.layer.masksToBounds = YES;
        self.animationLabel.layer.borderColor = RGBA(211, 211, 211, 1).CGColor;
        self.animationLabel.layer.borderWidth = 0.45;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isSort = YES;
    self.view.backgroundColor = kAppWhiteColor;
    [self createNav];
    [self configCollection];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"课程分类";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 40, 30);
    [button2 setTitle:@"保存" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:16];
    [button2 addTarget:self action:@selector(BaoCunAddClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)BaoCunAddClick:(UIButton *)BT
{
    NSLog(@"保存");
}

-(void)BaCklick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)setLeftItem{
//    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIEdgeInsets inset   = UIEdgeInsetsMake(0, -15, 0, 0);
//    leftButton.contentEdgeInsets = inset;
//    leftButton.frame = CGRectMake(0, 0, 30, 30);
//    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
//    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    self.navigationItem.leftBarButtonItem = backItem;
//}
//-(void)back:(UIButton *)sender{
//    [self.navigationController popViewControllerAnimated:YES];
//}

#pragma mark ----------------- collectionInscance ---------------------
-(void)configCollection{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth,kScreenHeight-64) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[CoclumnCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.collectionView registerClass:[ColumnReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headOne];
    [self.collectionView registerClass:[ColumnReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headTwo];
    [self.collectionView reloadData];
}
#pragma mark ----------------- sort ---------------------
-(void)sortItem:(UIPanGestureRecognizer *)pan{
    CoclumnCollectionViewCell *cell = (CoclumnCollectionViewCell *)pan.view;
    NSIndexPath *cellIndexPath = [self.collectionView indexPathForCell:cell];
    
    //开始  获取所有cell的attributes
    if (pan.state == UIGestureRecognizerStateBegan) {
        [self.cellAttributesArray removeAllObjects];
        for (NSInteger i = 0 ; i < self.selectedArray.count; i++) {
            [self.cellAttributesArray addObject:[self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
        }
    }
    
    CGPoint point = [pan translationInView:self.collectionView];
    cell.center = CGPointMake(cell.center.x + point.x, cell.center.y + point.y);
    [pan setTranslation:CGPointMake(0, 0) inView:self.collectionView];
    
    //进行是否排序操作
    BOOL ischange = NO;
    for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
        CGRect rect = CGRectMake(attributes.center.x - 6, attributes.center.y - 6, 12, 12);
        if (CGRectContainsPoint(rect, CGPointMake(pan.view.center.x, pan.view.center.y)) & (cellIndexPath != attributes.indexPath)) {
            
            //后面跟前面交换
            if (cellIndexPath.row > attributes.indexPath.row) {
                //交替操作0 1 2 3 变成（3<->2 3<->1 3<->0）
                for (NSInteger index = cellIndexPath.row; index > attributes.indexPath.row; index -- ) {
                    [self.selectedArray exchangeObjectAtIndex:index withObjectAtIndex:index - 1];
                }
            }
            //前面跟后面交换
            else{
                //交替操作0 1 2 3 变成（0<->1 0<->2 0<->3）
                for (NSInteger index = cellIndexPath.row; index < attributes.indexPath.row; index ++ ) {
                    [self.selectedArray exchangeObjectAtIndex:index withObjectAtIndex:index + 1];
                }
            }
            ischange = YES;
            [self.collectionView moveItemAtIndexPath:cellIndexPath toIndexPath:attributes.indexPath];
        }
        else{
            ischange = NO;
        }
    }
    
    //结束
    if (pan.state == UIGestureRecognizerStateEnded){
        if (ischange) {
            
        }
        else{
            cell.center = [self.collectionView layoutAttributesForItemAtIndexPath:cellIndexPath].center;
        }
    }
}

#pragma mark ----------------- delete ---------------------
-(void)deleteItemWithIndexPath:(NSIndexPath *)indexPath{
    //数据整理
    [self.optionalArray insertObject:[self.selectedArray objectAtIndex:indexPath.row] atIndex:0];
    [self.selectedArray removeObjectAtIndex:indexPath.row];
    
   // self.isSort = NO;
    if (self.cellAttributesArray.count) {
        for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
            CoclumnCollectionViewCell *cell = (CoclumnCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:attributes.indexPath];
            for (UIPanGestureRecognizer *pan in cell.gestureRecognizers) {
                [cell removeGestureRecognizer:pan];
            }
        }
    }

     [self.collectionView reloadData];
    if (indexPath.section ==0) {
       // [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];

    }

    //删除之后更新collectionView上对应cell的indexPath
    for (NSInteger i = 0; i < self.selectedArray.count; i++) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CoclumnCollectionViewCell *cell = (CoclumnCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:newIndexPath];
        cell.indexPath = newIndexPath;
    }
    
}
#pragma mark ----------------- insert ---------------------
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FbwManager *Manager = [FbwManager shareManager];
    if (indexPath.section == 1) {
        self.lastIsHidden = YES;
        
        CoclumnCollectionViewCell *endCell = (CoclumnCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        endCell.contentLabel.hidden = YES;
        NSLog(@"你怕不怕%@",self.AddSElectArray[indexPath.row]);
        NSArray *arr = @[@{@"id":self.AddSElectArray[indexPath.row]}];
        NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        [self.selectedArray addObject:[self.optionalArray objectAtIndex:indexPath.row]];
        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orgId":Manager.UUserId,@"classIdListStr":jsonStr} url:UrL_AddOrgDetail success:^(id responseObject) {
            NSLog(@"我真的最%@",responseObject);
        } failure:^(NSError *error) {
            
        }];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        //[self.collectionView reloadData];
        
        //移动开始的attributes
        UICollectionViewLayoutAttributes *startAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
        
        self.animationLabel.frame = CGRectMake(startAttributes.frame.origin.x, startAttributes.frame.origin.y, startAttributes.frame.size.width , startAttributes.frame.size.height);
        self.animationLabel.layer.cornerRadius = CGRectGetHeight(self.animationLabel.bounds) * 0.5;
        self.animationLabel.text = [self.optionalArray objectAtIndex:indexPath.row];
        [self.collectionView addSubview:self.animationLabel];
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:self.selectedArray.count-1 inSection:0];
        
        //移动终点的attributes
        UICollectionViewLayoutAttributes *endAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:toIndexPath];
        
        typeof(self) __weak weakSelf = self;
        //移动动画
        [UIView animateWithDuration:0.7 animations:^{
            weakSelf.animationLabel.center = endAttributes.center;
        } completion:^(BOOL finished) {
            //展示最后一个cell的contentLabel
            CoclumnCollectionViewCell *endCell = (CoclumnCollectionViewCell *)[weakSelf.collectionView cellForItemAtIndexPath:toIndexPath];
            endCell.contentLabel.hidden = NO;
            
            weakSelf.lastIsHidden = NO;
            [weakSelf.animationLabel removeFromSuperview];
            [weakSelf.optionalArray removeObjectAtIndex:indexPath.row];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];

            if (indexPath.section ==0) {
                [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];

            }
        }];
        
    }
}

#pragma mark ----------------- item(样式) ---------------------
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenWidth - (5*SPACE)) / 3.0, 30);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(SPACE, SPACE, SPACE, SPACE);
    }else{
        return UIEdgeInsetsMake(30, SPACE, SPACE, SPACE);
    }

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return SPACE;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return SPACE;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 40.0);
    }
    else{
        return CGSizeMake(kScreenWidth, 10.0);
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return  CGSizeMake(kScreenWidth, 0.0);
}

#pragma mark ----------------- collectionView(datasouce) ---------------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.selectedArray.count;
    }
    else{
        return self.optionalArray.count;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ColumnReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        if (indexPath.section == 0) {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headOne forIndexPath:indexPath];
            reusableView.buttonHidden = NO;
            reusableView.clickButton.selected = self.isSort;
            reusableView.backgroundColor = kAppWhiteColor;
            reusableView.titleLabel.text = @"已选";
            
            
        }else{
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headTwo forIndexPath:indexPath];
            reusableView.buttonHidden = YES;
            reusableView.backgroundColor = KAppBackBgColor;
            reusableView.titleLabel.text = @"未选";
        }
    }
    return (UICollectionReusableView *)reusableView;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CoclumnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.tuPianImageV.hidden = YES;
        [cell configCell:self.selectedArray withIndexPath:indexPath];
           cell.deleteDelegate = self;
           cell.deleteButton.hidden = !self.isSort;
            if (self.isSort) {
                UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(sortItem:)];
                [cell addGestureRecognizer:pan];
            }
            else{
                
            }
    }else{
        [cell configCell:self.optionalArray withIndexPath:indexPath];
        cell.tuPianImageV.hidden = NO;
        cell.deleteButton.hidden = YES;
        
    }
    return cell;
}
-(void)dealloc{
    NSLog(@"dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
