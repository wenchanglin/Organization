//
//  ObjectRewardModel.h
//  ShangKOrganization
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectRewardModel : NSObject
@property(nonatomic,copy) NSString *ObjectRewardContactName;
@property(nonatomic,copy) NSString *ObjectRewardSumPrice;
@property(nonatomic,copy) NSString *ObjectRewardGuideDetail;//推荐奖励
@property(nonatomic,copy) NSString *ObjectRewardNickName;
@property(nonatomic,copy) NSString *ObjectRewardCreateTime;
@property(nonatomic,copy) NSString *ObjectRewardBuyNickName;
@property(nonatomic,copy) NSString *ObjectRewardBuyCreateTime;
@property(nonatomic,copy) NSString *ObjectRewardCourseName;

-(void)setDic:(NSDictionary *)dic;
-(void)serDict:(NSDictionary *)dict;
-(void)setBuyDic:(NSDictionary *)dic;
-(void)setBuyCourseDic:(NSDictionary *)CourseDic;
@end
