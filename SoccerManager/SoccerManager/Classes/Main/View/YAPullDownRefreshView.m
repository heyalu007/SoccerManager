//
//  PullToRefresh.m
//  PullRefreshTableView
//
//  Created by fredlee on 14-11-10.
//  Copyright (c) 2014年 futurebits. All rights reserved.
//

#import "YAPullDownRefreshView.h"

static CGFloat const PullDownToRefreshViewHeight = 60;

@interface YAPullDownRefreshView ()

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicatorView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) BOOL byDragging;

@end

@implementation YAPullDownRefreshView
@synthesize state = _state;

- (id)initWithScrollView:(UIScrollView *) scrollView{
    self = [super initWithFrame:CGRectMake(0, -PullDownToRefreshViewHeight, scrollView.frame.size.width, PullDownToRefreshViewHeight)];

    self.scrollView = scrollView;
    self.byDragging = NO;
    
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self.scrollView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];

    self.backgroundColor = [UIColor clearColor];
    
    CGFloat x = (self.frame.size.width - 26) / 2;
    CGRect tempRect = CGRectMake(x, PullDownToRefreshViewHeight - 26.0f, 26.0f, 26.0f);
    self.containerView = [[UIView alloc] initWithFrame:tempRect];
    self.containerView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.containerView];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    
    self.activityIndicatorView.center = self.containerView.center;
    [self addSubview:self.activityIndicatorView];
    
    return self;
}

- (void)removeFromSuperview{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.scrollView removeObserver:self forKeyPath:@"frame"];
    [super removeFromSuperview];
}
#pragma mark - Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"]){
        [self scrollViewDidScroll:[change valueForKey:NSKeyValueChangeNewKey]];
    }
    else if([keyPath isEqualToString:@"contentSize"]) {
        [self layoutSubviews];
        
        CGFloat yOrigin;
        yOrigin = -PullDownToRefreshViewHeight;
        self.frame = CGRectMake(0, yOrigin, self.bounds.size.width, PullDownToRefreshViewHeight);
    }
    else if([keyPath isEqualToString:@"frame"])
        [self layoutSubviews];
}

- (void)scrollViewDidScroll:(id)offset {
    CGPoint contentOffset = [offset CGPointValue];
    
    CGFloat xxTop = self.originalTopInset;
    CGFloat bottom = 2.0f;
    CGFloat height =  -contentOffset.y - xxTop - 1;
    CGFloat centerY = 0;
    if (height < 0) {
        height = 0;
    }
    if (height > (self.containerView.bounds.size.height + 2*bottom)) {
        centerY = self.frame.size.height - height/2.0;
    }
    else{
        centerY = self.bounds.size.height - self.containerView.bounds.size.height/2 - bottom;
    }

    if(self.state != YAPullDownRefreshViewStateLoading) {
        if(!self.scrollView.isDragging){
            self.containerView.center = CGPointMake(self.containerView.center.x, centerY);
            self.activityIndicatorView.center = self.containerView.center;
            self.byDragging = YES;
            self.state = YAPullDownRefreshViewStateLoading;
            return;
        }
    }
    else {
        CGFloat offset;
        UIEdgeInsets contentInset;
        offset = MAX(self.scrollView.contentOffset.y * -1, self.originalTopInset);
        offset = MIN(offset, self.originalTopInset + self.bounds.size.height);
        contentInset = self.scrollView.contentInset;
        [self setScrollViewContentInset:UIEdgeInsetsMake(offset, contentInset.left, contentInset.bottom, contentInset.right) animated:NO];
    }
    self.containerView.center = CGPointMake(self.containerView.center.x, centerY);
    self.activityIndicatorView.center = self.containerView.center;
}


- (void)setScrollViewContentInsetForLoading {
    if (self.byDragging) {
        CGFloat offset = MAX(self.scrollView.contentOffset.y * -1, 0);
        UIEdgeInsets currentInsets = self.scrollView.contentInset;
        currentInsets.top = MIN(offset, self.originalTopInset + self.bounds.size.height);
        [self setScrollViewContentInset:currentInsets animated:YES];
        self.byDragging = NO;
    }
    else{
        CGPoint offset = self.scrollView.contentOffset;
        offset.y = -1 * (self.originalTopInset + self.bounds.size.height);
        [self.scrollView setContentOffset:offset animated:NO];
    }
}

- (void)resetScrollViewContentInset {
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.top = self.originalTopInset;
    [self.activityIndicatorView stopAnimating];
    self.containerView.hidden = NO;
    [self setScrollViewContentInset:currentInsets animated:YES];
}


- (void)setScrollViewContentInset:(UIEdgeInsets)contentInset animated:(BOOL)animated{

    if (animated) {
        [UIView animateWithDuration:.3
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.scrollView.contentInset = contentInset;
                         }
                         completion:^(BOOL finish){
                         }];
    }
    else
        self.scrollView.contentInset = contentInset;
}


- (void)setState:(YAPullDownRefreshViewState)newState {
    
    if(_state == newState)
        return;
    
    YAPullDownRefreshViewState previousState = _state;
    _state = newState;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    switch (newState) {
        case YAPullDownRefreshViewStateStopped:
            [self resetScrollViewContentInset];
            break;
        case YAPullDownRefreshViewStateLoading:
            if(previousState == YAPullDownRefreshViewStateStopped){
                BOOL refreshed = NO;
                if (_pullToRefreshActionHandler != nil) {
                    refreshed = _pullToRefreshActionHandler();
                }
                if (refreshed == NO) {
                    _state = YAPullDownRefreshViewStateStopped;
                }
            }
            
            if (_state == YAPullDownRefreshViewStateLoading) {
                [self setScrollViewContentInsetForLoading];
                self.containerView.hidden = YES;
                [self.activityIndicatorView startAnimating];
            }
            break;
    }

}


@end
