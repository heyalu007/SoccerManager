//
//  BasicAnimationViewController.m
//  SoccerManager
//
//  Created by ihandysoft on 16/3/1.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "BasicAnimationViewController.h"

@interface BasicAnimationViewController ()

@property (nonatomic, weak) CALayer *layer;

@end


//BasicAnimation只能调整一次;

@implementation BasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *layer = [CALayer layer];
    
    /*
     设置position
     锚点决定着CALayer身上的哪个点会在position属性所指的位置;
     以自己的左上角为原点(0, 0);
     它的x、y取值范围都是0~1，默认值为（0.5, 0.5）;
     */
    layer.position = CGPointMake(100, 100);
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.contents = (id)[UIImage imageNamed:@"心"].CGImage;
    [self.view.layer addSublayer:layer];
    _layer = layer;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self heartMove];
}

- (void)heartBeat {

    // 创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    // 设置动画的属性
    anim.keyPath = @"transform.scale";
    
    // 设置属性改变的值
    anim.toValue = @0.5;
    
    // 设置动画时长
    anim.duration = 0.25;
    
    // 取消反弹
    // 动画执行完毕之后不要把动画移除
    anim.removedOnCompletion = NO;
    
    // 保持最新的位置
    anim.fillMode = kCAFillModeForwards;
    
    // 重复动画的次数
    anim.repeatCount = MAXFLOAT;
    
    // 给图层添加了动画
    [_layer addAnimation:anim forKey:nil];
}

- (void)heartMove {
    
    // 创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.delegate = self;
    
    // 设置动画的属性
    anim.keyPath = @"position";
    
    // 设置属性改变的值
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    
    // 设置动画时长
    anim.duration = 2;
    
    // 取消反弹
    // 动画执行完毕之后不要把动画移除
    anim.removedOnCompletion = NO;
    
    // 保持最新的位置
    anim.fillMode = kCAFillModeForwards;
    
    // 给图层添加了动画
    [_layer addAnimation:anim forKey:@"456"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    ;
}



@end
