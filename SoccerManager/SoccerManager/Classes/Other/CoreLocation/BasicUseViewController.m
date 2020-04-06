//
//  BasicUseViewController.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/2/27.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//
#import "Util.h"
#import "BasicUseViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface BasicUseViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation BasicUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    if([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        [self.manager requestAlwaysAuthorization]; // 请求前台和后台定位权限
//            [self.manager requestWhenInUseAuthorization];// 请求前台定位权限
    }
    else {
        [self.manager startUpdatingLocation];
    }
}


/**
 *  授权状态发生改变时调用
 *
 *  @param manager 触发事件的对象
 *  @param status  当前授权的状态
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    /*
     用户从未选择过权限
     kCLAuthorizationStatusNotDetermined
     无法使用定位服务，该状态用户无法改变
     kCLAuthorizationStatusRestricted
     用户拒绝该应用使用定位服务，或是定位服务总开关处于关闭状态
     kCLAuthorizationStatusDenied
     已经授权（废弃）
     kCLAuthorizationStatusAuthorized
     用户允许该程序无论何时都可以使用地理信息
     kCLAuthorizationStatusAuthorizedAlways
     用户同意程序在可见时使用地理位置
     kCLAuthorizationStatusAuthorizedWhenInUse
     */
    
    if (status == kCLAuthorizationStatusNotDetermined){
        DebugLog(@"等待用户授权");
    }
    else if (status == kCLAuthorizationStatusAuthorizedAlways ||
             status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        DebugLog(@"授权成功");
        // 开始定位
        [self.manager startUpdatingLocation];
    }
    else
    {
        DebugLog(@"授权失败");
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

    ;
}
/**
 *  获取到位置信息之后就会调用(调用频率非常高)
 *
 *  @param manager   触发事件的对象
 *  @param locations 获取到的位置
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 如果只需要获取一次, 可以获取到位置之后就停止
//    [self.mgr stopUpdatingLocation];
    
    /*
     location.coordinate; 坐标, 包含经纬度
     location.altitude; 设备海拔高度 单位是米
     location.course; 设置前进方向 0表示北 90东 180南 270西
     location.horizontalAccuracy; 水平精准度
     location.verticalAccuracy; 垂直精准度
     location.timestamp; 定位信息返回的时间
     location.speed; 设备移动速度 单位是米/秒, 适用于行车速度而不太适用于不行
     */
    
    CLLocation *location = [locations lastObject];
    DebugLog(@"%f, %f speed = %f", location.coordinate.latitude, location.coordinate.longitude, location.speed);
    /*
     可以设置模拟器模拟速度
     bicycle ride 骑车移动
     run 跑动
     freeway drive 高速公路驾车
     */
}





- (CLLocationManager *)manager {

    if (_manager == nil) {
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        [_manager setDesiredAccuracy:kCLLocationAccuracyBest];
        _manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
            _manager.allowsBackgroundLocationUpdates = YES;
        }
    }
    return _manager;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {

    DebugLog(@"BasicUseViewController dealloc");
}


/*
 
 ios9 适配:
 
 1>
 
 if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
 _manager.allowsBackgroundLocationUpdates = YES;
 }
 
 2>
 
 在plist中加上下面的xml:
 
 <key>NSLocationAlwaysUsageDescription</key>
 <string>location 请求后台定位权限</string>
 <key>UIBackgroundModes</key>
 <array>
 <string>location</string>
 </array>
 
 3>
 
 打开 模拟器 → debug → location → custom
 
 4>
 
 导入 frameWork
 
 
 */

@end

