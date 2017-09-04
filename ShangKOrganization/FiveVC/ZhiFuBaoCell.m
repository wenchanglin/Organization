//
//  ZhiFuBaoCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ZhiFuBaoCell.h"

@implementation ZhiFuBaoCell

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
    
    _ZfbLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    _ZfbLabel.font = [UIFont boldSystemFontOfSize:15];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ZfbLabel.frame)+20, 10, 200, 20)];
//    _textField.placeholder = @"请输入价格...";
    _textField.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_textField];
    [self.contentView addSubview:_ZfbLabel];

}









@end
