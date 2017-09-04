//
//  LHSJSNeedTop.h
//  YunJiaHui_HuanJianShi
//
//  Created by apple on 16/5/26.
//  Copyright © 2016年 隆科. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHSJSNeedTop : UIView

-(void)addOneAction:(SEL)selection twoAction:(SEL)selection threeAction:(SEL)selection target:(id)target;

-(void)setCurrentPosition:(NSInteger)index;
@end
