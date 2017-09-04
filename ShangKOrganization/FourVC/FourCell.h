//
//  FourCell.h
//  ShangKOrganization
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FourModel.h"

@interface FourCell : UITableViewCell
@property (nonatomic,strong)UIImageView *FourPic;
@property (nonatomic,strong)UILabel     *FourTextLabel;
@property (nonatomic,strong)UILabel     *FourPayStatusLabel;
@property (nonatomic,strong)UILabel     *FourBuyLabel;
@property (nonatomic,strong)UILabel     *FourTimeLabel;
@property (nonatomic,strong)UILabel     *FourLineLabel;
@property (nonatomic,strong)UILabel     *FourPriceLabel;

-(void)configWithModel:(FourModel *)Model;
@end
