//
//  SetAdminCell.h
//  ShangKOrganization
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherManagerModel.h"
@interface SetAdminCell : UITableViewCell
@property (nonatomic,strong)UIImageView *ImagePic;
@property (nonatomic,strong)UILabel     *TitLabel;

-(void)configWithModel:(TeacherManagerModel *)Model;
@end
