//
//  CourseOrdersCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "CourseOrdersCell.h"

@implementation CourseOrdersCell

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
    _OrderPic            = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    _OrderPic.image      = [UIImage imageNamed:@"图层-68@2x.png"];
    _OrderTextLabel      = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, kScreenWidth - 110, 15)];
    _OrderTextLabel.font = [UIFont boldSystemFontOfSize:16];
    _OrderBuyLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 45, kScreenWidth - 110, 10)];
    _OrderBuyLabel.font  = [UIFont systemFontOfSize:14];
    _OrderTimeLabel      = [[UILabel alloc]initWithFrame:CGRectMake(100, 65, kScreenWidth - 110, 10)];
    _OrderTimeLabel.font = [UIFont systemFontOfSize:14];
    _LineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 95, kScreenWidth, 1)];
    _LineLabel.alpha     = 0.5;
    _LineLabel.backgroundColor = kAppLineColor;
    
    [self.contentView addSubview:_OrderPic];
    [self.contentView addSubview:_LineLabel];
    [self.contentView addSubview:_OrderTimeLabel];
    [self.contentView addSubview:_OrderBuyLabel];
    [self.contentView addSubview:_OrderTextLabel];

}

-(void)configWithModel:(CourseOrdersModel *)Model
{
    _OrderTextLabel.text = Model.CourseOrderName;
    _OrderBuyLabel.text  = [NSString stringWithFormat:@"购买人:%@ %@",Model.CourseOrderContactName,Model.CourseOrderContactPhone];
    NSString * timeStampString = Model.CourseOrderCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _OrderTimeLabel.text = [NSString stringWithFormat:@"%@",time];
    //[_OrderPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",Model.CourseOrderContactPhotoList]] placeholderImage:nil];
}
















@end
