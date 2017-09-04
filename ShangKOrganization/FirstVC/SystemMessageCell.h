//
//  SystemMessageCell.h
//  ShangKOrganization
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemMessageModel.h"
@interface SystemMessageCell : UITableViewCell
@property(nonatomic,strong)UIImageView * SystemImgView;
@property(nonatomic,strong)UILabel * SystemTitle;
@property(nonatomic,strong)UILabel * SystemLage;
@property(nonatomic,strong)UILabel * SystemTime;

-(void)configWithModel:(SystemMessageModel *)Model;
@end
