//
//  animationGroupViewController.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/3/2.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "animationGroupViewController.h"

@interface animationGroupViewController ()

@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation animationGroupViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    CABasicAnimation *rotation = [CABasicAnimation animation];
    
    rotation.keyPath = @"transform.rotation";
    
    rotation.toValue = @M_PI_2;
    
    CABasicAnimation *position = [CABasicAnimation animation];
    
    position.keyPath = @"position";
    
    position.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 250)];
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    
    scale.keyPath = @"transform.scale";
    
    scale.toValue = @0.5;
    
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    group.animations = @[rotation,position,scale];
    
    group.duration = 2;
    
    // 取消反弹
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    
    [_redView.layer addAnimation:group forKey:nil];
}

@end
