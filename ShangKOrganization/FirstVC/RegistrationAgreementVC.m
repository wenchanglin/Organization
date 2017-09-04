//
//  RegistrationAgreementVC.m
//  ShangKOrganization
//
//  Created by apple on 2017/1/19.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import "RegistrationAgreementVC.h"

@interface RegistrationAgreementVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableview;

@end

@implementation RegistrationAgreementVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kAppWhiteColor;
    [self createNav];
    [self creattableview];
}

-(void)creattableview
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 2350;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"legalecell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]init];
    }
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"法律声明hhd.png"]];
    icon.frame = CGRectMake(120, 15,  kScreenWidth-240, 55);
    [cell.contentView addSubview:icon];
    UILabel *mylabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, kScreenWidth-20, 2250)];
    mylabel.numberOfLines = 0;
    mylabel.lineBreakMode = NSLineBreakByWordWrapping;
    mylabel.text = @"各注册用户请知悉，自贵方注册用户起，即视为贵方同意并承诺本用户说明书的内容及要求，如果您使用上课呗进行内容的上载、传播或者任何上课呗提示需要注册的服务时，您必须按照上课呗的指引注册账号并获得密码，并确保注册信息的真实性、正确性及完整性。如果上述注册信息发生变化，您应及时更改以通知上课呗。在安全完成本服务的登记程序并收到一个密码及账号后，您应维持密码及账号的机密安全。您应对任何人利用您的密码及账号所进行的活动负完全的责任。因此，请仔细阅读一下用户注册告知说明的内容。\n\n•	当您的密码或账号遭到未获授权的使用，或者发生其他任何安全问题时，您可立即联系上课呗客服寻求帮助。\n\n•	您同意接受上课呗通过电子邮件、客户端、网页或其他合法方式向您发送商品促销或其他相关商业信息。在使用电信增值或其他服务的情况下，您同意接受本公司上课呗及其合作公司通过增值服务系统或其他方式向你发送的相关服务信息或其他信息，其他信息包括但不限于通知信息、宣传信息、广告信息等。\n\n•	您承诺不在注册、使用上课呗账号时从事下列行为：\n\n•	3.1故意冒用他人信息为自己注册上课呗账号；\n\n•	3.2未经他人合法授权以他人名义注册上课呗账号；\n\n•	3.3使用侮辱、诽谤、色情等违反公序良俗的词语注册上课呗账号。\n\n•	凡违反本条款的用户，上课呗可拒绝提供账号注册或取消该账号的使用。\n\n•	3.4上课呗保证，您提供给上课呗的所有注册信息将根据上课呗隐私保护政策予以保密，但根据国家法律强制性要求予以披露的除外。\n\n•	3.5对上传虚假、黄色图片的用户，上课呗保留删除图片、论坛留言、终止该用户的会员资格、追究法律责任的权利。\n\n•	3.6用户账号的冻结。上课呗用户的账号若连续3个月不曾使用，及时没有以Web方式登录上课呗，则该帐号有可能被新的用户注册或者系统自动删除，届时其原有信息将全部丢失。据此建议用户如需更好地使用上课呗的相关服务，在3个月内至少登录一次上课呗。如果一个上课呗账号超过45天不曾用Web方式登录上课呗，则免费邮箱中的信件将有可能被清空，并同时冻结您的上课呗账号（即无法接受新信息），直到下次Web登录被自动激活。\n\n•	第三方链接及国际使用 \n\n•	4.1为方便你使用，上课呗服务可能会提供与第三国际互联网网站或资源进行链接。除非另有声明，上课呗无法对第三方网站服务进行控制，您因使用或依赖上述网站或资源所生的损失或损害，上课呗不负担任何责任。\n\n•	4.2基于上课呗通过中华人民共和国境内的设施提供和控制本网络服务，上课呗无法保证其所提供或控制之服务在其他国家或地区是适当的、可行的，任何在其他司法管辖区使用上课呗服务的用户应自行确保其遵守当地的法律、法规，并且不应当违反中华人民共和国相关法律法规及政策，上课呗对此不承担任何责任。\n\n•	用户隐私制度\n\n•	尊重用户个人隐私是上课呗的一项基本政策。当用户注册上课呗帐号时，应当向上课呗提供个人信息，才能享受上课呗为用户提供尽可能多的个人网上服务并且获取上课呗发送的相关内容以及广告。上课呗在未经合法注册并使用上课呗的用户授权时，承诺不公开、编辑、使用或透漏用户的注册资料及保存在上课呗各项服务中的非公开内容，下列情况除外：\n\n•	5.1遵守有关法律规定，包括在国家有关机关查询时，提供用户在上课呗上发布的信息内容及其发布时间、互联网地址或者域名。\n\n•	5.2遵从上课呗各项服务、产品服务程序，以及上课呗基于商业需要而将用户信息与第三方数据匹配或者向商业合作伙伴提供对用户的统计数据。\n\n•	5.3为维护上课呗的商标及其他所有合法权益。\n\n•	5.4在紧急情况下，维护用户个人和社会大众的隐私安全。\n\n•	5.5根据第7条“用户管理”的规定或者上课呗认为必要的其他情况下，用户在此授权上课呗可以向其电子邮箱发送商业信息。\n\n•	5.6用户购买上课呗上的商品或服务时，上课呗或者直接提供商品或服务的商家将收集用户发送的相关信息，以便于交易的完成，但上课呗对商家的数据整理收集活动不承担任何责任。";
    [cell.contentView addSubview:mylabel];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 90)/2, 10, 90, 30)];
    label.text = @"注册协议";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)BaCklick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
