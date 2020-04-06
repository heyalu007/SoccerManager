//
//  PullUpToRefresh.m
//  PullRefreshTableView
//
//  Created by dingchenliang on 11/24/14.
//  Copyright (c) 2014 futurebits. All rights reserved.
//

#import "YAPullUpRefreshView.h"

static CGFloat const PullUpToRefreshViewHeight = 40;

@interface YAPullUpRefreshView ()

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicatorView;
@property (nonatomic, strong) UIButton * reloadButton;
@property (nonatomic, strong) UIView * customFinishView;

@end

@implementation YAPullUpRefreshView

- (id)initWithScrollView:(UIScrollView *)scrollView{
    self = [super initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, PullUpToRefreshViewHeight)];
    self.scrollView = scrollView;
    
    [self addObserver];
    
    self.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120.0, 30.0)];
    [button setTitleColor:[UIColor colorWithRed:(90.0/255) green:(90.0/255) blue:(90.0/255) alpha:1] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button addTarget:self action:@selector(loadMoreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    [self addSubview:button];
    self.reloadButton = button;
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = button.center;
    [self addSubview:self.activityIndicatorView];

    _state = YAPullUpRefreshViewStateNormal;
    
    return self;
}

- (void)removeFromSuperview{
    [self removeObserver];
    [super removeFromSuperview];
}

- (void)addObserver{
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self.scrollView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObserver{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.scrollView removeObserver:self forKeyPath:@"frame"];
 
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"]){
        [self scrollViewDidScroll:[change valueForKey:NSKeyValueChangeNewKey]];
    }
    else if([keyPath isEqualToString:@"contentSize"]) {
        [self layoutSubviews];
        
        CGFloat yOrigin = self.scrollView.contentSize.height;
        self.frame = CGRectMake(0, yOrigin, self.bounds.size.width, self.bounds.size.height);
    }
    else if([keyPath isEqualToString:@"frame"])
        [self layoutSubviews];
}

- (void)scrollViewDidScroll:(id)offset {
    CGPoint contentOffset = [offset CGPointValue];
    
    if ((self.state == YAPullUpRefreshViewStateNormal || self.state == YAPullUpRefreshViewStateFailed)
        && (self.scrollView.contentSize.height+self.scrollView.contentInset.top) >= self.scrollView.frame.size.height
        && (contentOffset.y + self.scrollView.frame.size.height) > (self.scrollView.contentSize.height + self.activityIndicatorView.frame.origin.y + 2))
    {
        self.state = YAPullUpRefreshViewStateLoading;
    }
}

