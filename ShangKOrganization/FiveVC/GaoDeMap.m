//
//  GaoDeMap.m
//  ShangKOrganization
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "GaoDeMap.h"
#import <MAMapKit/MAMapKit.h>
#import <MAMapKit/MAMapView.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "PlaceAroundTableView.h"
#import "FbwManager.h"
@interface GaoDeMap ()<MAMapViewDelegate,PlaceAroundTableViewDeleagate>
{
//    NSString *AddressStr;
    float     Latitude;
    float     Longitude;
}
@property (nonatomic, strong) MAMapView            *mapView;
@property (nonatomic, strong) AMapSearchAPI        *search;

@property (nonatomic, strong) PlaceAroundTableView *tableview;
@property (nonatomic, strong) UIImageView          *redWaterView;
@property (nonatomic, assign) BOOL                  isMapViewRegionChangedFromTableView;

@property (nonatomic, assign) BOOL                  isLocated;

@property (nonatomic, strong) UIButton             *locationBtn;
@property (nonatomic, strong) UIImage              *imageLocated;
@property (nonatomic, strong) UIImage              *imageNotLocate;

@property (nonatomic, assign) NSInteger             searchPage;

@end
@implementation GaoDeMap
#pragma mark - Utility

/* 根据中心点坐标来搜周边的POI. */
- (void)searchPoiByCenterCoordinate:(CLLocationCoordinate2D )coord
{
    AMapPOIAroundSearchRequest*request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location = [AMapGeoPoint locationWithLatitude:coord.latitude  longitude:coord.longitude];
    request.radius   = 1000;
    request.sortrule = 1;
    request.page     = self.searchPage;
    
    [self.search AMapPOIAroundSearch:request];
}

- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    
    [self.search AMapReGoecodeSearch:regeo];
}

#pragma mark - MapViewDelegate

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (!self.isMapViewRegionChangedFromTableView && self.mapView.userTrackingMode == MAUserTrackingModeNone)
    {
        [self searchReGeocodeWithCoordinate:self.mapView.centerCoordinate];
        [self searchPoiByCenterCoordinate:self.mapView.centerCoordinate];
        
        self.searchPage = 1;
        [self redWaterAnimimate];
    }
    self.isMapViewRegionChangedFromTableView = NO;
}

#pragma mark - TableViewDelegate

- (void)didTableViewSelectedChanged:(AMapPOI *)selectedPoi
{
    // 防止连续点两次
    if(self.isMapViewRegionChangedFromTableView == YES)
    {
        return;
    }
    self.isMapViewRegionChangedFromTableView = YES;
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(selectedPoi.location.latitude, selectedPoi.location.longitude);
    Longitude = location.longitude;
    Latitude  = location.latitude;
    
    [self.mapView setCenterCoordinate:location animated:YES];
}

- (void)didPositionCellTapped
{
    // 防止连续点两次
    if(self.isMapViewRegionChangedFromTableView == YES)
    {
        return;
    }
    self.isMapViewRegionChangedFromTableView = YES;
    
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
}

- (void)didLoadMorePOIButtonTapped
{
    self.searchPage++;
    [self searchPoiByCenterCoordinate:self.mapView.centerCoordinate];
}

#pragma mark - userLocation

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(!updatingLocation)
        return ;
    
    if (userLocation.location.horizontalAccuracy < 0)
    {
        return ;
    }
    // only the first locate used.
    if (!self.isLocated)
    {
        self.isLocated = YES;
    
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude)];
        
        NSLog(@"latitude : %f,longitude: %f",userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
//        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude) animated:YES];
//        //取出当前位置的坐标
//        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

- (void)mapView:(MAMapView *)mapView  didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    if (mode == MAUserTrackingModeNone)
    {
        [self.locationBtn setImage:self.imageNotLocate forState:UIControlStateNormal];
    }
    else
    {
        [self.locationBtn setImage:self.imageLocated forState:UIControlStateNormal];
    }
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    //NSLog(@"error = %@",error);
}

#pragma mark - Handle Action

- (void)actionLocation
{
    if (self.mapView.userTrackingMode == MAUserTrackingModeFollow)
    {
        [self.mapView setUserTrackingMode:MAUserTrackingModeNone animated:YES];
    }
    else
    {
        self.searchPage = 1;
        
        [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
        });
    }
}

#pragma mark - Initialization

- (void)initMapView
{
    [MAMapServices sharedServices].apiKey = @"f3eed77e540a5af4c0c3b89412d61dba";
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), self.view.bounds.size.height/2-64)];
    self.mapView.delegate = self;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.zoomLevel = 17;
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
    
    self.isLocated = NO;
}

- (void)initSearch
{
    self.searchPage = 1;
    //c6375c001facf8ec415c6b087ba4a364
    [AMapServices sharedServices].apiKey = @"f3eed77e540a5af4c0c3b89412d61dba";
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self.tableview;
}

- (void)initTableview
{
    self.tableview = [[PlaceAroundTableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2, CGRectGetWidth(self.view.bounds), self.view.bounds.size.height/2)];
    self.tableview.delegate = self;
    
    [self.view addSubview:self.tableview];
}

- (void)initRedWaterView
{
    UIImage *image = [UIImage imageNamed:@"wateRedBlank@2x.png"];
    self.redWaterView = [[UIImageView alloc] initWithImage:image];
    
    self.redWaterView.frame = CGRectMake(self.view.bounds.size.width/2-image.size.width/2, self.mapView.bounds.size.height/2-image.size.height, image.size.width, image.size.height);
    
    self.redWaterView.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2, CGRectGetHeight(self.mapView.bounds) / 2 - CGRectGetHeight(self.redWaterView.bounds) / 2);
    
    [self.view addSubview:self.redWaterView];
}

- (void)initLocationButton
{
    self.imageLocated = [UIImage imageNamed:@"gpssearchbutton@2x.png"];
    self.imageNotLocate = [UIImage imageNamed:@"gpsnormal@2x.png"];
    
    self.locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.mapView.bounds)*0.8+10, CGRectGetHeight(self.mapView.bounds)*0.8+64, 40, 40)];
    self.locationBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.locationBtn.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    self.locationBtn.layer.cornerRadius = 3;
    [self.locationBtn addTarget:self action:@selector(actionLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.locationBtn setImage:self.imageNotLocate forState:UIControlStateNormal];
    
    [self.view addSubview:self.locationBtn];
}

/* 移动窗口弹一下的动画 */
- (void)redWaterAnimimate
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGPoint center = self.redWaterView.center;
                         center.y -= 20;
                         [self.redWaterView setCenter:center];}
                     completion:nil];
    
    [UIView animateWithDuration:0.45
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGPoint center = self.redWaterView.center;
                         center.y += 20;
                         [self.redWaterView setCenter:center];}
                     completion:nil];
}

-(void)createNav
{
    
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 40)/2, 10, 40, 30)];
    label.text = @"地址";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 40, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button2 setTitle:@"保存" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(AddSaveClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button2];
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
    
}

-(void)BaCklick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)AddSaveClick:(UIButton *)saveBtn
{
    FbwManager *manager = [FbwManager shareManager];
    manager.LocationLatitude  = Latitude;
    manager.LocationLongitude = Longitude;
    manager.WanShanXinYeMian  = 3;
    NSLog(@"-----%f  -----%f",manager.LocationLongitude,manager.LocationLatitude);
    NSLog(@"#%@#",manager.AddressTit);
    NSLog(@"保存");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createNav];
    [self initTableview];
    
    [self initSearch];
    [self initMapView];
    
    [self initRedWaterView];
    
    [self initLocationButton];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

@end
