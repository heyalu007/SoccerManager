//
//  YAShapeView.m
//  SoccerManager
//
//  Created by ihandysoft on 16/1/26.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "YAShapeView.h"

@implementation YAShapeView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 50, 50)];
        button.backgroundColor = [UIColor greenColor];
        [self addSubview:button];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawStraightLine];
}


/**
 *  画直线
 */
- (void)drawStraightLine {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 125)];
    [path addLineToPoint:CGPointMake(230, 125)];
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(10, 10)];
    [path1 addLineToPoint:CGPointMake(125, 100)];
    
    //把路径添加到上下文;
    CGContextAddPath(ctx, path.CGPath);
    CGContextAddPath(ctx, path1.CGPath);
    
    CGContextSetLineWidth(ctx, 10);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    [[UIColor redColor] set];
    CGContextStrokePath(ctx);
}

/**
 *  画弧线
 */
- (void)drawArcLine {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint startP = CGPointMake(10, 125);
    CGPoint endP = CGPointMake(240, 125);
    //注意controlP;
    CGPoint controlP = CGPointMake(125, 50);
    [path moveToPoint:startP];
    [path addQuadCurveToPoint:endP controlPoint:controlP];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}

/**
 *  画三角形
 */

- (void)drawTriangle {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint startP = CGPointMake(10, 100);
    [path moveToPoint:startP];
    [path addLineToPoint:CGPointMake(125, 220)];
    [path addLineToPoint:CGPointMake(240, 100)];
    //从路径的终点连接到起点,相当于[path addLineToPoint:startP];
    [path closePath];
    
    CGContextAddPath(ctx, path.CGPath);
    //设置三角形内部的颜色;
    [[UIColor blueColor] setFill];
    //设置边线颜色;
    [[UIColor redColor] setStroke];
    //设置边线的粗细;
    CGContextSetLineWidth(ctx, 15);
    
    /*
     CGContextStrokePath(ctx);  //描边
     CGContextFillPath(ctx);    //填充
     即填充又描边 kCGPathFillStroke
     */
    CGContextDrawPath(ctx, kCGPathFillStroke);
}


/**
 *  画矩形
 */
- (void)drawRectangle {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(10, 10, 200, 200)];
    //画圆角;
    path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, 200, 200) cornerRadius:20];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}


/**
 *  画圆
 */
- (void)drawCircle {
    // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.拼接路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 100, 200, 100)];
    
    // 3.把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    
    // 4.渲染上下文
    CGContextStrokePath(ctx);
    
}


/**
 *  画扇形
 */
- (void)drawSector {
    // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.拼接路径
    CGPoint center = CGPointMake(125, 125);
    CGFloat radius = 100;
    CGFloat startA = 0;
    CGFloat endA = M_PI_2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    // 3.把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    
    // 4.渲染上下文
    CGContextStrokePath(ctx);
}


/**
 *  画扇形
 */
- (void)drawSector2 {
    
    // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.拼接路径
    CGPoint center = CGPointMake(125, 125);
    CGFloat radius = 100;
    CGFloat startA = 0;
    CGFloat endA = M_PI_2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    [path addLineToPoint:center];
    
    // 3.把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    
    // 4.渲染上下文
    //    CGContextStrokePath(ctx);
    CGContextFillPath(ctx);
}


@end
