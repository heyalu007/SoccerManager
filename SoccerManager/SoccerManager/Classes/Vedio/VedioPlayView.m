//
//  VedioPlayView.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/31.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "VedioPlayView.h"
#import "Util.h"

@implementation VedioPlayView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(22, 18)];
    [path addLineToPoint:CGPointMake(22, 42)];
    [path addLineToPoint:CGPointMake(45, 30)];
    //从路径的终点连接到起点,相当于[path addLineToPoint:startP];
    [path closePath];
    
    CGContextAddPath(ctx, path.CGPath);
    //设置三角形内部的颜色;
    [RGBColor(108, 180, 247, 0.7) setFill];
    //设置边线颜色;
//    [[UIColor redColor] setStroke];
    //设置边线的粗细;
//    CGContextSetLineWidth(ctx, 1);
    
    //描边
//    CGContextStrokePath(ctx);
    //填充
    CGContextFillPath(ctx);
    //填充又描边;
//    CGContextDrawPath(ctx, kCGPathFillStroke);
}

@end
