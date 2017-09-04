//
//  MainBusinessCell.h
//  ShangKOrganization
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainBusinessModel.h"
@interface MainBusinessCell : UITableViewCell
@property (nonatomic,strong)UILabel *AlerdayChoose;
@property (nonatomic,strong)UILabel *AlerdayLine;

-(void)configWithModel:(MainBusinessModel *)Model;
@end
