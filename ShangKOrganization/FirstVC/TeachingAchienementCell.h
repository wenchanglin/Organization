//
//  TeachingAchienementCell.h
//  ShangKOrganization
//
//  Created by apple on 16/9/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeachingAchienementModel.h"

@interface TeachingAchienementCell : UITableViewCell
@property (nonatomic,strong)UILabel     *titleLabel;
@property (nonatomic,strong)UIView      *BacView;
@property (nonatomic,strong)UIImageView *ImageView;
//@property (nonatomic,assign)CGFloat      ImageViewHeight;

-(void)configWithModel:(TeachingAchienementModel *)model;
@end
