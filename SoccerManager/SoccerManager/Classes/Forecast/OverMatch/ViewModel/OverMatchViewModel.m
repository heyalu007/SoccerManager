//
//  OverMatchViewModel.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/8.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "OverMatchViewModel.h"
#import "AFNetworking.h"
#import "Util.h"
#import "OverMatchDayModel.h"

@interface OverMatchViewModel ()

@property (nonatomic, strong) NSMutableArray <OverMatchDayModel *> *matchList;
//@property (nonatomic, assign) NSInteger responseCount;
//Review:block中不可以直接调用self.responseCount,在里面打印为nil;
@property (nonatomic, copy) CallBack callBack;
@property (nonatomic, strong) NSDate *date;

@end

#define kOneDayForward (-24 * 60 * 60.0)

@implementation OverMatchViewModel

//__block int responseCount;//Review:__block不可以修饰全局变量,只能修饰局部变量;
static int responseCount;

- (instancetype)init {

    if (self = [super init]) {
        self.date = [NSDate date];
    }
    return self;
}

- (void)overMatchInfo:(CallBack)callBack {

    self.callBack = callBack;
    [self queryMatchInfoWithDate:self.date];
}


- (void)queryMatchInfoWithDate:(NSDate *)Date {

    if (responseCount >= 3) {
        responseCount = 0;
        self.date = [self.date dateByAddingTimeInterval:kOneDayForward];//把时间往前推一天;
        self.callBack(self.matchList, nil);
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"20160101154308";
    params[@"appname"] = @"zhibo8";
    params[@"platform"] = @"ios";
    params[@"version_code"] = @"4.1.8.3";
    NSString *dateString = [self stringFromDate:Date];
    NSString *urlString = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/video/bisai/zuqiu/%@.json",dateString];
    __weak typeof(self) weakSelf = self;
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        OverMatchDayModel *model = [OverMatchDayModel modelWithDic:responseObject];
        [weakSelf.matchList addObject:model];
        
        responseCount ++;//使用递归法连续3次获取网络请求;
        weakSelf.date = [weakSelf.date dateByAddingTimeInterval:kOneDayForward];//把时间往前推一天;
        [weakSelf queryMatchInfoWithDate:weakSelf.date];//根据日期发http请求获取数据;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseCount = 0;
        if(weakSelf.callBack) {
            weakSelf.callBack(nil, error);
        }
    }];
}


/**
 *  把NSdate转换为字符串
 *
 *  @param date 日期
 *
 *  @return 日期字符串,只保留了年月日
 */
- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

#pragma mark - 懒加载

- (NSMutableArray<OverMatchDayModel *> *)matchList {

    if (_matchList == nil) {
        _matchList = [NSMutableArray array];
    }
    return _matchList;
}

@end
