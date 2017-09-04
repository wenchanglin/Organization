//
//  UITextField+Extension.h
//  ShangKOrganization
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)
/**
 *  是否支持视图上移
 */
@property (nonatomic, assign) BOOL ex_canMove;
/**
 *  点击回收键盘、移动的视图，默认是当前控制器的view
 */
@property (nonatomic, strong) UIView *ex_moveView;
/**
 *  textfield底部距离键盘顶部的距离
 */
@property (nonatomic, assign) CGFloat ex_heightToKeyboard;

@end
