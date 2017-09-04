//
//  TeacherManagerCell.m
//  ShangKOrganization
//
//  Created by apple on 16/10/17.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "TeacherManagerCell.h"

@implementation TeacherManagerCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _TeacherManagerPic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
    _TeacherManagerPic.layer.cornerRadius = 35;
    _TeacherManagerPic.layer.masksToBounds = YES;
    _TeacherManagerName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_TeacherManagerPic.frame)+15, 15, 120, 20)];
    _TeacherManagerName.font = [UIFont systemFontOfSize:17];
    _TeacherManageCount = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_TeacherManagerPic.frame)+15, CGRectGetMaxY(_TeacherManagerName.frame)+10, 200, 20)];
    _TeacherManageCount.font = [UIFont systemFontOfSize:17];
    _TeacherManagerSex = [[UIImageView alloc]init];
    _TeacherManagerSex.frame = CGRectMake(CGRectGetMaxX(_TeacherManagerName.frame)+5, 15, 20, 20);
    
    [self.contentView addSubview:_TeacherManagerPic];
    [self.contentView addSubview:_TeacherManagerName];
    [self.contentView addSubview:_TeacherManageCount];
    [self.contentView addSubview:_TeacherManagerSex];
}

-(void)configWithModel:(TeacherManagerModel *)Model
{
    _TeacherManagerName.text = [NSString stringWithFormat:@"教师:%@",Model.TeacherManagerNickName];
    _TeacherManageCount.text = [NSString stringWithFormat:@"负责课程:%ld门",(long)Model.TeacherManagerCourseCount];
    NSLog(@"%@",Model.TeacherManagerUserPhotoHead);
    [_TeacherManagerPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.TeacherManagerUserPhotoHead]] placeholderImage:nil];
}
@end
