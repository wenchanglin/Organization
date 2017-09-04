//
//  ScanViewController.m
//  Parents1
//
//  Created by Mac on 16/9/22.
//  Copyright © 2016年 luli. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SuccessErWeiMVC.h"
@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    NSInteger _page;
}
@property (nonatomic,strong)  AVCaptureSession *session;
@property (nonatomic,strong) UIView *boxview;
@property (nonatomic,strong) CALayer *scanLayer;


@end

@implementation ScanViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    output.rectOfInterest = CGRectMake(0.2, 0.3, 0.6, 0.4);
    //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];

    [_session addInput:input];
    [_session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame= self.view.frame;
    [self.view.layer insertSublayer:layer atIndex:0];
//    _boxview = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.2f, self.view.bounds.size.height * 0.2f, self.view.bounds.size.width - self.view.size.width * 0.4f, self.view.bounds.size.height - self.view.bounds.size.height * 0.4f)];
    _boxview = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth *0.2, kScreenHeight*0.3, kScreenWidth*0.6, kScreenHeight *0.4)];
    _boxview.layer.borderColor = [UIColor whiteColor].CGColor;
    _boxview.layer.borderWidth = 0.5f;
    [self.view addSubview:_boxview];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"请扫描课程二维码,验证课程信息";
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = [UIColor whiteColor];
    label.frame = CGRectMake(kScreenWidth*0.2, kScreenHeight*0.7, kScreenWidth *0.6, 20);
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    //10.2.扫描线
    _scanLayer = [[CALayer alloc] init];
    _scanLayer.frame = CGRectMake(0, 0, _boxview.bounds.size.width, 1);
    _scanLayer.backgroundColor = [UIColor brownColor].CGColor;
    [_boxview.layer addSublayer:_scanLayer];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    [timer fire];

    //开始捕获
    [_session startRunning];
}
- (void)moveScanLayer:(NSTimer *)timer
{
    CGRect frame = _scanLayer.frame;
    if (_boxview.frame.size.height < _scanLayer.frame.origin.y) {
        frame.origin.y = 0;
        _scanLayer.frame = frame;
    }else{
        frame.origin.y += 5;
        [UIView animateWithDuration:0.1 animations:^{
            _scanLayer.frame = frame;
        }];
    }
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (_page == 3) {
        _page = 0;
        NSLog(@"这是不进去了");
    }else{
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        NSLog(@"%@",object.stringValue);
        NSDictionary *Dict = [ScanViewController dictionaryWithJsonString:object.stringValue];
        if (Dict == nil || [Dict isKindOfClass:[NSNull class]]) {
            [SVProgressHUD showErrorWithStatus:@"请扫描正确的课程二维码"];
        }else{
            
                [self.session stopRunning];
//                NSLog(@"这是进去了");
        NSString * CourseId = [Dict objectForKey:@"id"];
        __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":CourseId} url:UrL_CourseStart success:^(id responseObject) {
                    if ([[responseObject objectForKey:@"errcode"]integerValue] != 0) {
                        [SVProgressHUD showErrorWithStatus:@"请扫描正确的课程二维码"];
                    }else{
                        
                        
                            SuccessErWeiMVC *Success = [[SuccessErWeiMVC alloc]init];
                            _page = 3;
                            [weakSelf.navigationController pushViewController:Success animated:YES];
                        
                    }
                } failure:^(NSError *error) {
                }];
             });
            
       }
    } else {
        NSLog(@"没有扫描到数据");
    }
        }
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 20, 70, 30)];
    label.text = @"查看原因";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 20, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BFFlick) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
}

-(void)BFFlick
{
    FbwManager *Manager = [FbwManager shareManager];
    Manager.PullPage = 3;
    [self.navigationController popViewControllerAnimated:YES];
}
@end
