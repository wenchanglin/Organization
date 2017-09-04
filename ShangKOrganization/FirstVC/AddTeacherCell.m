//
//  AddTeacherCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "AddTeacherCell.h"
#import "UITextField+Extension.h"
@implementation AddTeacherCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]  ) {
        
        [self createUI];
    }

    return self;
}

-(void)createUI
{

    _MessLabel      = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    _MessLabel.font = [UIFont boldSystemFontOfSize:13];
    _MessLabel.textColor = kAppBlackColor;
    _textFieldMess  = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth - 140, 10, 130, 20)];
    _textFieldMess.adjustsFontSizeToFitWidth = YES;
    _textFieldMess.clearsOnBeginEditing = NO;
    _textFieldMess.font = [UIFont boldSystemFontOfSize:15];
    
    
    [self.contentView addSubview:_MessLabel];
    [self.contentView addSubview:_textFieldMess];

}

@end
