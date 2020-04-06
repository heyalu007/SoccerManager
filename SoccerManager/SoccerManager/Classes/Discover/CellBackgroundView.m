

#import "CellBackgroundView.h"
#import "Util.h"

static void contextDrawLine(CGContextRef context, CGRect rect, CellLineStyle style) {
    
    CGPoint startPoint, endPoint;
    
    switch (style) {
        case CellLineTypeNone:
            startPoint = CGPointMake(0, 0);
            endPoint = CGPointMake(0, 0);
            break;
        case CellLineTypeMiddle:
            startPoint = CGPointMake(20, rect.size.height);
            endPoint = CGPointMake(rect.size.width, rect.size.height);
            break;
        case CellLineTypeTop:
            startPoint = CGPointMake(0, 0);
            endPoint = CGPointMake(rect.size.width, 0);
            break;
        case CellLineTypeButtom:
            startPoint = CGPointMake(0, rect.size.height);
            endPoint = CGPointMake(rect.size.width, rect.size.height);
            break;
            
        default:
            break;
    }
    //开始一个起始路径
    CGContextBeginPath(context);
    //设置起点
    CGContextMoveToPoint(context, startPoint.x,startPoint.y);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    //结束
    CGContextStrokePath(context);
}


@interface CellBackgroundView ()

@property (nonatomic, assign) CellLineStyle lineStyle;

@end

@implementation CellBackgroundView

- (instancetype)initWithFrame:(CGRect)frame style:(CellLineStyle)style {

    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.lineStyle = style;
    }
    return self;
}

/*
 Review:
 当视图第一次显示的时候，会调用；是在viewdidload之后；
*/
- (void)drawRect:(CGRect)rect {//这个rect就是self.frame
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //设置线条粗细宽度
    CGContextSetLineWidth(context, 1.0);
    //设置颜色
    CGContextSetRGBStrokeColor(context, 217/255.0, 216/255.0, 219/255.0, 1.0);
    //画线
    if (self.lineStyle & CellLineTypeTop) {
        contextDrawLine(context, rect, CellLineTypeTop);
    }
    if (self.lineStyle & CellLineTypeMiddle) {
        contextDrawLine(context, rect, CellLineTypeMiddle);
    }
    if (self.lineStyle & CellLineTypeButtom) {
        contextDrawLine(context, rect, CellLineTypeButtom);
    }
}



@end
