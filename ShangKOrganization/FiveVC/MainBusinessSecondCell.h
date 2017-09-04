//
//  MainBusinessSecondCell.h
//  ShangKOrganization
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainBusinessModel.h"
@interface MainBusinessSecondCell : UITableViewCell
@property (nonatomic,strong)UILabel *SecondAlerdayChoose;
@property (nonatomic,strong)UILabel *SecondAlerdayLine;
@property (nonatomic,strong)UIButton *SecondAlerdayButton;

-(void)configWithModel:(MainBusinessModel *)Model;
@end
