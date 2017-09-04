//
//  EventDetailsModel.h
//  ShangKOrganization
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventDetailsModel : NSObject
@property(nonatomic,copy) NSString *DetailsId;
@property(nonatomic,copy) NSString *DetailsName;
@property(nonatomic,copy) NSString *DetailsPrice;
@property(nonatomic,copy) NSString *DetailsPhotoList;
@property(nonatomic,copy) NSString *DetailsScore;
@property (nonatomic,assign)NSInteger DetailsBuyCount;
-(void)setDic:(NSDictionary *)dic;
@end
