//
//  TeachingAchienementCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "TeachingAchienementCell.h"

@implementation TeachingAchienementCell

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

    _BacView       = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-140)];
    _ImageView     = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-170)];
    
    _ImageView.contentMode = UIViewContentModeScaleToFill;
    _ImageView.autoresizesSubviews = YES;
    _ImageView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _titleLabel    = [[UILabel alloc]initWithFrame:CGRectMake(0, _BacView.frame.size.height - 30, kScreenWidth, 30)];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _titleLabel.backgroundColor = kAppGrayColor;
    _titleLabel.textColor = kAppWhiteColor;
    
    [_BacView addSubview:_ImageView];
    [_BacView addSubview:_titleLabel];
    [self.contentView addSubview:_BacView];
    
}

-(void)configWithModel:(TeachingAchienementModel *)model
{
    _titleLabel.text = model.AchienementName;
    [_ImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,model.AchienementHeadPhoto]] placeholderImage:nil];
}

@end
