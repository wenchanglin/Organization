//
//  FbwManager.m
//  ShangKOrganization
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FbwManager.h"

@implementation FbwManager

+(instancetype)shareManager
{
    static FbwManager *manager= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FbwManager alloc]init];
    });
    return manager;
}

@end
