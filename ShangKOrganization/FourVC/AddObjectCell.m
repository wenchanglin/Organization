//
//  AddObjectCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/12.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "AddObjectCell.h"
@implementation AddObjectCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (140-kScreenWidth/3)/2, kScreenWidth/3, kScreenWidth/3)];
//    [self.contentView addSubview:_headerImgView];
    
    _headerImgView.layer.cornerRadius = kScreenWidth/3/2;
    _headerImgView.layer.masksToBounds = YES;
    _teacherName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headerImgView.frame)+5, 25, [UIScreen mainScreen].bounds.size.width-30, 30)];
    [self.contentView addSubview:_teacherName];
    _teacherName.numberOfLines = 0;
    _teacherName.font =[UIFont systemFontOfSize:16];
    _teacherName.textColor = kAppLightGrayColor;
    
    _teacherAge = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headerImgView.frame)+5, CGRectGetMaxY(_headerImgView.frame)-30, 120, 30)];
//    [self.contentView addSubview:_teacherAge];
    _teacherAge.numberOfLines = 0;
    _teacherAge.font =[UIFont systemFontOfSize:16];
    _teacherAge.textColor = kAppLightGrayColor;
    
    _jiantouPic = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-35, CGRectGetMaxY(_headerImgView.frame)/2, 10, 15)];
    [_jiantouPic setBackgroundImage:[UIImage imageNamed:@"图层-54-拷贝@2x_48.png"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:_jiantouPic];
}

-(void)configWithModel:(ListOfTeachersModel *)Model
{
   _teacherName.text = Model.ListOfTeacherNickName;
//    
//    if ([Model.ListOfTeacherUserPhotoHead isKindOfClass:[NSNull class]]||Model.ListOfTeacherUserPhotoHead.length == 0) {
//        _headerImgView.image = [UIImage imageNamed:@"图层-57@2x_41.png"];
//    }else{
//        [_headerImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.ListOfTeacherUserPhotoHead]] placeholderImage:nil];
//    }
    
}
@end
