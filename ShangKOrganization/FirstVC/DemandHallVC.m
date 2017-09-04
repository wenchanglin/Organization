//
//  DemandHallVC.m
//  ShangKOrganization
//
//  Created by apple on 16/9/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "DemandHallVC.h"
#import "VipALiPayVC.h"
#import "AppDelegate.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>
//tianbai对象调用的JavaScript方法，必须声明！！！
- (void)call;
- (void)getCall:(NSString *)callString;
@end

@interface DemandHallVC ()<UIWebViewDelegate,JSObjcDelegate>
@property (nonatomic, strong) JSContext *jsContext;
@property (strong, nonatomic)  UIWebView *webView;
@end

@implementation DemandHallVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"post" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(post) name:@"post" object:nil];
    self.fd_interactivePopDisabled = YES;
//    [self createNav];
    [self createUI];
    self.view.backgroundColor = kAppWhiteColor;
    
}

-(void)createUI
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+44)];
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    webView.scrollView.bounces = NO;
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"community" ofType:@"html" inDirectory:@"www 2/needhall"]]]];
    [self.view addSubview:webView];
}

-(void)Return
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    __weak typeof(self) weakSelf = self;
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"tianbai"] = self;
    _jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    _jsContext[@"show"] = ^(NSDictionary *param) {
        VipALiPayVC *pay = [[VipALiPayVC alloc]init];
        [weakSelf.navigationController pushViewController:pay animated:YES];
    };
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlstr = request.URL.absoluteString;
    
    NSRange range = [urlstr
                     rangeOfString:@"ios://"];
    
    if(range.length!=0)
    {
        
        NSString *method = [urlstr substringFromIndex:(range.location+range.length)];
        SEL selctor = NSSelectorFromString(method);
        [self performSelector:selctor withObject:nil];
        //        NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        //        SEL selectortwo = NSSelectorFromString(userid);
        //        [self performSelector:selectortwo withObject:nil];
    }
    
    NSString *requestStr = [[request.URL absoluteString] stringByRemovingPercentEncoding];
    
    //在url中寻找自定义协议头"objc://"
    if ([requestStr hasPrefix:@"objc://"]) {
        
        // 以"://"为中心将url分割成两部分，放进数组arr
        NSArray *arr = [requestStr componentsSeparatedByString:@"://"];
        NSLog(@"%@",arr);
        
        //取其后半段
        NSString *paramStr = arr[1];
        NSLog(@"%@",paramStr);
        
        //以":/"为标识将后半段url分割成若干部分，放进数组arr2，此时arr2[0]为空，arr2[1]为第一个传参值，arr2[2]为第二个传参值，以此类推
        NSArray *arr2 = [paramStr componentsSeparatedByString:@":/"];
        NSLog(@"%@",arr2);
        
        //取出参数，进行使用
        if (arr2.count) {
            NSLog(@"有参数");
            [self doSomeThingWithParamA:arr2[1] andParamB:arr2[2]];
        }else{
            NSLog(@"无参数");
        }
        return NO;
    }
    return YES;
    
}

//对JS传来的值进行调用
- (void)doSomeThingWithParamA:(id)paramA andParamB:(id)paramB{
    
    VipALiPayVC *pay = [[VipALiPayVC alloc]init];
//    pay.orderid = (NSString*)paramA;
    [self.navigationController pushViewController:pay animated:YES];
    NSLog(@"%@    %@", paramA, paramB);
}

-(void)Push
{
    VipALiPayVC *pay = [[VipALiPayVC alloc]init];
    [self.navigationController pushViewController:pay animated:YES];
}
- (void)post
{
    //使用alert注意此处最好延迟执行,否则可能程序卡死,未测试非延迟情况下传值问题,延迟执行成功
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [self.webView stringByEvaluatingJavaScriptFromString:@"alert('hello')"];
        FbwManager *Manager = [FbwManager shareManager];
        [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"post('%@');",Manager.UUserId]];
    });
    
}

- (void)call{
    NSLog(@"call");
    FbwManager *Manager = [FbwManager shareManager];
    // 之后在回调js的方法Callback把内容传出去
    JSValue *Callback = self.jsContext[@"Callback"];
//    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    //传值给web端
    [Callback callWithArguments:@[Manager.UUserId]];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 45)/2, 10, 70, 30)];
    label.text = @"需求大厅";
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

-(void)BaCklick:(UIButton *)Tb1
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
