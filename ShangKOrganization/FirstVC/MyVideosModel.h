//
//  MyVideosModel.h
//  ShangKOrganization
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyVideosModel : NSObject
@property(nonatomic,copy) NSString *MyVideosName;
@property(nonatomic,copy) NSString *MyVideosCreateime;
@property(nonatomic,copy) NSString *MyVideosPhotoUrl;
@property(nonatomic,copy) NSString *MyVideosPrice;
@property(nonatomic,copy) NSString *MyVideosId;
@property(nonatomic,copy) NSString *MyVideosFkVideoUserId;
@property(nonatomic,copy) NSString *MyVideosSellCount;

-(void)setDic:(NSDictionary *)dic;
@end
