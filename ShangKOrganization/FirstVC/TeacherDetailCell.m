//
//  TeacherDetailCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "TeacherDetailCell.h"

@implementation TeacherDetailCell

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
    _DetailsPic               = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    _DetailsTextLabel     = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, kScreenWidth - 110, 15)];
    
    _DetailsTextLabel.font = [UIFont boldSystemFontOfSize:16];
    _DetailsBaoMingLabel  = [[UILabel alloc]initWithFrame:CGRectMake(100, 45, kScreenWidth - 110, 10)];
    _DetailsBaoMingLabel.font = [UIFont systemFontOfSize:15];
    _DetailsClassLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 75, kScreenWidth - 110, 10)];
    
    _DetailsClassLabel.font   = [UIFont systemFontOfSize:15];
    
    
    [self.contentView addSubview:_DetailsPic];
    [self.contentView addSubview:_DetailsTextLabel];
    [self.contentView addSubview:_DetailsBaoMingLabel];
    [self.contentView addSubview:_DetailsClassLabel];
    
}

-(void)configWithModel:(TeacherDetailsModel *)model
{
    _DetailsTextLabel.text = model.TeacherDetailsName;
    NSString * timeStampString = model.TeacherDetailsCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _DetailsClassLabel.text = [NSString stringWithFormat:@"%@",time];
    _DetailsBaoMingLabel.text = [NSString stringWithFormat:@"已报名:%ld人 计划招生:%ld人",(long)model.TeacherDetailsSubmitCount,(long)model.TeacherDetailsBuyCount];
    if ([model.TeacherDetailsPicPhoto isKindOfClass:[NSNull class]]) {
        _DetailsPic.image         = [UIImage imageNamed:@"图层-68@2x.png"];
    }else{
        [_DetailsPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,model.TeacherDetailsPicPhoto]] placeholderImage:nil];
    }
}
@end
