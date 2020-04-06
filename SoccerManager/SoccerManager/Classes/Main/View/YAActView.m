//
//  YAActView.m
//  SoccerManager
//
//  Created by 何亚鲁 on 15/12/30.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import "YAActView.h"

@interface YAActView ()

@property (strong, nonatomic) UIActivityIndicatorView *act;
@property (strong, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UIView *superView;

@end

@implementation YAActView

- (instancetype)initWithSuperView:(UIView *)superView andFrame:(CGRect)actViewFrame {

    if (self = [super init]) {
        self.superView = superView;
        self.backgroundColor = [UIColor whiteColor];
        self.frame = actViewFrame;
    }
    return self;
}

- (void)startAnimating {

    [self.superView addSubview:self];
    [self.act startAnimating];
}

- (void)stopAnimatingWithTitle:(NSString *)title {

    [self.act stopAnimating];
    if (title == nil) {
        [self removeFromSuperview];
    }
    else {
        self.titleLabel.text = title;
    }
    
}

- (UIActivityIndicatorView *)act {

    if (_act == nil) {
        _act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _act.center = self.center;
        [self addSubview:_act];
    }
    return _act;
}

- (UILabel *)titleLabel {

    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        _titleLabel.center = self.center;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)dismissViewWithText:(NSString *)text withTextSize:(CGSize)size withDelegate:(id)delegate withSelector:(SEL)selector{
    
    [UIView animateWithDuration:3 animations:^{
        self.alpha = 0.9;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if ([delegate respondsToSelector:selector]) {
//                callBack(delegate, selector);
            }
        }];
        
    }];
}
@end
