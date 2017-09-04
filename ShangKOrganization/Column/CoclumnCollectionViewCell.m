//
//  CoclumnCollectionViewCell.m
//  Column
//
//  Created by fujin on 15/11/18.
//  Copyright © 2015年 fujin. All rights reserved.
//

#import "CoclumnCollectionViewCell.h"
#import "Header.h"
#define RGBA(r,g,b,a)      [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
@implementation CoclumnCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self confingSubViews];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)confingSubViews{
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width , self.contentView.bounds.size.height)];
    self.contentLabel.center = self.contentView.center;
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.numberOfLines = 1;
    self.contentLabel.adjustsFontSizeToFitWidth = YES;
    self.contentLabel.minimumScaleFactor = 0.1;
    [self.contentView addSubview:self.contentLabel];
    self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 7.5, 15, 15)];
    [self.deleteButton setBackgroundImage:[UIImage imageNamed:@"关闭-拷贝@2x.png"] forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.deleteButton];
    self.tuPianImageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 7.5, 15, 15)];
    //self.tuPianImageV.backgroundColor = [UIColor redColor];
    self.tuPianImageV.image = [UIImage imageNamed:@"加好-拷贝@2x"];
    [self.contentView addSubview:self.tuPianImageV];
}
-(void)configCell:(NSArray *)dataArray withIndexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    self.contentLabel.hidden = NO;
    self.contentLabel.text = dataArray[indexPath.row];

    self.contentLabel.textColor = RGBA(101, 101, 101, 1);
    self.contentLabel.layer.masksToBounds = YES;
    self.contentLabel.layer.cornerRadius = CGRectGetHeight(self.contentView.bounds) * 0.5;
    self.contentLabel.layer.borderColor = RGBA(211, 211, 211, 1).CGColor;
    self.contentLabel.layer.borderWidth = 0.45;
}
-(void)deleteAction:(UIButton *)sender{
    if ([self.deleteDelegate respondsToSelector:@selector(deleteItemWithIndexPath:)]) {
        [self.deleteDelegate deleteItemWithIndexPath:self.indexPath];
    }
}
-(void)dealloc{
    for (UIPanGestureRecognizer *pan in self.gestureRecognizers) {
        [self removeGestureRecognizer:pan];
    }
}
@end
