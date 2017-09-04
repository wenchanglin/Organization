//
//  SetAdminCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SetAdminCell.h"
@implementation SetAdminCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _ImagePic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    _TitLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ImagePic.frame)+20, 20, 100, 20)];
    
    _TitLabel.font =[UIFont systemFontOfSize:15];
    
//    [self.contentView addSubview:_ImagePic];
    [self.contentView addSubview:_TitLabel];
}

-(void)configWithModel:(TeacherManagerModel *)Model
{
   _TitLabel.text = Model.TeacherManagerNickName;
}
@end
