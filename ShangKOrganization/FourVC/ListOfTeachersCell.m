//
//  ListOfTeachersCell.m
//  ShangKOrganization
//
//  Created by apple on 16/10/17.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ListOfTeachersCell.h"

@implementation ListOfTeachersCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _ListOfTeachersPic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
    
    _ListOfTeachersName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ListOfTeachersPic.frame)+15, 35, 200, 20)];
    _ListOfTeachersName.font = [UIFont systemFontOfSize:17];
    
    [self.contentView addSubview:_ListOfTeachersPic];
    [self.contentView addSubview:_ListOfTeachersName];
}

-(void)configWithModel:(ListOfTeachersModel *)Model
{
    _ListOfTeachersName.text = Model.ListOfTeacherNickName;
    if ([Model.ListOfTeacherUserPhotoHead isKindOfClass:[NSNull class]]||Model.ListOfTeacherUserPhotoHead.length == 0) {
        _ListOfTeachersPic.image = [UIImage imageNamed:@"图层-57@2x_59.png"];
    }else{
        [_ListOfTeachersPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.ListOfTeacherUserPhotoHead]] placeholderImage:nil];
    }
    
}
@end
