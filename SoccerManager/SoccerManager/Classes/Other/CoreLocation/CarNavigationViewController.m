//
//  CarNavigationViewController.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/3/2.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "CarNavigationViewController.h"
#import "Util.h"
#import <CoreLocation/CoreLocation.h>

@interface CarNavigationViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;

// 上一次的位置
@property (nonatomic, strong) CLLocation *previousLocation;
// 总路程
@property (nonatomic, assign) CLLocationDistance sumDistance;
// 总时间
@property (nonatomic, assign) NSTimeInterval sumTime;

@end

@implementation CarNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.manager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
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



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self carNav:locations];
}



- (void)carNav:(NSArray *)locations {

    //    CLLocation; timestamp 当前获取到为止信息的时间
    /*
     获取走了多远（这一次的位置 减去上一次的位置）
     获取走这段路花了多少时间 （这一次的时间 减去上一次的时间）
     获取速度 （走了多远 ／ 花了多少时间）
     获取总共走的路程 （把每次获取到走了多远累加起来）
     获取平均速度 （用总路程 ／ 总时间）
     */
    // 获取当前的位置
    CLLocation *newLocation = [locations lastObject];
    
    if (self.previousLocation != nil) {
        // 计算两次的距离(单位时米)
        CLLocationDistance distance = [newLocation distanceFromLocation:self.previousLocation];
        // 计算两次之间的时间（单位只秒）
        NSTimeInterval dTime = [newLocation.timestamp timeIntervalSinceDate:self.previousLocation.timestamp];
        // 计算速度（米／秒）
        CGFloat speed = distance / dTime;
        
        
        // 累加时间
        self.sumTime += dTime;
        
        // 累加距离
        self.sumDistance += distance;
        
        //  计算平均速度
        CGFloat avgSpeed = self.sumDistance / self.sumTime;
        
        NSLog(@"距离%f 时间%f 速度%f 平均速度%f 总路程 %f 总时间 %f", distance, dTime, speed, avgSpeed, self.sumDistance, self.sumTime);
    }
    
    // 纪录上一次的位置
    self.previousLocation = newLocation;
}



- (CLLocationManager *)manager {
    
    if (_manager == nil) {
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        [_manager setDesiredAccuracy:kCLLocationAccuracyBest];
        _manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
            _manager.allowsBackgroundLocationUpdates = YES;
        }
        if([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
            [self.manager requestAlwaysAuthorization];
        }
    }
    return _manager;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