- (void)loadMoreButtonPressed:(id)sender{
    [self setState:YAPullUpRefreshViewStateLoading];
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

- (void)resetScrollContentInsetToShow{
    UIEdgeInsets oriInsets = self.scrollView.contentInset;
    oriInsets.bottom +=  PullUpToRefreshViewHeight;
    [self setScrollViewContentInset:oriInsets animated:NO];
}
- (void)resetScrollContentInsetToHidden{
    UIEdgeInsets oriInsets = self.scrollView.contentInset;
    oriInsets.bottom -=  PullUpToRefreshViewHeight;
    [self setScrollViewContentInset:oriInsets animated:NO];
}

- (void)resetRefreshViewFrame{
    CGRect oriFrame = self.frame;
    oriFrame.origin.y = self.scrollView.contentSize.height;
    self.frame = oriFrame;
}

- (void)setState:(YAPullUpRefreshViewState)newState{
    if(_state == newState)
        return;
    
    YAPullUpRefreshViewState previousState = _state;
    _state = newState;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    switch (newState) {
        case YAPullUpRefreshViewStateNormal:
            self.reloadButton.hidden = YES;
            [self.activityIndicatorView startAnimating];
            break;
        case YAPullUpRefreshViewStateLoading:
            if(previousState == YAPullUpRefreshViewStateNormal
               || previousState == YAPullUpRefreshViewStateFailed){
                if (_pullToRefreshActionHandler != nil) {
                     _pullToRefreshActionHandler();
                }
                
            }
            [self.activityIndicatorView startAnimating];
            self.reloadButton.hidden = YES;
            break;
        case YAPullUpRefreshViewStateFailed:
            [self.activityIndicatorView stopAnimating];
            self.reloadButton.hidden = NO;
            self.reloadButton.enabled = YES;
            self.reloadButton.frame = CGRectMake(106, 0, 108, 36);
            [self.reloadButton setBackgroundImage:[UIImage imageNamed:@"messenger_profile_loadmore.png"] forState:UIControlStateNormal];
            [self.reloadButton setBackgroundImage:[UIImage imageNamed:@"messenger_profile_loadmore.png"] forState:UIControlStateSelected];
            [self.reloadButton setImage:nil forState:UIControlStateNormal];
            [self.reloadButton setImage:nil forState:UIControlStateSelected];
            [self.reloadButton setTitle:@"Load More..." forState:UIControlStateNormal];
            break;
        case YAPullUpRefreshViewStateFinished:
            [self.activityIndicatorView stopAnimating];
            self.reloadButton.frame = CGRectMake(0, 0, 320, 30);
            self.reloadButton.hidden = NO;
            self.reloadButton.enabled = NO;
            [self.reloadButton setImage:[UIImage imageNamed:@"messenger_loadmore_end.png"] forState:UIControlStateNormal];
            [self.reloadButton setImage:[UIImage imageNamed:@"messenger_loadmore_end.png"] forState:UIControlStateSelected];
            [self.reloadButton setBackgroundImage:nil forState:UIControlStateNormal];
            [self.reloadButton setBackgroundImage:nil forState:UIControlStateSelected];
            [self.reloadButton setTitle:nil forState:UIControlStateNormal];
            break;
    }
    
}

- (void)hiddenPullUpView{
    //调整contentOffset
    CGPoint contentOffset = self.scrollView.contentOffset;
    CGFloat heightOffset = (contentOffset.y+self.scrollView.frame.size.height-self.scrollView.contentInset.bottom+PullUpToRefreshViewHeight) - self.scrollView.contentSize.height;
    heightOffset = MAX(0, heightOffset);
    heightOffset = MIN(heightOffset, PullUpToRefreshViewHeight);
    contentOffset.y -= heightOffset;
    if (contentOffset.y < -self.scrollView.contentInset.top) {
        contentOffset.y = -self.scrollView.contentInset.top;
    }
    if (contentOffset.y != self.scrollView.contentOffset.y) {
        [self removeObserver];
        __weak YAPullUpRefreshView *weakSelf = self;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [weakSelf.scrollView setContentOffset:contentOffset animated:NO];
        } completion:^(BOOL finished) {
            [weakSelf addObserver];
        }];
    }
    
}

- (void)setFinishedView:(UIView *)view{
    UIEdgeInsets insets = self.scrollView.contentInset;
    CGRect selfFrame = self.frame;
    
    if (view != nil) {
        CGRect tempRect = view.frame;
        tempRect.origin.y = 0;
        tempRect.origin.x = (self.bounds.size.width-view.bounds.size.width)/2;
        view.frame = tempRect;
        CGFloat heightOffset = tempRect.size.height - self.bounds.size.height;
        insets = self.scrollView.contentInset;
        insets.bottom += heightOffset;
        [self addSubview:view];
        selfFrame.size.height = view.bounds.size.height;
    }
    else{
        [self.customFinishView removeFromSuperview];
        CGFloat heightOffset = PullUpToRefreshViewHeight - self.bounds.size.height;
        insets = self.scrollView.contentInset;
        insets.bottom += heightOffset;
        selfFrame.size.height = PullUpToRefreshViewHeight;
    }
    self.frame = selfFrame;
    self.customFinishView = view;
    [self setScrollViewContentInset:insets animated:NO];
    
}
@end
