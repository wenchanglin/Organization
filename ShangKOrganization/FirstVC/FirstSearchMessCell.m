//
//  FirstSearchMessCell.m
//  ShangKOrganization
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FirstSearchMessCell.h"
@implementation FirstSearchMessCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _SearchFirLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-140)/2, 5, 140, 15)];
    _SearchFirLabel.textColor = kAppBlueColor;
    _SearchFirLabel.textAlignment = NSTextAlignmentCenter;
    
    _SearchFirLabel.font = [UIFont boldSystemFontOfSize:15];
    
//    [self.contentView addSubview:_SearchFirLabel];
}
@end
