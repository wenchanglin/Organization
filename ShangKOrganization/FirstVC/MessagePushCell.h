//
//  MessagePushCell.h
//  ShangKOrganization
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessagePushModel.h"
@interface MessagePushCell : UITableViewCell
@property (nonatomic,strong)UILabel     *BiaoTiLabel;
@property (nonatomic,strong)UILabel     *OffersLabel;
@property (nonatomic,strong)UILabel     *TimeLabel;
@property (nonatomic,strong)UIImageView *NextPic;

-(void)configWithModel:(MessagePushModel *)Model;
@end
