//
//  ImportantMatchController.m
//  SoccerManager
//
//  Created by 何亚鲁 on 15/12/26.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import "ImportantMatchController.h"
#import "AFNetworking.h"
#import "Util.h"
#import "YAActView.h"
#import "YATableView.h"
#import "MatchForecastCell.h"
#import "ForecastMatchDayModel.h"
#import "ForecastMatchModel.h"
#import "MatchForecastViewModel.h"
#import "MJRefresh.h"


#import "YACallableCenter.h"

@interface ImportantMatchController ()
<
UITableViewDelegate,
UITableViewDataSource
>


@property (nonatomic, copy) YAActView *actView;
@property (nonatomic, strong) YATableView *tableView;

@end

@implementation ImportantMatchController

//static NSString *ID = @"importMatchCell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    [self.tableView registerClass:[MatchForecastCell class] forCellReuseIdentifier:ID];
    [self.actView startAnimating];
    [self queryImportantMatchInfo];
}

- (void)queryImportantMatchInfo {

    MatchForecastViewModel *viewModel = [[MatchForecastViewModel alloc] init];
    __weak typeof(self) weakSelf = self;
    [viewModel MatchForecastInfo:^(NSArray *array, NSError *error) {
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



-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [[YACallableCenter defaultCenter] addCallable:^id(id data) {
        return @"12345";
    } tag:@"heyalu"];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.matchDayList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ForecastMatchDayModel *matchDayModel = [self.matchDayList objectAtIndex:section];
    
    return matchDayModel.importantMatchList.count;
}

//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    ForecastMatchDayModel *matchDayModel = [self.matchDayList objectAtIndex:section];
//    return matchDayModel.date;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    MatchForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    /*
     Review:
     注册了之后,上面的一句等于下面这三句;
     */
    NSString *ID = @"cell";
     MatchForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
     if (cell == nil) {
         cell = [[MatchForecastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
     }
    
    ForecastMatchDayModel *matchDayModel = [self.matchDayList objectAtIndex:indexPath.section];
    ForecastMatchModel *matchModel = [matchDayModel.importantMatchList objectAtIndex:indexPath.row];
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

- (YAActView *)actView {
    
    if (_actView == nil) {
        _actView = [[YAActView alloc] initWithSuperView:self.view andFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)];
    }
    return _actView;
}


- (YATableView *)tableView {

    if (_tableView == nil) {
        _tableView = [[YATableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49 - 44) style:UITableViewStylePlain];
        
        __weak typeof(self) weakSelf = self;
        [_tableView setPullDownRefresh:^{
            [weakSelf queryImportantMatchInfo];
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


@end
