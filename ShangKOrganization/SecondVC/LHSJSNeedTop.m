//
//  LHSJSNeedTop.m
//  YunJiaHui_HuanJianShi
//
//  Created by apple on 16/5/26.
//  Copyright © 2016年 隆科. All rights reserved.
//

#import "LHSJSNeedTop.h"
#define theme_color [UIColor colorWithRed:243.0/255 green:128.0/225 blue:0 alpha:1] //颜色
@interface LHSJSNeedTop(){
    NSArray *_btns;
}
@property(assign, nonatomic)NSInteger currentIndex;
@property (weak, nonatomic) IBOutlet UIButton *btnQun;
@property (weak, nonatomic) IBOutlet UIButton *btnFriend;
@property (weak, nonatomic) IBOutlet UIButton *btnChat;

@end
@implementation LHSJSNeedTop
-(void)addOneAction:(SEL)selection1 twoAction:(SEL)selection2 threeAction:(SEL)selection3 target:(id)target{
    
    
    [self.btnQun addTarget:target action:selection1 forControlEvents:UIControlEventTouchUpInside];
    [self.btnFriend addTarget:target action:selection2 forControlEvents:UIControlEventTouchUpInside];
    [self.btnChat addTarget:target action:selection3 forControlEvents:UIControlEventTouchUpInside];
}

-(void)setCurrentPosition:(NSInteger)index{
    
    
    for(int i=0;i<3;i++){
        
        [_btns[i] setTitleColor:kAppBlackColor forState:UIControlStateNormal];
    }
    [_btns[index] setTitleColor:kAppBlueColor forState:UIControlStateNormal];
}
-(void)awakeFromNib{
    
    _btns = @[self.btnQun, self.btnFriend,self.btnChat];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
