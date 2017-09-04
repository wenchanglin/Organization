//
//  OrganizationActivityCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "OrganizationActivityCell.h"
@implementation OrganizationActivityCell

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
    
    _headPic          = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
    
    _TitleLLabel      = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, kScreenWidth - 210, 15)];
    _TitleLLabel.numberOfLines = 1;
    _TitleLLabel.font = [UIFont boldSystemFontOfSize:16];
    _PayStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_TitleLLabel.frame)+10, 15, 100, 15)];
    _PayStatusLabel.font = [UIFont systemFontOfSize:16];
    _PayStatusLabel.textColor = kAppRedColor;
    _TimeLabel        = [[UILabel alloc]initWithFrame:CGRectMake(100, 40,kScreenWidth - 80, 15)];
    _TimeLabel.font   = [UIFont systemFontOfSize:15];
    _shareLabel       = [[UILabel alloc]initWithFrame:CGRectMake(100, 60,kScreenWidth - 80, 15)];
    
    _shareLabel.font  = [UIFont systemFontOfSize:15];
    _LineLabel        = [[UILabel alloc]initWithFrame:CGRectMake(0, 85, kScreenWidth, 1)];
    _LineLabel.backgroundColor = kAppLineColor;
    _ForwardLabel     = [[UILabel alloc]initWithFrame:CGRectMake(10, 95, 100, 15)];
    
    _ForwardLabel.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:_LineLabel];
    [self.contentView addSubview:_ForwardLabel];
    [self.contentView addSubview:_headPic];
    [self.contentView addSubview:_TitleLLabel];
    [self.contentView addSubview:_TimeLabel];
    [self.contentView addSubview:_PayStatusLabel];
    [self.contentView addSubview:_shareLabel];
}

-(void)configWithModel:(OrganizationActivityModel *)model
{
    if (model.ActivityPayStatus == 10) {
        _PayStatusLabel.text = @"(未付款)";
    }else{
        
    }
    if ([model.ActivityPhoto isKindOfClass:[NSNull class]]) {
        _headPic.image = [UIImage imageNamed:@"哭脸.png"];
    }else{
    [_headPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,model.ActivityPhoto]] placeholderImage:nil];
    }
    _TitleLLabel.text = model.ActivityName;
    _ForwardLabel.text = [NSString stringWithFormat:@"已转发:%ld次",(long)model.ActivityShareCount];
    if ([model.ActivityShareIncome isKindOfClass:[NSNull class]]) {
        _shareLabel.text  = [NSString stringWithFormat:@"分享奖励:无 有奖分享:次"];
    }else{
        if ([model.ActivityMaxCount isKindOfClass:[NSNull class]]||model.ActivityMaxCount == nil) {
            _shareLabel.text  = [NSString stringWithFormat:@"分享奖励:%@元/次 有奖分享:0次 共付:0元",model.ActivityShareIncome];
        }else{
           _shareLabel.text  = [NSString stringWithFormat:@"分享奖励:%@元/次 有奖分享:%@次 共付:%.2f元",model.ActivityShareIncome,model.ActivityMaxCount,model.ActivityShareIncome.floatValue * model.ActivityMaxCount.floatValue];
        }
    }
    NSString * timeStampString = model.ActivityTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _TimeLabel.text = [NSString stringWithFormat:@"发布时间 %@",time];
}

@end
