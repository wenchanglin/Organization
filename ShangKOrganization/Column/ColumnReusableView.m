//
//  ColumnReusableView.m
//  Column
//
//  Created by fujin on 15/11/19.
//  Copyright © 2015年 fujin. All rights reserved.
//

#import "ColumnReusableView.h"
#import "Header.h"
#define RGBA(r,g,b,a)      [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
@interface ColumnReusableView ()
@property (nonatomic, copy)ClickBlock clickBlock;

@end
@implementation ColumnReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self confingSubViews];
    }
    return self;
}
-(void)confingSubViews{
//    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, self.bounds.size.height)];
//    self.titleLabel.font = [UIFont systemFontOfSize:14];
//    self.titleLabel.textColor = RGBA(51, 51, 51, 1);
//    [self addSubview:self.titleLabel];
    self.leftLine = [[UIView alloc]initWithFrame:CGRectMake(10, 24, ([UIScreen mainScreen].bounds.size.width-40)/2, 1)];
    self.leftLine.backgroundColor = [UIColor greenColor];
    [self addSubview:self.leftLine];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-40)/2, 10, 30, 30)];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    //    self.titleLabel.backgroundColor  = [UIColor redColor];
    self.titleLabel.textColor = RGBA(51, 51, 51, 1);
    [self addSubview:self.titleLabel];
    self.rightLine = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 24, ([UIScreen mainScreen].bounds.size.width-40)/2, 1)];
    self.rightLine.backgroundColor = [UIColor greenColor];
    [self addSubview:self.rightLine];
    
//    self.clickButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width - 80, 10, 60, 20)];
//    self.clickButton.titleLabel.font = [UIFont systemFontOfSize:13];
//    self.clickButton.backgroundColor = [UIColor whiteColor];
//    self.clickButton.layer.masksToBounds = YES;
//    self.clickButton.layer.cornerRadius = 10;
//    self.clickButton.layer.borderColor = RGBA(214, 39, 48, 1).CGColor;
//    self.clickButton.layer.borderWidth = 0.7;
//   // [self.clickButton setTitle:@"排序删除" forState:UIControlStateNormal];
//   // [self.clickButton setTitle:@"完成" forState:UIControlStateSelected];
//    [self.clickButton setTitleColor:RGBA(214, 39, 48, 1) forState:UIControlStateNormal];
//    [self.clickButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.clickButton];
}
-(void)clickWithBlock:(ClickBlock)clickBlock{
    if (clickBlock) {
        self.clickBlock = clickBlock;
    }
}
-(void)clickAction:(UIButton *)sender{
//    self.clickButton.selected = !self.clickButton.selected;
//    if (sender.selected) {
//        self.clickBlock(StateSortDelete);
//    }else{
//        self.clickBlock(StateComplish);
//    }
    
}
#pragma mark ----------- set ---------------
-(void)setButtonHidden:(BOOL)buttonHidden{
    if (buttonHidden != _buttonHidden) {
        self.clickButton.hidden = buttonHidden;
        _buttonHidden = buttonHidden;
    }
}
@end
