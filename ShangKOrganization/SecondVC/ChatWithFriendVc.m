//
//  ChatWithFriendVc.m
//  ShangKOrganization
//
//  Created by apple on 16/11/7.
//  Copyright © 2016年 Fbw. All rights reserved.
//
#import "ChatWithFriendVc.h"
#import "AppDelegate.h"
#import "FriendUserInfoVC.h"
#import "GroupMembersVC.h"
#import "LocationVCMap.h"
@interface ChatWithFriendVc ()<RCLocationPickerViewControllerDelegate>
{
    UIButton * button2;
}
@end
@implementation ChatWithFriendVc
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    self.view.backgroundColor = kAppWhiteColor;
    [self createNav];
//    RCTextMessage *content = [[RCTextMessage alloc] init];
//    content.content = @"发送的消息";
//    [self sendMessage:content pushContent:nil];
}

//- (void)didSendMessage:(NSInteger)stauts
//               content:(RCMessageContent *)messageCotent {
//    if (stauts == 0) {
//        NSLog(@"发送成功");
//     } else {
//    NSLog(@"发送失败");
//   }
//}
//
//- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
//{
//    if ([@"自己的ID" isEqualToString:userId]) {
//        RCUserInfo *user = [[RCUserInfo alloc]init];
//        user.userId = @"自己的ID";
//        user.name = @"自己的昵称";
//        user.portraitUri = @"自己的头像";
//        return completion(user);
//    } else {
//        RCUserInfo *user = [[RCUserInfo alloc]init];
//        user.userId = @"对方的ID";
//        user.name = @"对方的昵称";
//        user.portraitUri = @"对方的头像";
//        return completion(user);
//    }
//    return completion(nil);
//}

- (void)pluginBoardView:(RCPluginBoardView *)pluginBoardView clickedItemWithTag:(NSInteger)tag{
    switch (tag) {
        case  PLUGIN_BOARD_ITEM_LOCATION_TAG : {
            LocationVCMap *vc = [[LocationVCMap alloc]init];
            vc.delegate = self;
            self.navigationController.navigationBar.barTintColor = kAppBlueColor;
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        default:
            [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
            break;
    }
}

- (void)locationPicker:(RCLocationPickerViewController *)locationPicker
     didSelectLocation:(CLLocationCoordinate2D)location
          locationName:(NSString *)locationName
         mapScreenShot:(UIImage *)mapScreenShot
{
    RCLocationMessage *locationMessage =
    [RCLocationMessage messageWithLocationImage:mapScreenShot
                                       location:location
                                   locationName:locationName];
    [self sendMessage:locationMessage pushContent:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 200)/2, 10, 200, 30)];
    label.text = self.NavTitleStr;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCYlick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    if ([self.QuTitle isEqualToString:@"Dan"]) {
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 30, 30);
    [button2 setBackgroundImage:[UIImage imageNamed:@"我的@3x.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(FriendInfoClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(kScreenWidth - 50, 10, 30, 30);
        [button2 setBackgroundImage:[UIImage imageNamed:@"群组Y-(2)@2x.png"] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(FriendfoClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)FriendfoClick
{
    GroupMembersVC *Meb = [[GroupMembersVC alloc]init];
    Meb.NavTitle = self.NavTitleStr;
    Meb.GroupId  = self.GroupId;
    [self.navigationController pushViewController:Meb animated:YES];
}

-(void)FriendInfoClick:(UIButton *)Inf
{
    FriendUserInfoVC *friendInfo = [[FriendUserInfoVC alloc]init];
    friendInfo.UserInfoId = self.UserInfoId;
    NSLog(@"再进%@",friendInfo.UserInfoId);
    [self.navigationController pushViewController:friendInfo animated:YES];
}

-(void)BaCYlick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
