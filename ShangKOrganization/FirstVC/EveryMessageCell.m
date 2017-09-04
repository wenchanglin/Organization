//
//  EveryMessageCell.m
//  ShangKOrganization
//
//  Created by apple on 16/12/5.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EveryMessageCell.h"

@implementation EveryMessageCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _TitleLAbel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth, 20)];;
    _ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+50)];
    _SecondImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+50)];
    _ThreeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+50)];
}
@end
