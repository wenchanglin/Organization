//
//  QunManagerModel.h
//  ShangKOrganization
//
//  Created by apple on 17/1/9.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QunManagerModel : NSObject
@property(nonatomic,copy)   NSString *QunManagerNickName;
@property(nonatomic,copy)   NSString *QunManagerId;
@property(nonatomic,copy)   NSString *QunManagerUserPhotoHead;
@property(nonatomic,assign) NSInteger QunManagerCourseCount;
@property(nonatomic,assign) NSInteger QunManagerSex;
@property (nonatomic,strong)NSDictionary *QunManagerDict;
-(void)setDic:(NSDictionary *)dic;
@end
