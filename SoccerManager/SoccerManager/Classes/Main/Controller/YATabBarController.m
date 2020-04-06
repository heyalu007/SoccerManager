//
//  YATabBarController.m
//  SoccerManager
//
//  Created by ihandysoft on 15/12/23.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import "YATabBarController.h"
#import "MatchViewController.h"
#import "VedioViewController.h"
#import "NewsViewController.h"
#import "RecordViewController.h"
#import "DiscoverViewController.h"
#import "YANavigationController.h"
#import "Util.h"

@interface YATabBarController ()

@end

@implementation YATabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MatchViewController *forecastVc = [[MatchViewController alloc] init];
    VedioViewController *vedioVc = [[VedioViewController alloc] init];
    NewsViewController *newsVc = [[NewsViewController alloc] init];
//    RecordViewController *recordVc = [[RecordViewController alloc] init];
    DiscoverViewController *discoverVc = [[DiscoverViewController alloc] init];
    
    [self addChildVc:forecastVc title:@"预告" image:@"bar_zhibo" selectedImage:@"bar_zhiboed"];
    [self addChildVc:vedioVc title:@"视频" image:@"bar_video" selectedImage:@"bar_videoed"];
    [self addChildVc:newsVc title:@"新闻" image:@"bar_news" selectedImage:@"bar_newsed"];
//    [self addChildVc:recordVc title:@"数据" image:@"bar_shuju" selectedImage:@"bar_shujued"];
    [self addChildVc:discoverVc title:@"发现" image:@"bar_faxian" selectedImage:@"bar_faxianed"];
}


- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    //    childVc.tabBarItem.title = title; // 设置tabbar的文字
    //    childVc.navigationItem.title = title; // 设置navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = RGBColor(123, 123, 123, 1.0);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = RGBColor(107, 167, 241, 1.0);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    childVc.edgesForExtendedLayout = UIRectEdgeNone;
    /*
     iOS7引入的属性，默认值为UIRectEdgeAll。当容器是navigationController时，默认的布局将从navigationBar的顶部开始。这里改为none;
     */
    
    YANavigationController *nav = [[YANavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
