//
//  GroupMembersVC.h
//  ShangKOrganization
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupMembersVC : UIViewController
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView    *tableView;
@property(nonatomic,copy) NSString *NavTitle;
@property(nonatomic,copy) NSString *GroupId;

@end
