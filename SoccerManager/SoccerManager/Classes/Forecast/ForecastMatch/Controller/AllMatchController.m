//
//  AllMatchController.m
//  SoccerManager
//
//  Created by 何亚鲁 on 15/12/26.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import "AllMatchController.h"
#import "YAActView.h"
#import "ForecastMatchDayModel.h"
#import "Util.h"
#import "MatchForecastViewModel.h"
#import "MatchForecastCell.h"
#import "ForecastMatchModel.h"
#import "ImportantMatchController.h"
#import "YATableView.h"


#import "YACallableCenter.h"

@interface AllMatchController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, copy) NSArray <ForecastMatchDayModel *> *matchDayList;
@property (nonatomic, strong) YAActView *actView;
@property (nonatomic, strong) YATableView *tableView;
@property (nonatomic, strong) MatchForecastViewModel *viewModel;

@end

@implementation AllMatchController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.actView startAnimating];
    [self loadAllMatchInfo];
}

- (void)loadAllMatchInfo {
    __weak typeof(self) weakSelf = self;
    [self.viewModel MatchForecastInfo:^(NSArray *array, NSError *error) {
        if (error) {
            [weakSelf.actView stopAnimatingWithTitle:@"网络请求失败"];
        }
        else {
            weakSelf.matchDayList = array;
            [weakSelf.tableView reloadData];
        }
        [weakSelf.tableView stopPullDownRefresh];
    }];
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSArray *array = [[YACallableCenter defaultCenter] getEach:@"heyalu" data:nil];
    DebugLog(@"%@",array);
    
    [[YACallableCenter defaultCenter] addCallable:^id(id data) {
        return @"54321";
    } tag:@"heyalu"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.matchDayList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ForecastMatchDayModel *matchDayModel = [self.matchDayList objectAtIndex:section];
    return matchDayModel.matchList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     Review:
     对于可变cell,不能用统一的ID,这样会导致cell的重用机制混乱,从而使得数据的显示混乱;
     */
    static NSString *ID;
    ForecastMatchDayModel *matchDayModel = [self.matchDayList objectAtIndex:indexPath.section];
    ForecastMatchModel *matchModel = [matchDayModel.matchList objectAtIndex:indexPath.row];
    if (![matchModel.home_logo isEqualToString:@""] || ![matchModel.visit_logo isEqualToString:@""]) {
        ID = @"HeightCell";
    }
    else {
        ID = @"Cell";
    }
    MatchForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MatchForecastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //Review: 这里面写一些固定的配置，如cell的背景色、selectionStyle等;
    }
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
    ForecastMatchDayModel *matchDayModel = [self.matchDayList objectAtIndex:section];
    title.text = matchDayModel.date;
    title.textColor = RGBColor(83, 109, 150, 1.0);
    
    [headerView addSubview:title];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ForecastMatchDayModel *dayModel = [self.matchDayList objectAtIndex:indexPath.section];
    ForecastMatchModel *matchModel = [dayModel.matchList objectAtIndex:indexPath.row];
    
    CGFloat height = 60.0;
    if (![matchModel.home_logo isEqualToString:@""] || ![matchModel.visit_logo isEqualToString:@""]) {
        height = 80.0;
    }
    return height;
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

- (YAActView *)actView {
    
    if (_actView == nil) {
        _actView = [[YAActView alloc] initWithSuperView:self.view andFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)];
    }
    return _actView;
}


- (YATableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[YATableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
        __weak typeof(self) weakSelf = self;
        [_tableView setPullDownRefresh:^{
            [weakSelf loadAllMatchInfo];
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (NSArray *)matchDayList {
    
    if (_matchDayList == nil) {
        _matchDayList = [NSArray array];
    }
    return _matchDayList;
}

- (MatchForecastViewModel *)viewModel {

    if (_viewModel == nil) {
        _viewModel = [[MatchForecastViewModel alloc] init];
    }
    return _viewModel;
}

@end
