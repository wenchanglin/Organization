//
//  PlaceAroundTableView.h
//  ShangKOrganization
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapView.h>
#import <AMapSearchKit/AMapSearchKit.h>

@protocol PlaceAroundTableViewDeleagate <NSObject>

- (void)didTableViewSelectedChanged:(AMapPOI *)selectedPoi;

- (void)didLoadMorePOIButtonTapped;

- (void)didPositionCellTapped;

@end




@interface PlaceAroundTableView : UIView <UITableViewDataSource, UITableViewDelegate, AMapSearchDelegate>

@property (nonatomic, weak) id<PlaceAroundTableViewDeleagate> delegate;

@property (nonatomic, strong) NSString *currentRedWaterPosition;

- (instancetype)initWithFrame:(CGRect)frame;

- (AMapPOI *)selectedTableViewCellPoi;

@end
