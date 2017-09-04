//
//  TeacherDetailCell.h
//  ShangKOrganization
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherDetailsModel.h"
@interface TeacherDetailCell : UITableViewCell
@property (nonatomic,strong)UIImageView *DetailsPic;
@property (nonatomic,strong)UILabel     *DetailsTextLabel;
@property (nonatomic,strong)UILabel     *DetailsBaoMingLabel;
@property (nonatomic,strong)UILabel     *DetailsClassLabel;

-(void)configWithModel:(TeacherDetailsModel *)model;
@end
