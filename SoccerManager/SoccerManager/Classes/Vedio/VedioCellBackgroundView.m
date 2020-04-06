//
//  VedioCellBackgroundView.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/31.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "VedioCellBackgroundView.h"
#import "Util.h"

@implementation VedioCellBackgroundView


- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef contex = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 79)];
    [path addLineToPoint:CGPointMake(kScreenWidth, 79)];
    
    CGContextAddPath(contex, path.CGPath);
    CGContextSetLineWidth(contex, 1);
    CGContextSetLineCap(contex, kCGLineCapRound);
    [RGBColor(217, 216, 219, 1.0) set];
    CGContextStrokePath(contex);
}

@end
