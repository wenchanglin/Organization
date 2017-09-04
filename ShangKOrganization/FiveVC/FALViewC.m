//
//  FALViewC.m
//  ShangKOrganization
//
//  Created by apple on 16/11/25.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FALViewC.h"
@interface FALViewC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableview;

@end
@implementation FALViewC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self creattableview];
//    [self createUI];
    self.view.backgroundColor = kAppWhiteColor;
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
    return 1450;
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
    UILabel *mylabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, kScreenWidth-20, 1200)];
    mylabel.numberOfLines = 0;
    mylabel.lineBreakMode = NSLineBreakByWordWrapping;
    mylabel.text = @"1.一切移动客户端用户在下载并浏览上课呗APP软件时均被视为已经仔细阅读本条款并完全同意。凡以任何方式登陆本APP，或直接、间接使用本APP资料者，均被视为自愿接受本网站相关声明和用户服务协议的约束。\n\n2、网络服务条款与中华人民共和国的法律解释相一致，用户和上课呗一致同意服从高等法院所管辖。如有条款与中华人民共和国法律相抵触时，则以法律规定为准重新解释，而其他条款则依旧保持对用户产生法律效力和影响。\n\n3、用户对自己的言论或行为负责，用户不得在上课呗进行任何违反或可能违反国家法律和法规的言论或行为，否则，上课呗有权不经任何事先通知立即终止向您提供服务。\n\n4、上课呗APP转载的内容并不代表上课呗之意见及观点，也不意味着上课呗赞同其观点或证实其内容的真实性。\n\n5、上课呗APP转载的文字、图片、音视频等资料均由本APP用户提供，其真实性、准确性和合法性由信息发布人负责。上课呗不提供任何保证，并不承担任何法律责任。\n\n6、上课呗APP所转载的文字、图片、音视频等资料，如果侵犯了第三方的知识产权或其他权利，责任由作者或转载者本人承担，本APP对此不承担责任。\n\n7、上课呗APP不保证为向用户提供便利而设置的外部链接的准确性和完整性，同时，对于该外部链接指向的不由APP实际控制的任何网页上的内容，APP不承担任何责任。\n\n8、用户明确并同意其使用APP网络服务所存在的风险将完全由其本人承担；因其使用上课呗APP网络服务而产生的一切后果也由其本人承担，上课呗对此不承担任何责任。\n\n9、除APP注明之服务条款外，其它因不当使用本APP而导致的任何意外、疏忽、合约毁坏、诽谤、版权或其他知识产权侵犯及其所造成的任何损失，上课呗概不负责，亦不承担任何法律责任。\n\n10、对于因不可抗力或因黑客攻击、通讯线路中断等APP不能控制的原因造成的网络服务中断或其他缺陷，导致用户不能正常使用APP，上课呗不承担任何责任，但将尽力减少因此给用户造成的损失或影响。\n\n11、本声明未涉及的问题请参见国家有关法律法规，当本声明与国家有关法律法规冲突时，以国家法律法规为准。\n\n12、本网站相关声明版权及其修改权、更新权和最终解释权均属上课呗教育平台所有";
    [cell.contentView addSubview:mylabel];
    //    UILabel *labelone = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, Width-20, 80)];
    //    labelone.adjustsFontSizeToFitWidth = YES;
    //    labelone.numberOfLines = 0;
    //    labelone.lineBreakMode = NSLineBreakByWordWrapping;
    //    labelone.text = @"1.一切移动客户端用户在下载并浏览上课呗APP软件时均被视为已经仔细阅读本条款并完全同意。凡以任何方式登陆本APP，或直接、间接使用本APP资料者，均被视为自愿接受本网站相关声明和用户服务协议的约束。";
    //    labelone.font = [UIFont systemFontOfSize:14];
    //    [cell.contentView addSubview:labelone];
    //    UILabel *labelone2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, Width-20, 60)];
    //    labelone2.adjustsFontSizeToFitWidth = YES;
    //    labelone2.numberOfLines = 0;
    //    labelone2.lineBreakMode = NSLineBreakByWordWrapping;
    //    labelone2.text = @"2、网络服务条款与中华人民共和国的法律解释相一致，用户和上课呗一致同意服从高等法院所管辖。如有条款与中华人民共和国法律相抵触时，则以法律规定为准重新解释，而其他条款则依旧保持对用户产生法律效力和影响。";
    //    labelone2.font = [UIFont systemFontOfSize:14];
    //    [cell.contentView addSubview:labelone2];
    //    UILabel *labelone3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 210, Width-20, 80)];
    //    labelone3.adjustsFontSizeToFitWidth = YES;
    //    labelone3.numberOfLines = 0;
    //    labelone3.lineBreakMode = NSLineBreakByWordWrapping;
    //    labelone3.text = @"3、用户对自己的言论或行为负责，用户不得在上课呗进行任何违反或可能违反国家法律和法规的言论或行为，否则，上课呗有权不经任何事先通知立即终止向您提供服务。";
    //    labelone3.font = [UIFont systemFontOfSize:14];
    //    [cell.contentView addSubview:labelone3];
    //    UILabel *labelone4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 280, Width-20, 80)];
    //    labelone4.adjustsFontSizeToFitWidth = YES;
    //    labelone4.numberOfLines = 0;
    //    labelone4.lineBreakMode = NSLineBreakByWordWrapping;
    //    labelone4.text = @"4、上课呗APP转载的内容并不代表上课呗之意见及观点，也不意味着上课呗赞同其观点或证实其内容的真实性。";
    //    labelone4.font = [UIFont systemFontOfSize:14];
    //    [cell.contentView addSubview:labelone4];
    //    UILabel *labelone5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 350, Width-20, 60)];
    //    labelone5.adjustsFontSizeToFitWidth = YES;
    //    labelone5.numberOfLines = 0;
    //    labelone5.lineBreakMode = NSLineBreakByWordWrapping;
    //    labelone5.text = @"5、上课呗APP转载的文字、图片、音视频等资料均由本APP用户提供，其真实性、准确性和合法性由信息发布人负责。上课呗不提供任何保证，并不承担任何法律责任。";
    //    labelone5.font = [UIFont systemFontOfSize:14];
    //    [cell.contentView addSubview:labelone5];
    //    UILabel *labelone6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 400, Width-20, 80)];
    //    labelone6.adjustsFontSizeToFitWidth = YES;
    //    labelone6.numberOfLines = 0;
    //    labelone6.lineBreakMode = NSLineBreakByWordWrapping;
    //    labelone6.text = @"6、上课呗APP所转载的文字、图片、音视频等资料，如果侵犯了第三方的知识产权或其他权利，责任由作者或转载者本人承担，本APP对此不承担责任。";
    //    labelone6.font = [UIFont systemFontOfSize:14];
    //    [cell.contentView addSubview:labelone6];
    //    UILabel *labelone7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 480, Width-20, 80)];
    //    labelone7.adjustsFontSizeToFitWidth = YES;
    //    labelone7.numberOfLines = 0;
    //    labelone7.lineBreakMode = NSLineBreakByWordWrapping;
    //    labelone7.text = @"7、上课呗APP不保证为向用户提供便利而设置的外部链接的准确性和完整性，同时，对于该外部链接指向的不由APP实际控制的任何网页上的内容，APP不承担任何责任。";
    //    labelone7.font = [UIFont systemFontOfSize:14];
    //    [cell.contentView addSubview:labelone7];
    //    UILabel *labelone8 = [[UILabel alloc]initWithFrame:CGRectMake(10, 560, Width-20, 80)];
    //    labelone8.adjustsFontSizeToFitWidth = YES;
    //    labelone8.numberOfLines = 0;
    //    labelone8.lineBreakMode = NSLineBreakByWordWrapping;
    //    labelone8.text = @"8、用户明确并同意其使用APP网络服务所存在的风险将完全由其本人承担；因其使用上课呗APP网络服务而产生的一切后果也由其本人承担，上课呗对此不承担任何责任。";
    //    labelone8.font = [UIFont systemFontOfSize:14];
    //    [cell.contentView addSubview:labelone8];
    //        UILabel *labelone9 = [[UILabel alloc]initWithFrame:CGRectMake(10, 640, Width-20, 80)];
    //        labelone9.adjustsFontSizeToFitWidth = YES;
    //        labelone9.numberOfLines = 0;
    //        labelone9.lineBreakMode = NSLineBreakByWordWrapping;
    //    labelone9.text = @"9、除APP注明之服务条款外，其它因不当使用本APP而导致的任何意外、疏忽、合约毁坏、诽谤、版权或其他知识产权侵犯及其所造成的任何损失，上课呗概不负责，亦不承担任何法律责任。";
    //        labelone9.font = [UIFont systemFontOfSize:14];
    //        [cell.contentView addSubview:labelone9];
    //        UILabel *labelone10 = [[UILabel alloc]initWithFrame:CGRectMake(10, 720, Width-20, 80)];
    //        labelone10.adjustsFontSizeToFitWidth = YES;
    //        labelone10.numberOfLines = 0;
    //        labelone10.lineBreakMode = NSLineBreakByWordWrapping;
    //    labelone10.text = @"10、对于因不可抗力或因黑客攻击、通讯线路中断等APP不能控制的原因造成的网络服务中断或其他缺陷，导致用户不能正常使用APP，上课呗不承担任何责任，但将尽力减少因此给用户造成的损失或影响。";
    //        labelone10.font = [UIFont systemFontOfSize:14];
    //        [cell.contentView addSubview:labelone10];
    //    UILabel *labelone11 = [[UILabel alloc]initWithFrame:CGRectMake(10, 800, Width-20, 60)];
    //    labelone11.adjustsFontSizeToFitWidth = YES;
    //    labelone11.numberOfLines = 0;
    //    labelone11.lineBreakMode = NSLineBreakByWordWrapping;
    //    labelone11.text = @"11、本声明未涉及的问题请参见国家有关法律法规，当本声明与国家有关法律法规冲突时，以国家法律法规为准。   ";
    //    labelone11.font = [UIFont systemFontOfSize:14];
    //    [cell.contentView addSubview:labelone11];
    //    UILabel *labelone12 = [[UILabel alloc]initWithFrame:CGRectMake(10, 850, Width-20, 80)];
    //    labelone12.adjustsFontSizeToFitWidth = YES;
    //    labelone12.numberOfLines = 0;
    //    labelone12.lineBreakMode = NSLineBreakByWordWrapping;
    //    labelone12.text = @"12、本网站相关声明版权及其修改权、更新权和最终解释权均属上课呗教育平台所有";
    //    labelone12.font = [UIFont systemFontOfSize:14];
    //    [cell.contentView addSubview:labelone12];
    UILabel *label1n = [[UILabel alloc]init];
    UILabel *label2m = [[UILabel alloc]init];
    //    label1.text = @"Copyright 2016";
    label2m.text = @"上海盟课网络科技有限公司";
    //    label1.textColor = [UIColor lightGrayColor];
    label2m.textColor = [UIColor lightGrayColor];
    label1n.backgroundColor = [UIColor lightGrayColor];
    //    label1.textColor = []
    label2m.frame = CGRectMake(40, 1400, kScreenWidth-80, 30);
    label1n.frame = CGRectMake(40, 1390, kScreenWidth-80, 2);
    //    label1.font = [UIFont systemFontOfSize:14];
    //    label2.font = [UIFont systemFontOfSize:14];
    //    label1.textAlignment = NSTextAlignmentCenter;
    label2m.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:label1n];
    [cell.contentView addSubview:label2m];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 90)/2, 10, 90, 30)];
    label.text = @"法律声明";
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

@end