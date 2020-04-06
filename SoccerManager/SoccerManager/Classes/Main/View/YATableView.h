//
//  YATableView.h
//  SoccerManager
//
//  Created by ihandysoft on 16/1/14.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAPullDownRefreshView.h"
#import "YAPullUpRefreshView.h"

typedef enum {

    YATableViewStyleMatch,

}YATableViewStyle;


@interface YATableView : UIView

@property (nonatomic, weak) id<UITableViewDelegate> delegate;
@property (nonatomic, weak) id<UITableViewDataSource> dataSource;
@property (nonatomic, strong) UITableView *displayTableView;

- (void)reloadData;
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
//- (void)setPullDownRefresh:(BOOL(^)(void))pullHandler;
//- (void)setPullUpRefresh:(void (^)(void))pullHandler;
//- (void)setPullUpState:(YAPullUpRefreshViewState)tablestate;
//- (void)setPullUpFinishView:(UIView *)finishView;
//- (void)setPullUpHidden;
- (void)setPullDownRefresh:(void (^)())callBack;
- (void)stopPullDownRefresh;

@end
