//
//  AddObjectCell.h
//  ShangKOrganization
//
//  Created by apple on 16/9/12.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListOfTeachersModel.h"
@interface AddObjectCell : UITableViewCell
@property(nonatomic,strong)UIImageView * headerImgView;
@property(nonatomic,strong)UILabel * teacherName;
@property(nonatomic,strong)UILabel * teacherAge;
@property(nonatomic,strong)UIButton * jiantouPic;

-(void)configWithModel:(ListOfTeachersModel *)Model;
@end
