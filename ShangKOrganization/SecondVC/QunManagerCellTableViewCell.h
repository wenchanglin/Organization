//
//  QunManagerCellTableViewCell.h
//  ShangKOrganization
//
//  Created by apple on 17/1/9.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QunManagerModel.h"
@interface QunManagerCellTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *QunImagePic;
@property (nonatomic,strong)UILabel     *QunTitLabel;

-(void)configWithModel:(QunManagerModel *)Model;
@end
