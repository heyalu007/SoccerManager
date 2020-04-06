//
//  YAPullDownRefreshView.h
//  PullRefreshTableView
//
//  Created by fredlee on 14-11-10.
//  Copyright (c) 2014年 futurebits. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YAPullDownRefreshViewStateStopped,
    YAPullDownRefreshViewStateLoading,
}YAPullDownRefreshViewState;

@interface YAPullDownRefreshView : UIView 
@property (nonatomic, assign) YAPullDownRefreshViewState state;
@property (nonatomic, assign) CGFloat originalTopInset;
@property (nonatomic, copy) BOOL (^pullToRefreshActionHandler)(void);

- (id)initWithScrollView:(UIScrollView *) scrollView;

@end