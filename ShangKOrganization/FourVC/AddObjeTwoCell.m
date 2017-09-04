//
//  AddObjeTwoCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/12.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "AddObjeTwoCell.h"
@implementation AddObjeTwoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    
    
    _coursePrices = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 80, 30)];
    [self.contentView addSubview:_coursePrices];
    _coursePrices.font = [UIFont systemFontOfSize:18];
    _coursePrices.text =@"课程价格";
    _firstTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_coursePrices.frame)+2, 20, 100, 30)];
    [self.contentView addSubview:_firstTF];
    _firstTF.placeholder = @"请输入价格...";
    _firstTF.font = [UIFont systemFontOfSize:13];
    _FirstLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_coursePrices.frame)+10, 80, 30)];
    [self.contentView addSubview:_FirstLabel];
    _FirstLabel.font = [UIFont systemFontOfSize:18];
    _FirstLabel.text =@"分享奖励:";
    _FirstTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FirstLabel.frame)+2, CGRectGetMaxY(_coursePrices.frame)+10, 100, 30)];
    [self.contentView addSubview:_FirstTF];
    _FirstTF.placeholder= @"请输入1-10000";
    _FirstTF.font = [UIFont systemFontOfSize:13];
    _SecondLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FirstTF.frame)+2, CGRectGetMaxY(_coursePrices.frame)+10, 50, 30)];
    [self.contentView addSubview:_SecondLabel];
    _SecondLabel.font =[UIFont systemFontOfSize:18];
    _SecondLabel.text = @"元/次";
    _ThreeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_FirstLabel.frame)+5, kScreenWidth-30, 35)];
    [self.contentView addSubview:_ThreeLabel];
    _ThreeLabel.numberOfLines = 0;
    _ThreeLabel.font =[UIFont systemFontOfSize:16];
    _ThreeLabel.textColor = [UIColor lightGrayColor];
    _ThreeLabel.text =@"(设置每次分享可以获得多少奖励，不填或为0则没有奖励)";
    _ThreeLabel.adjustsFontSizeToFitWidth = YES;
    
    _FourLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_ThreeLabel.frame)+10, 80, 30)];
    [self.contentView addSubview:_FourLabel];
    _FourLabel.font = [UIFont systemFontOfSize:18];
    _FourLabel.text =@"有奖次数:";
    _SecondTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FourLabel.frame)+2, CGRectGetMaxY(_ThreeLabel.frame)+10, 100, 30)];
    [self.contentView addSubview:_SecondTF];
    _SecondTF.placeholder= @"请输入1-10000";
    _SecondTF.font = [UIFont systemFontOfSize:13];
    _FiveLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_SecondTF.frame)+2, CGRectGetMaxY(_ThreeLabel.frame)+10, 50, 30)];
    [self.contentView addSubview:_FiveLabel];
    _FiveLabel.font =[UIFont systemFontOfSize:18];
    _FiveLabel.text = @"次";
    _SixLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_FiveLabel.frame)+5, kScreenWidth-30, 35)];
    [self.contentView addSubview:_SixLabel];
    _SixLabel.numberOfLines = 0;
    _SixLabel.font =[UIFont systemFontOfSize:16];
    _SixLabel.textColor = [UIColor lightGrayColor];
    _SixLabel.text =@"(设置有奖励分享次数，不填或为0 则没有奖励)";
    _SixLabel.adjustsFontSizeToFitWidth = YES;
    
    _SevenLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_SixLabel.frame)+10, 80, 30)];
    [self.contentView addSubview:_SevenLabel];
    _SevenLabel.font = [UIFont systemFontOfSize:18];
    _SevenLabel.text =@"最高每人:";
    _ThreeTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_SevenLabel.frame)+2, CGRectGetMaxY(_SixLabel.frame)+10, 100, 30)];
    [self.contentView addSubview:_ThreeTF];
    _ThreeTF.placeholder= @"请输入1-10000";
    _ThreeTF.font = [UIFont systemFontOfSize:13];
    _EightLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ThreeTF.frame)+2, CGRectGetMaxY(_SixLabel.frame)+10, 50, 30)];
    [self.contentView addSubview:_EightLabel];
    _EightLabel.font =[UIFont systemFontOfSize:18];
    _EightLabel.text = @"次";
    _NieLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_EightLabel.frame)+5, kScreenWidth-30, 35)];
    [self.contentView addSubview:_NieLabel];
    _NieLabel.numberOfLines = 0;
    _NieLabel.font =[UIFont systemFontOfSize:16];
    _NieLabel.textColor = [UIColor lightGrayColor];
    _NieLabel.text =@"(设置该活动每人最多分享多少，不填或为0 则没有限制)";
    _NieLabel.adjustsFontSizeToFitWidth = YES;
    
    _PPersonLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_NieLabel.frame)+10, 80, 30)];
    [self.contentView addSubview:_PPersonLabel];
    _PPersonLabel.font = [UIFont systemFontOfSize:18];
    _PPersonLabel.text =@"课程简介";
    _FFirstLineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _FFirstLineButton.frame = CGRectMake(15, CGRectGetMaxY(_PPersonLabel.frame)+10, kScreenWidth-30, 120);
    _FFirstLineButton.layer.borderWidth = 1;
    _FFirstLineButton.layer.borderColor = kAppLineColor.CGColor;
    _FFirstTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 6, kScreenWidth-40, 120)];
    _FFirstTextView.backgroundColor = kAppWhiteColor;
    [_FFirstLineButton addSubview:_FFirstTextView];
    _FFirstName = [[UILabel alloc]initWithFrame:CGRectMake(6, 7, 150, 30)];
    [_FFirstLineButton addSubview:_FFirstName];
    _FFirstName.text = @"请输入课程简介...";
    _FFirstName.font = [UIFont systemFontOfSize:15];
    _FFirstName.textColor = kAppGrayColor;
    [self.contentView addSubview:_FFirstLineButton];

    _personLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_FFirstLineButton.frame)+10, 80, 30)];
    [self.contentView addSubview:_personLabel];
    _personLabel.font = [UIFont systemFontOfSize:18];
    _personLabel.text =@"适用人群";
    _firstLineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _firstLineButton.frame = CGRectMake(15, CGRectGetMaxY(_personLabel.frame)+10, kScreenWidth-30, 110);
    _firstLineButton.layer.borderWidth = 1;
    _firstLineButton.layer.borderColor = kAppLineColor.CGColor;
    _firstTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 6, kScreenWidth-40, 110)];
    _firstTextView.backgroundColor = kAppWhiteColor;
    [_firstLineButton addSubview:_firstTextView];
    _firstName = [[UILabel alloc]initWithFrame:CGRectMake(6, 7, 150, 30)];
    [_firstLineButton addSubview:_firstName];
    _firstName.text = @"请输入适用人群...";
    _firstName.font = [UIFont systemFontOfSize:15];
    _firstName.textColor = kAppGrayColor;
    [self.contentView addSubview:_firstLineButton];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_firstTextView resignFirstResponder];
    [_firstTF resignFirstResponder];
    [_FirstTF resignFirstResponder];
    [_SecondTF resignFirstResponder];
    [_ThreeTF resignFirstResponder];
}
@end

