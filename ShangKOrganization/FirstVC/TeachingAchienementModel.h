//
//  TeachingAchienementModel.h
//  ShangKOrganization
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeachingAchienementModel : NSObject
@property(nonatomic,copy) NSString *AchienementName;
@property(nonatomic,copy) NSString *AchienementId;
@property(nonatomic,copy) NSString *AchienementHeadPhoto;
@property (nonatomic,strong)NSArray *ModelArray;
@property (nonatomic,assign)float   ImageHeight;

-(void)setWithDic:(NSDictionary *)dic;
@end
