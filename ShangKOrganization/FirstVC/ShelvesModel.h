//
//  ShelvesModel.h
//  ShangKOrganization
//
//  Created by apple on 16/11/2.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ShelvesModel : NSObject
@property(nonatomic,copy) NSString *ShelvesId;
@property(nonatomic,copy) NSString *ShelvesName;
@property(nonatomic,copy) NSString *ShelvesPrice;
@property(nonatomic,copy) NSString *ShelvesPhotoList;
@property (nonatomic,assign)NSInteger ShelvesBuyCount;
@property (nonatomic,assign)NSInteger ShelvesShareCount;
@property (nonatomic,assign)BOOL IsChoose;

-(void)setDic:(NSDictionary *)dic;
-(void)setTDic:(NSDictionary *)Dict;
@end
