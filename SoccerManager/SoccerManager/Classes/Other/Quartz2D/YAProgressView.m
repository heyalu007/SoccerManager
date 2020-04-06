//
//  YAProgressView.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/26.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "YAProgressView.h"
#import "Util.h"

@interface YAProgressView ()

@property (weak, nonatomic) IBOutlet UISlider *sliderView;
@property (assign, nonatomic) float progress;
@property (strong, nonatomic) UILabel *progressLabel;
@end


@implementation YAProgressView

+ (instancetype)progressView {

    return [[[NSBundle mainBundle] loadNibNamed:@"YAProgressView" owner:self options:nil] lastObject];
}

- (IBAction)valueChange:(UISlider *)sender {
    
    self.progress = sender.value;
    self.progressLabel.text = [NSString stringWithFormat:@"%.2f",_progress];
    [self setNeedsDisplay];
}


- (UILabel *)progressLabel {

    if (_progressLabel == nil) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.frame = CGRectMake(0, 0, 60, 30);
        _progressLabel.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_progressLabel];
    }
    return _progressLabel;
}

/*
 1、在加载的时候会调用，但默认只获取一次；
 2、如果在其他时刻调用，需要set
 */
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.拼接路径
    CGPoint center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    CGFloat radius = 100 - 2;
    CGFloat startA = -M_PI_2;
    CGFloat endA = -M_PI_2 + self.progress * M_PI * 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    // 3.把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    
    // 4.把上下文渲染到视图
    CGContextStrokePath(ctx);
    
}

- (void)awakeFromNib {

    [super awakeFromNib];
    self.sliderView.value = 0;
}

@end
