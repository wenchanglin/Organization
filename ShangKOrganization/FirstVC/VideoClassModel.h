//
//  VideoClassModel.h
//  ShangKOrganization
//
//  Created by apple on 16/10/22.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoClassModel : NSObject
@property(nonatomic,copy) NSString    *VideoName;
@property(nonatomic,copy) NSString    *Videoprice;
@property(nonatomic,assign) double     VideoAvgScore;
@property(nonatomic,copy) NSString    *VideoSellCount;
@property(nonatomic,copy) NSString    *VideoPhotoUrl;
@property(nonatomic,copy) NSString    *VideoId;

-(void)setDic:(NSDictionary *)dic;
@end
