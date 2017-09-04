//
//  EveryLessonModel.h
//  ShangKOrganization
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EveryLessonModel : NSObject
@property(nonatomic,copy) NSString *LessonBriefIntro;
@property(nonatomic,copy) NSString *LessonfitPeople;

-(void)setDic:(NSDictionary *)dic;
@end
