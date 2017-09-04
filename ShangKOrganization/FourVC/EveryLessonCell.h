//
//  EveryLessonCell.h
//  ShangKOrganization
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EveryLessonModel.h"

@interface EveryLessonCell : UITableViewCell
@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)UIView       *topView;
@property (nonatomic,strong)UIButton     *btnSelected;
@property (nonatomic,strong)UIView       *FirstView;
@property (nonatomic,strong)UIView       *SecondView;
@property (nonatomic,strong)UILabel      *FirstOneTitle;
@property (nonatomic,strong)UILabel      *FirstZuTOneTitle;
@property (nonatomic,strong)UILabel      *SecondOneTitle;
@property (nonatomic,strong)UILabel      *LineLabel;
@property (nonatomic,strong)UITableView  *SecondTableView;

-(void)configWith:(EveryLessonModel *)Model;
@end
