//
//  FourModel.h
//  ShangKOrganization
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FourModel : NSObject
@property(nonatomic,copy) NSString *FourId;
@property(nonatomic,copy) NSString *FourName;
@property(nonatomic,copy) NSString *FourPrice;
@property(nonatomic,copy) NSString *FourPhotoList;
@property (nonatomic,assign)NSInteger FourShareCount;
@property (nonatomic,assign)NSInteger FourBuyCount;
@property (nonatomic,assign)NSInteger FourPayStatus;
-(void)setDic:(NSDictionary *)dic;
-(void)setTDic:(NSDictionary *)Dict;
@end
