//
//  EveryLessonModel.m
//  ShangKOrganization
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EveryLessonModel.h"

@implementation EveryLessonModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"briefIntro"]) {
        [self setLessonBriefIntro:[dic objectForKey:@"briefIntro"]];
    }
    if ([dic objectForKey:@"fitPeople"]) {
        [self setLessonfitPeople:[dic objectForKey:@"fitPeople"]];
    }
}
@end
