//
//  NewsViewController.m
//  SoccerManager
//
//  Created by ihandysoft on 15/12/22.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsViewModel.h"
#import "YAActView.h"
#import "YATableView.h"
#import "NewModel.h"
#import "NewCell.h"
#import "Util.h"

@interface NewsViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, copy) NSArray<NewModel *> *newList;
@property (nonatomic, strong) YAActView *actView;
@property (nonatomic, strong) YATableView *tableView;
@property (nonatomic, strong) NewsViewModel *viewModel;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.actView startAnimating];
    [self queryNewsInfo];
}

- (void)queryNewsInfo {

    self.viewModel = [[NewsViewModel alloc] init];
    __weak typeof(self) weakSelf = self;
    [self.viewModel queryNewsInfo:^(NSArray *array, NSError *error) {
        if (error) {
            [weakSelf.actView stopAnimatingWithTitle:@"请检查您的网络!"];
        } else {
            [weakSelf.actView stopAnimatingWithTitle:nil];
            weakSelf.newList = array;
            [weakSelf.tableView reloadData];
        }
        [weakSelf.tableView stopPullDownRefresh];
    }];
    
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.newList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewCell *cell = [NewCell cellWithTableView:tableView];
    NewModel *newModel = [self.newList objectAtIndex:indexPath.row];
    [cell loadContent:newModel];
    return cell;
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
            [weakSelf queryNewsInfo];
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (NSArray *)newList {
    
    if (_newList == nil) {
        _newList = [NSArray array];
    }
    return _newList;
}


//http://m.zhibo8.cc/json/head/headlines.htm?appname=zhibo8&platform=ios&version_code=4.1.9.11

/*
 
 URL	http://stats.jpush.cn/v2/report
 Status	Complete
 Response Code	200 OK
 Protocol	HTTP/1.1
 Method	POST
 Kept Alive	No
 Content-Type	text/plain; charset=utf-8
 Client Address	/10.0.7.142
 Remote Address	stats.jpush.cn/183.232.29.248
 Timing
 Request Start Time	16-2-2 11:49:07
 Request End Time	16-2-2 11:49:08
 Response Start Time	16-2-2 11:49:08
 Response End Time	16-2-2 11:49:08
 Duration	561 ms
 DNS	466 ms
 Connect	45 ms
 SSL Handshake	-
 Request	0 ms
 Response	0 ms
 Latency	48 ms
 Speed	1.48 KB/s
 Response Speed	∞ KB/s
 Size
 Request Header	392 bytes
 Response Header	217 bytes
 Request	212 bytes
 Response	29 bytes
 Total	850 bytes
 Request Compression	20.0% (gzip)
 Response Compression	N/A (gzip)
 
 */

/*
 
 http://quanzi.zhibo8.cc/submit/post_topic.php
 Complete
 200 OK
 HTTP/1.1
 POST
 No
 text/html;charset=utf-8
 /10.0.7.142
 quanzi.zhibo8.cc/120.55.194.117
 
 16-2-2 12:43:09
 16-2-2 12:43:10
 16-2-2 12:43:10
 16-2-2 12:43:10
 672 ms
 141 ms
 33 ms
 -
 381 ms
 1 ms
 115 ms
 838.34 KB/s
 479.49 KB/s
 
 654 bytes
 378 bytes
 562.25 KB (575740 bytes)
 113 bytes
 563.36 KB (576885 bytes)
 -
 -20.2% (gzip)
 
 */


/*
 
 
 http://postback.aarki.net/appcontact/v1/event_params.json?sdk_version=4.8&app_sec_key=5SGj9Ii4eqrU8nC8wDtwQehQxzKq
 Complete
 200 OK
 HTTP/1.1
 POST
 Yes
 application/json
 /10.0.7.142
 postback.aarki.net/67.21.4.136
 
 16-2-2 12:44:47
 16-2-2 12:44:47
 16-2-2 12:44:47
 16-2-2 12:44:47
 230 ms
 -
 -
 -
 0 ms
 0 ms
 229 ms
 3.05 KB/s
 ∞ KB/s
 
 358 bytes
 244 bytes
 0 bytes
 117 bytes
 719 bytes
 -
 -7.3% (gzip)
 */
@end
