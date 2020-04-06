//
//  KeyAnimationViewController.m
//  SoccerManager
//
//  Created by ihandysoft on 16/3/1.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "KeyAnimationViewController.h"

@interface KeyAnimationViewController ()

@property (weak, nonatomic) IBOutlet UIView *testView;

@end

//KeyAnimation可以给一个属性设置多个值；

@implementation KeyAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self moveAnimation1];
}

- (void)moveAnimation2 {

    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    // 设置动画属性
    anim.keyPath = @"position";
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)];
    
    anim.path = path.CGPath;
    
    anim.duration = 0.25;
    
    // 取消反弹
    anim.removedOnCompletion = NO;
    
    anim.fillMode = kCAFillModeForwards;
    
    anim.repeatCount = MAXFLOAT;
    
    [_testView.layer addAnimation:anim forKey:nil];
}

- (void)moveAnimation1 {
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    // 设置动画属性
    anim.keyPath = @"position";
    
    NSValue *v1 = [NSValue valueWithCGPoint:self.testView.center];
    NSLog(@"%@",NSStringFromCGPoint(self.testView.center));
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(160, 160)];
    
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(270, 0)];
    
    anim.values = @[v1,v2,v3];
    
    anim.duration = 2;
    
    [_testView.layer addAnimation:anim forKey:nil];
}

@end
