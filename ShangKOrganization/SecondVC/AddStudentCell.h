//
//  AddStudentCell.h
//  ShangKOrganization
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddStudentModel.h"
@interface AddStudentCell : UITableViewCell
@property (nonatomic,strong)UIImageView *AddimageView;
@property (nonatomic,strong)UILabel *AddNameLabel;

-(void)configWithModel:(AddStudentModel *)Model;
@end
