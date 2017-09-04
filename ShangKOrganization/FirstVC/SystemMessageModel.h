//
//  SystemMessageModel.h
//  ShangKOrganization
//
//  Created by apple on 16/11/3.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemMessageModel : NSObject
@property(nonatomic,copy) NSString *SystemContent;
@property(nonatomic,copy) NSString *SystemTime;

-(void)setDic:(NSDictionary *)dic;
@end
