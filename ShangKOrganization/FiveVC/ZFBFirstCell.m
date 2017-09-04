//
//  ZFBFirstCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ZFBFirstCell.h"

@implementation ZFBFirstCell

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
    
    _ZfLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    _ZfLabel.font = [UIFont boldSystemFontOfSize:15];
    _ZfLabel.text = @"账户金额";
    _JinELabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ZfLabel.frame)+20, 10, 200, 20)];
    _JinELabel.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:_ZfLabel];
    
}
@end
