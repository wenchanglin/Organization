//
//  CompanyProfileCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/15.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "CompanyProfileCell.h"
@implementation CompanyProfileCell

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
    _ActivityHome = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 60, 30)];
    [self.contentView addSubview:_ActivityHome];
    _ActivityHome.font = [UIFont systemFontOfSize:14];
    _ActivityHome.text = @"段落一";
    _ActivitySecondHome = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ActivitySecondHome.frame)+60, 20,[UIScreen mainScreen].bounds.size.width-20, 30)];
    [self.contentView addSubview:_ActivitySecondHome];
    _ActivitySecondHome.text = @"(只能上传一张图片哦)";
    _ActivitySecondHome.textColor = [UIColor lightGrayColor];
    _ActivitySecondHome.font = [UIFont systemFontOfSize:14];
    _FirstButton = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_ActivitySecondHome.frame)+10, 160, 160)];
    [self.contentView addSubview:_FirstButton];
    [_FirstButton setBackgroundImage:[UIImage imageNamed:@"矩形-2-拷贝@2x.png"] forState:UIControlStateNormal];
    _FirstButton.backgroundColor = [UIColor cyanColor];
    
    _FirstTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_FirstButton.frame)+10, [UIScreen mainScreen].bounds.size.width-30, 120)];
    _FirstTextView.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_FirstTextView];
    _FirstTextView.backgroundColor = kAppWhiteColor;
    _ActivityName = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(_FirstButton.frame)+8, 120, 30)];
    [self.contentView addSubview:_ActivityName];
    _ActivityName.text = @"请输入文字...";
    _ActivityName.font = [UIFont systemFontOfSize:15];
    _ActivityName.textColor = [UIColor lightGrayColor];

}

@end
