//
//  GroupMembersCell.h
//  ShangKOrganization
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupMembersCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *PicImageView;
@property (nonatomic,strong)  UIImageView *BoyImage;
@property (nonatomic,strong)  UIImageView *GirlImage;
@property (nonatomic,strong)  UIImageView *JiaMImage;
@property (nonatomic,strong)  UILabel     *FirstTitle;
@property (nonatomic,strong)  UILabel     *BoyNumTitle;
@property (nonatomic,strong)  UILabel     *GirlNumTitle;
@property (nonatomic,strong)  UILabel     *JiaMNumTitle;
@property (nonatomic,strong)  UILabel     *SecondTitle;

@end
