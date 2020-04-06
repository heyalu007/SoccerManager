//
//  YAPullUpRefreshView.h
//  PullRefreshTableView
//
//  Created by dingchenliang on 11/24/14.
//  Copyright (c) 2014 futurebits. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YAPullUpRefreshViewStateNormal,//只显示风火轮,contentInset.bottom含上拉刷新高度
    YAPullUpRefreshViewStateLoading,//只显示风火轮,含上拉刷新高度
    YAPullUpRefreshViewStateFailed,//只显示loadmore按钮,含上拉刷新高度
    YAPullUpRefreshViewStateFinished,//只显示～标志,含上拉刷新高度
}YAPullUpRefreshViewState;

@interface YAPullUpRefreshView : UIView

@property (nonatomic, assign) YAPullUpRefreshViewState state;
@property (nonatomic, copy) void (^pullToRefreshActionHandler)(void);

- (id)initWithScrollView:(UIScrollView *) scrollView;
- (void)hiddenPullUpView;
- (void)setFinishedView:(UIView *)view;
@end
