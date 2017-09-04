//
//  ShelvesCourseCell.h
//  ShangKOrganization
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShelvesModel.h"
@interface ShelvesCourseCell : UITableViewCell
@property (nonatomic,strong)UIImageView *ShelvesPic;
@property (nonatomic,strong)UILabel     *ShelvesTextLabel;
@property (nonatomic,strong)UILabel     *ShelvesBuyLabel;
@property (nonatomic,strong)UILabel     *ShelvesTimeLabel;
@property (nonatomic,strong)UILabel     *ShelvesLineLabel;
@property (nonatomic,strong)UILabel     *ShelvesPriceLabel;

-(void)configWithModel:(ShelvesModel *)Model;
@end
