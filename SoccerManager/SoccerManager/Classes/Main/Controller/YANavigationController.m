//
//  YANavigationController.m
//  SoccerManager
//
//  Created by ihandysoft on 15/12/23.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import "YANavigationController.h"
#import "UIImage+Scale.h"
#import <objc/runtime.h>

@interface YANavigationController ()

@property (nonatomic, assign) CGPoint startTouchPoint;

@end

@implementation YANavigationController

//+(void)load {
//
//    Method original, replaced;
//    original = class_getInstanceMethod(self, @selector(pushViewController:animated:));
//    replaced = class_getInstanceMethod(self, @selector(pushViewControllerTest:animated:));
//    method_exchangeImplementations(original, replaced);
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏的背景颜色;
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:116/255.0 green:181/255.0 blue:247/255.0 alpha:1.0]];
    //设置导航栏左右buttonItem的颜色;
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dic[NSFontAttributeName] = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    [self.navigationBar setTitleTextAttributes:dic];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paningGestureReceive:)];
    [recognizer delaysTouchesBegan];
    [self.view addGestureRecognizer:recognizer];
}


- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer {
    
    if (self.viewControllers.count <= 1) {
        return;
    }
    CGPoint touchPoint = [recoginzer locationInView:[[UIApplication sharedApplication] keyWindow]];
    
    switch (recoginzer.state)
    {
        case UIGestureRecognizerStateBegan:
            self.startTouchPoint = touchPoint;
            break;
            
        case UIGestureRecognizerStateEnded:
            if (touchPoint.x - self.startTouchPoint.x > 150) {
                [self popViewControllerAnimated:YES];
            }
            self.startTouchPoint = CGPointZero;
            break;
            
        default:
            self.startTouchPoint = CGPointZero;
            break;
    }
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    NSUInteger count = 0;
    UIViewController *rootViewController = [self.viewControllers firstObject];
    if ([NSStringFromClass(rootViewController.class) isEqualToString:@"MatchViewController"]) {
        count = 1;
    }
    if (self.viewControllers.count > count) {
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [[UIButton alloc] init];
        btn.imageView.image = [UIImage imageNamed:@"navc_back"];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navc_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
//        UIImage *rightImage = [UIImage imageNamed:@"neiyemenuDown"];
//        rightImage = [rightImage TransformtoSize:CGSizeMake(28, 28)];
//        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    }
    [super pushViewController:viewController animated:animated];
}


- (void)back {
    
    [self popViewControllerAnimated:YES];
}


@end
