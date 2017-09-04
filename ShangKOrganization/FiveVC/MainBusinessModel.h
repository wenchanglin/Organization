//
//  MainBusinessModel.h
//  ShangKOrganization
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainBusinessModel : NSObject
@property(nonatomic,copy) NSString *BusinessName;
@property(nonatomic,copy) NSString *BusinessId;
@property (nonatomic,assign)NSInteger BusinessIsHad;

-(void)setWithDic:(NSDictionary *)Dict;
@end
