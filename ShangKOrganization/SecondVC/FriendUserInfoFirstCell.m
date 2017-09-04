//
//  FriendUserInfoFirstCell.m
//  ShangKOrganization
//
//  Created by apple on 16/11/7.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FriendUserInfoFirstCell.h"

@implementation FriendUserInfoFirstCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _FirstCellNAem = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 80, 20)];
    _FirstCellNAem.text = @"头像";
    _ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-100, 10, 70, 70)];
//    _ImageView.image = [UIImage imageNamed:@"哭脸.png"];
    _ImageView.layer.cornerRadius = 35;
    _ImageView.layer.masksToBounds = YES;
    
    [self.contentView addSubview:_FirstCellNAem];
//    [self.contentView addSubview:_ImageView];
}
@end
