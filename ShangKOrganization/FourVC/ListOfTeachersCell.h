//
//  ListOfTeachersCell.h
//  ShangKOrganization
//
//  Created by apple on 16/10/17.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListOfTeachersModel.h"
@interface ListOfTeachersCell : UITableViewCell
@property (nonatomic,strong)UIImageView *ListOfTeachersPic;
@property (nonatomic,strong)UILabel     *ListOfTeachersName;

-(void)configWithModel:(ListOfTeachersModel *)Model;
@end
