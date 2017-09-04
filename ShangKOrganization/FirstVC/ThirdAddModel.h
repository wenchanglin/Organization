//
//  ThirdAddModel.h
//  ShangKOrganization
//
//  Created by apple on 16/11/3.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdAddModel : NSObject
@property(nonatomic,copy) NSString *ThirdAddId;
@property(nonatomic,copy) NSString *ThirdAddName;
@property(nonatomic,copy) NSString *ThirdAddPrice;
@property(nonatomic,copy) NSString *ThirdAddPhotoList;
@property (nonatomic,assign)NSInteger ThirdAddBuyCount;

-(void)setDic:(NSDictionary *)dic;
@end
