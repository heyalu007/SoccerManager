//
//  MatchViewController.m
//  SoccerManager
//
//  Created by ihandysoft on 15/12/22.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import "MatchViewController.h"
#import "ImportantMatchController.h"
#import "AllMatchController.h"
#import "OverMatchController.h"
#import "YATitleBarController.h"
#import "Reachability.h"
#import "AppDelegate.h"


@interface MatchViewController ()
<
NSURLSessionDataDelegate
>

@property (nonatomic, strong) Reachability *reachability;

@end

@implementation MatchViewController

- (instancetype)init {

    if (self = [super init]) {
        self.reachability = [Reachability reachabilityForInternetConnection];
        [self.reachability startNotifier];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubViews];
    [self test1];
    
    
}

/**
 *  加载子控制器
 */
- (void)loadSubViews {

    ImportantMatchController *importVc = [[ImportantMatchController alloc] init];
    AllMatchController *allVc = [[AllMatchController alloc] init];
    OverMatchController *overVc = [[OverMatchController alloc] init];
    YATitleBarController *titleBarController = [[YATitleBarController alloc] init];
    titleBarController.viewControllers = @[importVc, allVc, overVc];
    titleBarController.titles = @[@"重要", @"全部", @"已结束"];
    [titleBarController showInViewContoller:self];

//    UIApplication *application = [UIApplication sharedApplication];
//    UITabBarController *vc = (UITabBarController *)application.keyWindow.rootViewController;
//    vc.selectedIndex = 2;
}



- (void)networkStateChange {
    
    if([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable) {
        NSLog(@"连上网了!");
    }
    else {
        NSLog(@"断网了!");
    }
}

- (void)test1 {

    NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *urlString = @"http://m.zhibo8.cc/json/label/hot.jsonp?appname=zhibo8&platform=ios&version_code=4.1.8.3";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {

    ;
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {

    ;
}

@end
