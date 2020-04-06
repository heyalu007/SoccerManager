//
//  PictureViewController.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/14.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "PictureViewController.h"
#import "AFNetworking.h"
#import "Util.h"
#import "YAActView.h"
#import "PictureModel.h"
#import "UIApplication+FindTopViewController.h"
#import "TestViewController.h"

@interface PictureViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, copy) NSArray<PictureModel *> *pictureModelList;
@property (nonatomic, strong) YAActView *actView;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation PictureViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self afnTest];
}


//http://m.tu.zhibo8.cc/?json&appname=zhibo8&platform=ios&version_code=4.1.9.11
//http://m.tu.zhibo8.cc/26980?json&appname=zhibo8&platform=ios&version_code=4.1.9.11
//http://m.tu.zhibo8.cc/zuqiu?json&num=1&appname=zhibo8&platform=ios&version_code=4.1.9.11
- (void)afnTest {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *params = @{@"appname"     : @"zhibo8",
                             @"platform"    : @"ios",
                             @"version_code": @"4.1.9.11"};
    NSString *urlString = @"http://m.tu.zhibo8.cc/?json";
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DebugLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIViewController *vc = [[UIApplication sharedApplication] getTopViewController];
    NSLog(@"%@", vc);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TestViewController *testVC = [[TestViewController alloc] init];
    [self presentViewController:testVC animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return self.matchDayList.count;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    ForecastMatchDayModel *matchDayModel = [self.matchDayList objectAtIndex:section];
//    return matchDayModel.matchList.count;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    /*
//     Review:
//     对于可变cell,不能用统一的ID,这样会导致cell的重用机制混乱,从而使得数据的显示混乱;
//     */
//    static NSString *ID;
//    ForecastMatchDayModel *matchDayModel = [self.matchDayList objectAtIndex:indexPath.section];
//    ForecastMatchModel *matchModel = [matchDayModel.matchList objectAtIndex:indexPath.row];
//    if (![matchModel.home_logo isEqualToString:@""] || ![matchModel.visit_logo isEqualToString:@""]) {
//        ID = @"HeightCell";
//    }
//    else {
//        ID = @"Cell";
//    }
//    MatchForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[MatchForecastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        //Review: 这里面写一些固定的配置，如cell的背景色、selectionStyle等;
//    }
//    [cell loadContent:matchModel];
//    return cell;
//}


//#pragma mark - UITableViewDelegate
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 30.0;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = RGBColor(236, 244, 254, 1.0);
//    
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 30)];
//    title.backgroundColor = [UIColor clearColor];
//    ForecastMatchDayModel *matchDayModel = [self.matchDayList objectAtIndex:section];
//    title.text = matchDayModel.date;
//    title.textColor = RGBColor(83, 109, 150, 1.0);
//    
//    [headerView addSubview:title];
//    return headerView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    ForecastMatchDayModel *dayModel = [self.matchDayList objectAtIndex:indexPath.section];
//    ForecastMatchModel *matchModel = [dayModel.matchList objectAtIndex:indexPath.row];
//    
//    CGFloat height = 60.0;
//    if (![matchModel.home_logo isEqualToString:@""] || ![matchModel.visit_logo isEqualToString:@""]) {
//        height = 80.0;
//    }
//    return height;
//}
//
//
//
//-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row) {
//        dispatch_async(dispatch_get_main_queue(),^{
//            [self.actView stopAnimatingWithTitle:nil];
//        });
//    }
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    //    [self.navigationController pushViewController:vc animated:YES];
//}
//
//
//#pragma mark - 懒加载
//
//- (YAActView *)actView {
//    
//    if (_actView == nil) {
//        _actView = [[YAActView alloc] initWithSuperView:self.view andFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)];
//    }
//    return _actView;
//}
//
//
//- (UITableView *)tableView {
//    
//    if (_tableView == nil) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        [self.view addSubview:_tableView];
//    }
//    return _tableView;
//}
//
//
//- (NSArray *)matchDayList {
//    
//    if (_matchDayList == nil) {
//        _matchDayList = [NSArray array];
//    }
//    return _matchDayList;
//}

@end


