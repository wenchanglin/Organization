//
//  OrganizationActivityModel.h
//  ShangKOrganization
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrganizationActivityModel : NSObject
@property(nonatomic,copy) NSString *ActivityId;
@property(nonatomic,copy) NSString *ActivityName;
@property(nonatomic,copy) NSString *ActivityContent;
@property(nonatomic,copy) NSString *ActivityTime;
@property(nonatomic,copy) NSString *ActivityPhoto;
@property(nonatomic,copy) NSString *ActivityShareIncome;
@property(nonatomic,copy) NSString *ActivityMaxCount;
@property(nonatomic,assign) NSInteger ActivityShareCount;
@property (nonatomic,assign)NSInteger ActivityPayStatus;

-(void)setDic:(NSDictionary *)dic;
-(void)setTDic:(NSDictionary *)Dict;
@end
