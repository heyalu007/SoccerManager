//
//  MatchForecastViewModel.m
//  SoccerManager
//
//  Created by ihandysoft on 16/1/4.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "MatchForecastViewModel.h"
#import "ForecastMatchModel.h"
#import "ForecastMatchDayModel.h"
#import "ForecastDataManager.h"
#import "AFNetworking.h"
#import "Util.h"

@interface MatchForecastViewModel ()

@property (copy, nonatomic) CallBack callBack;
@property (strong, nonatomic) NSError *error;

@end

@implementation MatchForecastViewModel

/**
 *  获取比赛信息
 */
- (void)MatchForecastInfo:(CallBack)callBack {
    
    self.callBack = callBack;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"20160101154308";
    params[@"appname"] = @"zhibo8";
    params[@"platform"] = @"ios";
    params[@"version_code"] = @"4.1.8.3";
    NSString *urlString = @"http://m.zhibo8.cc/json/zhibo/saishi.json";
    
    __weak typeof(self)weakSelf = self;
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 1.字典转模型
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            ForecastMatchDayModel *model = [ForecastMatchDayModel modelWithDict:dict];
            [array addObject:model];
        }
        // 2.写入数据库
        [[ForecastDataManager sharedInstance] clearTable];
        [[ForecastDataManager sharedInstance] insertIntoTableWithArray:array];
        // 3.回调
        callBack(array, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 1.如果失败了，再去数据库里面查询;
        weakSelf.error = error;
//        [weakSelf readImportMatchDataFromTable];//Review:为什么不能这么写？是因为等到回调的时候，self已经被销毁了；
        [[ForecastDataManager sharedInstance] readMatchDataFromTable:^(NSArray *importList) {
            
            if (importList == nil) {
                weakSelf.callBack(nil, _error);
            }
            else {
                importList = [weakSelf arrayWithArray:importList];
                weakSelf.callBack(importList, nil);
            }
        }];
    }];
}

- (NSArray<ForecastMatchDayModel *> *)arrayWithArray:(NSArray *)array {

    NSMutableArray *matchDayList = [NSMutableArray array];
    NSMutableArray *matchList = [NSMutableArray array];
    NSMutableArray *importantMatchList = [NSMutableArray array];
    ForecastMatchDayModel *dayModel = [[ForecastMatchDayModel alloc] init];
    dayModel.date = [array firstObject][@"date"];
    
    for (NSDictionary *dic in array) {
        
        ForecastMatchModel *matchModel = [[ForecastMatchModel alloc] init];
        matchModel.time = dic[@"time"];
        matchModel.home_team = dic[@"home_team"];
        matchModel.visit_team = dic[@"visit_team"];
        matchModel.title = dic[@"title"];
        matchModel.type = dic[@"type"];
        matchModel.home_logo = dic[@"home_logo"];
        matchModel.visit_logo = dic[@"visit_logo"];
        matchModel.isImportant = [dic[@"isImportant"] boolValue];
        if (matchModel.isImportant == YES) {
            [importantMatchList addObject:matchModel];
        }
        [matchList addObject:matchModel];
        
        if (![dayModel.date isEqualToString:dic[@"date"]]) {
            dayModel.matchList = [matchList copy];
            dayModel.importantMatchList = [importantMatchList copy];
            [matchDayList addObject:dayModel];
            [matchList removeAllObjects];
            [importantMatchList removeAllObjects];
            dayModel = [[ForecastMatchDayModel alloc] init];
            dayModel.date = dic[@"date"];
        }
        
    };
    return matchDayList;
}

- (void)readImportMatchDataFromTable {

    __weak typeof(self) weakSelf = self;
    [[ForecastDataManager sharedInstance] readMatchDataFromTable:^(NSArray *importList) {
        
        if (importList == nil) {
            weakSelf.callBack(nil, _error);
        }
        else {
            weakSelf.callBack(importList, nil);
        }
    }];
}



//http://m.zhibo8.cc/json/label/hot.jsonp?appname=zhibo8&platform=ios&version_code=4.1.8.3
//http://m.zhibo8.cc/json/hot/24hours.json?appname=zhibo8&platform=ios&version_code=4.1.8.3
//http://m.zhibo8.cc/activities/material/json.htm?appname=zhibo8&platform=ios&version_code=4.1.8.3
//http://m.zhibo8.cc/activities/ios.php?appname=zhibo8&platform=ios&version_code=4.1.8.3
//http://m.zhibo8.cc/json/label/attention.json?key=20151224191625&appname=zhibo8&platform=ios&version_code=4.1.8.3
//http://m.zhibo8.cc/json/zhibo/saishi.json?key=20151224191626&appname=zhibo8&platform=ios&version_code=4.1.8.3


@end
