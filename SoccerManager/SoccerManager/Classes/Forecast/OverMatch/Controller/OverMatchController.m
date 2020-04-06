//
//  OverMatchController.m
//  SoccerManager
//
//  Created by 何亚鲁 on 15/12/26.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import "OverMatchController.h"
#import "OverMatchViewModel.h"
#import "AFNetworking.h"
#import "Util.h"
#import "YAActView.h"
#import "OverMatchDayModel.h"
#import "OverMatchModel.h"
#import "OverMatchCell.h"
#import "YATableView.h"


#import "YACallableCenter.h"

@interface OverMatchController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, copy) NSArray <OverMatchDayModel *> *matchDayList;
@property (nonatomic, strong) OverMatchViewModel *viewModel;
//Review:这里不用强引用,等不到回调viewModel就被销毁了;
@property (nonatomic, strong) YAActView *actView;
@property (nonatomic, strong) YATableView *tableView;

@end

@implementation OverMatchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[OverMatchViewModel alloc] init];
    [self.actView startAnimating];
    __weak typeof(self) weakSelf = self;
    [self.viewModel overMatchInfo:^(NSArray *array, NSError *error) {
        if (error) {
            DebugLog(@"失败");
            [self.actView stopAnimatingWithTitle:@"请检查您的网络!"];
        }
        else {
            weakSelf.matchDayList = array;
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSArray *array = [[YACallableCenter defaultCenter] getEach:@"heyalu" data:nil];
    DebugLog(@"%@",array);
}

#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.matchDayList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    OverMatchDayModel *matchDayModel = [self.matchDayList objectAtIndex:section];
    
    return matchDayModel.matchList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OverMatchCell *cell = [OverMatchCell cellWithTableView:tableView];
    OverMatchDayModel *matchDayModel = [self.matchDayList objectAtIndex:indexPath.section];
    OverMatchModel *matchModel = matchDayModel.matchList[indexPath.row];
    [cell loadContent:matchModel];
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = RGBColor(236, 244, 254, 1.0);
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 30)];
    title.backgroundColor = [UIColor clearColor];
    OverMatchDayModel *matchDayModel = [self.matchDayList objectAtIndex:section];
    title.text = matchDayModel.date_str;
    title.textColor = RGBColor(83, 109, 150, 1.0);
    
    [headerView addSubview:title];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0;
}



-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row) {
        dispatch_async(dispatch_get_main_queue(),^{
            [self.actView stopAnimatingWithTitle:nil];
        });
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 懒加载

- (OverMatchViewModel *)viewModel {
    
    if (_viewModel == nil) {
        _viewModel = [[OverMatchViewModel alloc] init];
    }
    return _viewModel;
}

- (YAActView *)actView {
    
    if (_actView == nil) {
        _actView = [[YAActView alloc] initWithSuperView:self.view andFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)];
    }
    return _actView;
}

- (YATableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[YATableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end



