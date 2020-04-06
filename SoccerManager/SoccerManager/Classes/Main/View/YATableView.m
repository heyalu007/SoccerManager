//
//  YATableView.m
//  SoccerManager
//
//  Created by ihandysoft on 16/1/14.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "YATableView.h"
#import "YAPullUpRefreshView.h"
#import "YAPullDownRefreshView.h"
#import "MJRefresh.h"

@interface YATableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) YAPullUpRefreshView *pullUpRefreshView;
@property (nonatomic, strong) YAPullDownRefreshView *pullDownRefreshView;
@end

@implementation YATableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame];
    if (self) {
        self.displayTableView = [[UITableView alloc] initWithFrame:self.bounds style:style];
        self.displayTableView.backgroundColor = [UIColor clearColor];
        self.displayTableView.backgroundView = nil;
        [self.displayTableView setAutoresizingMask:
         UIViewAutoresizingFlexibleLeftMargin
         | UIViewAutoresizingFlexibleWidth
         | UIViewAutoresizingFlexibleRightMargin
         | UIViewAutoresizingFlexibleTopMargin
         | UIViewAutoresizingFlexibleHeight
         | UIViewAutoresizingFlexibleBottomMargin];
        self.displayTableView.delegate = self;
        self.displayTableView.dataSource = self;
        [self addSubview:self.displayTableView ];
    }
    return self;
}

- (void)reloadData {

    [self.displayTableView reloadData];
}

- (void)setPullDownRefresh:(void (^)())callBack {
    [self.displayTableView addHeaderWithCallback:callBack];
}
- (void)stopPullDownRefresh {
    [self.displayTableView headerEndRefreshing];
}



//
//- (void)setPullUpRefresh:(void (^)(void))pullHandler {
//    if (pullHandler) {
//        self.pullUpRefreshView.pullToRefreshActionHandler = pullHandler;
//    }
//}
//
//- (void)setPullDownRefresh:(BOOL(^)(void))pullHandler {
//
//    if (pullHandler) {
//        self.pullDownRefreshView.pullToRefreshActionHandler = pullHandler;
//    }
//}
//
//- (void)setPullUpState:(YAPullUpRefreshViewState) tablestate{
//    [self.pullUpRefreshView setState:tablestate];
//}
//
//- (void)setPullUpFinishView:(UIView *)finishView{
//    [self.pullUpRefreshView setFinishedView:finishView];
//}
//
//- (void)setPullUpHidden{
//    [self.pullUpRefreshView hiddenPullUpView];
//}


#pragma mark - 懒加载

//- (YAPullDownRefreshView *)pullDownRefreshView {
//
//    if (_pullDownRefreshView == nil) {
//        _pullDownRefreshView = [[YAPullDownRefreshView alloc] initWithScrollView:self.displayTableView];
//        [self.displayTableView addSubview:_pullDownRefreshView];
//    }
//    return _pullDownRefreshView;
//}
//
//- (YAPullUpRefreshView *)pullUpRefreshView {
//
//    if (_pullUpRefreshView == nil) {
//        _pullUpRefreshView = [[YAPullUpRefreshView alloc] initWithScrollView:self.displayTableView];
//        [self.displayTableView addSubview:_pullUpRefreshView];
//    }
//    return _pullUpRefreshView;
//}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [self.dataSource tableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        UITableViewCell *cell = [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell;
    }
    return [[UITableViewCell alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self.dataSource numberOfSectionsInTableView:tableView];
    }
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return [self.dataSource tableView:tableView titleForHeaderInSection:section];
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        return [self.dataSource tableView:tableView titleForFooterInSection:section];
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [self.dataSource tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        return [self.dataSource tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [self.delegate tableView:tableView heightForHeaderInSection:section];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [self.delegate tableView:tableView heightForFooterInSection:section];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.delegate tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [self.delegate tableView:tableView viewForFooterInSection:section];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView willSelectRowAtIndexPath:indexPath];
    }
    return indexPath;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}


@end
