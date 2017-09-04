//
//  StudentStatisticsCell.h
//  ShangKOrganization
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentPeopleModel.h"
@interface StudentStatisticsCell : UITableViewCell
@property (nonatomic,strong)UIImageView *HeaderPic;
@property (nonatomic,strong)UILabel     *NameLLabel;
@property (nonatomic,strong)UILabel     *BaoMFsLabel;
@property (nonatomic,strong)UILabel     *BaoMTimeLabel;

-(void)configWithMoDel:(StudentPeopleModel *)Model;
@end
