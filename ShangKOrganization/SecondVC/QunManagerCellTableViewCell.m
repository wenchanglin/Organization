//
//  QunManagerCellTableViewCell.m
//  ShangKOrganization
//
//  Created by apple on 17/1/9.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import "QunManagerCellTableViewCell.h"

@implementation QunManagerCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _QunImagePic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    _QunTitLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_QunImagePic.frame)+20, 20, 100, 20)];
    
    _QunTitLabel.font =[UIFont systemFontOfSize:15];
    
    //    [self.contentView addSubview:_ImagePic];
    [self.contentView addSubview:_QunTitLabel];
}

-(void)configWithModel:(QunManagerModel *)Model
{
    _QunTitLabel.text = Model.QunManagerNickName;
}


@end
