//
//  CourseOrdersCell.h
//  ShangKOrganization
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseOrdersModel.h"
@interface CourseOrdersCell : UITableViewCell
@property (nonatomic,strong)UIImageView *OrderPic;
@property (nonatomic,strong)UILabel     *OrderTextLabel;
@property (nonatomic,strong)UILabel     *OrderBuyLabel;
@property (nonatomic,strong)UILabel     *OrderTimeLabel;
@property (nonatomic,strong)UILabel     *LineLabel;

-(void)configWithModel:(CourseOrdersModel *)Model;

@end
