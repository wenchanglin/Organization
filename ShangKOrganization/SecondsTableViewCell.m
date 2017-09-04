//
//  SecondsTableViewCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/9.
//  Copyright © 2016年 Fbw. All rights reserved.
//
#import "SecondsTableViewCell.h"
@implementation SecondsTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 80, 30)];
    [self.contentView addSubview:_firstLabel];
    _firstLabel.font = [UIFont systemFontOfSize:18];
    _firstLabel.text =@"分享奖励:";
    _firstTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_firstLabel.frame)+2, 20, 100, 30)];
    [self.contentView addSubview:_firstTF];
    _firstTF.placeholder= @"请输入1-10000";
    _firstTF.font = [UIFont systemFontOfSize:13];
    _secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_firstTF.frame)+2, 20, 50, 30)];
    [self.contentView addSubview:_secondLabel];
    _secondLabel.font =[UIFont systemFontOfSize:18];
    _secondLabel.text = @"元/次";
    _threeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_firstLabel.frame)+5, kScreenWidth-30, 35)];
    [self.contentView addSubview:_threeLabel];
    _threeLabel.numberOfLines = 0;
    _threeLabel.adjustsFontSizeToFitWidth = YES;
    _threeLabel.font =[UIFont systemFontOfSize:16];
    _threeLabel.textColor = [UIColor lightGrayColor];
    _threeLabel.text =@"(设置每次分享可以获得多少奖励，不填或为0则没有奖励)";
    
    _fourLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_threeLabel.frame)+10, 80, 30)];
    [self.contentView addSubview:_fourLabel];
    _fourLabel.font = [UIFont systemFontOfSize:18];
    _fourLabel.text =@"有奖次数:";
    _secondTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_fourLabel.frame)+2, CGRectGetMaxY(_threeLabel.frame)+10, 100, 30)];
    [self.contentView addSubview:_secondTF];
    _secondTF.placeholder= @"请输入1-10000";
    _secondTF.font = [UIFont systemFontOfSize:13];
    _fiveLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_secondTF.frame)+2, CGRectGetMaxY(_threeLabel.frame)+10, 50, 30)];
    [self.contentView addSubview:_fiveLabel];
    _fiveLabel.font =[UIFont systemFontOfSize:18];
    _fiveLabel.text = @"次";
    _sixLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_fiveLabel.frame)+5, kScreenWidth-30, 35)];
    [self.contentView addSubview:_sixLabel];
    _sixLabel.numberOfLines = 0;
    _sixLabel.font =[UIFont systemFontOfSize:16];
    _sixLabel.textColor = [UIColor lightGrayColor];
    _sixLabel.text =@"(设置有奖励分享次数，不填或为0 则没有奖励)";
    _sixLabel.adjustsFontSizeToFitWidth = YES;
    
    _sevenLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_sixLabel.frame)+10, 80, 30)];
    [self.contentView addSubview:_sevenLabel];
    _sevenLabel.font = [UIFont systemFontOfSize:18];
    _sevenLabel.text =@"最高每人:";
    _threeTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_sevenLabel.frame)+2, CGRectGetMaxY(_sixLabel.frame)+10, 100, 30)];
    [self.contentView addSubview:_threeTF];
    _threeTF.placeholder= @"请输入1-10000";
    _threeTF.font = [UIFont systemFontOfSize:13];
    _eightLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_threeTF.frame)+2, CGRectGetMaxY(_sixLabel.frame)+10, 50, 30)];
    [self.contentView addSubview:_eightLabel];
    _eightLabel.font =[UIFont systemFontOfSize:18];
    _eightLabel.text = @"次";
    _nieLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_eightLabel.frame)+5, kScreenWidth-30, 35)];
    [self.contentView addSubview:_nieLabel];
    _nieLabel.numberOfLines = 0;
    _nieLabel.font =[UIFont systemFontOfSize:16];
    _nieLabel.textColor = [UIColor lightGrayColor];
    _nieLabel.text =@"(设置该活动每人最多分享多少，不填或为0 则没有限制)";
    _nieLabel.adjustsFontSizeToFitWidth = YES;
    
   
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_firstTF resignFirstResponder];
    [_secondTF resignFirstResponder];
}
@end
