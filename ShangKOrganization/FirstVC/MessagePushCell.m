//
//  MessagePushCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MessagePushCell.h"
@implementation MessagePushCell

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
    _BiaoTiLabel      = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth, 15)];
    _BiaoTiLabel.font = [UIFont boldSystemFontOfSize:16];
    
    _OffersLabel      = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_BiaoTiLabel.frame)+15, kScreenWidth, 10)];
    _OffersLabel.font = [UIFont systemFontOfSize:14];
    _TimeLabel        = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_OffersLabel.frame)+15, kScreenWidth, 10)];
    _TimeLabel.font   = [UIFont systemFontOfSize:14];
    
    _NextPic          = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 30, CGRectGetMaxY(_BiaoTiLabel.frame)+15, 15, 15)];
    _NextPic.image    = [UIImage imageNamed:@"图层-72@2x.png"];
    
    [self.contentView addSubview:_BiaoTiLabel];
//    [self.contentView addSubview:_OffersLabel];
    [self.contentView addSubview:_TimeLabel];
    [self.contentView addSubview:_NextPic];
}

-(void)configWithModel:(MessagePushModel *)Model
{
    _BiaoTiLabel.text = Model.PushMessageTitle;
    NSString * timeStampString = Model.PushMessageCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _TimeLabel.text = [NSString stringWithFormat:@"%@",time];
}









@end
