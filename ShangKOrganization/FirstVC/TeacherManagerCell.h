//
//  TeacherManagerCell.h
//  ShangKOrganization
//
//  Created by apple on 16/10/17.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherManagerModel.h"
@interface TeacherManagerCell : UITableViewCell
@property (nonatomic,strong)UIImageView *TeacherManagerPic;
@property (nonatomic,strong)UIImageView *TeacherManagerSex;
@property (nonatomic,strong)UILabel     *TeacherManagerName;
@property (nonatomic,strong)UILabel     *TeacherManageCount;

-(void)configWithModel:(TeacherManagerModel *)Model;
@end
