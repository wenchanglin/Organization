//
//  EveryAchievementModel.h
//  ShangKOrganization
//
//  Created by apple on 16/10/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EveryAchievementModel : NSObject
@property(nonatomic,copy) NSString *AchievementContent;

-(void)setWithDic:(NSDictionary *)dic;
@end
