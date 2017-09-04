//
//  FirstCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/15.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FirstCell.h"

@implementation FirstCell

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
    _TitleLabel        = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    _TitleLabel.font   = [UIFont systemFontOfSize:17];
    _PeopleLabel       = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_TitleLabel.frame)+15, 10, kScreenWidth - (CGRectGetMaxX(_TitleLabel.frame)+25), 20)];
    _PeopleLabel.font  = [UIFont systemFontOfSize:17];
    _PeopleLabel.lineBreakMode = NSLineBreakByWordWrapping;

    
    [self.contentView addSubview:_TitleLabel];
    [self.contentView addSubview:_PeopleLabel];
}





@end
