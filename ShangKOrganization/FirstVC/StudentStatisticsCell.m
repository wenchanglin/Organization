//
//  StudentStatisticsCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "StudentStatisticsCell.h"
@implementation StudentStatisticsCell

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
    _HeaderPic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    _HeaderPic.layer.cornerRadius = 40;
    _HeaderPic.layer.masksToBounds = YES;
    _NameLLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, kScreenWidth - 150, 15)];
    _NameLLabel.font = [UIFont boldSystemFontOfSize:15];
    
    _BaoMFsLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 40, kScreenWidth - 150, 15)];
    _BaoMFsLabel.font = [UIFont boldSystemFontOfSize:15];
    
    _BaoMTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 65, kScreenWidth - 150, 15)];
    _BaoMTimeLabel.font = [UIFont boldSystemFontOfSize:15];
    
    
    [self.contentView addSubview:_HeaderPic];
    [self.contentView addSubview:_NameLLabel];
    [self.contentView addSubview:_BaoMTimeLabel];
    [self.contentView addSubview:_BaoMFsLabel];
}

-(void)configWithMoDel:(StudentPeopleModel *)Model
{
    _NameLLabel.text = Model.StudentPeopleName;
    _BaoMFsLabel.text = [NSString stringWithFormat:@"联系方式%@",Model.StudentPeoplePhone];
    NSString * timeStampString = Model.StudentPeopleCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _BaoMTimeLabel.text = [NSString stringWithFormat:@"报名时间%@",time];
    if ([Model.StudentPeopleUserPhotoHead isKindOfClass:[NSNull class]] || Model.StudentPeopleUserPhotoHead == nil) {
        _HeaderPic.image = [UIImage imageNamed:@"哭脸.png"];
    }else{
        [_HeaderPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.StudentPeopleUserPhotoHead]] placeholderImage:nil];
    }
  
}
@end
