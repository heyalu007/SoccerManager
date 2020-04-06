//
//  VedioViewModel.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/31.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "VedioViewModel.h"
#import "AFNetworking.h"
#import "VedioModel.h"
#import "Util.h"

@implementation VedioViewModel

- (void)queryVedioInfo:(CallBack)callBack {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = ({
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"key"] = @"20160204131207";
        dic[@"appname"] = @"zhibo8";
        dic[@"platform"] = @"ios";
        dic[@"version_code"] = @"4.1.8.3";
//        [NSDictionary dictionaryWithDictionary:params];
        dic;//Review:默认返回最后一行代码的值；
    });
    
    NSString *urlString = ({
        NSDate *date = [NSDate date];
        NSString *dateString = [self stringFromDate:date];
        [NSString stringWithFormat:@"http://m.zhibo8.cc/json/video/zuqiu/%@.json",dateString];
    });
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"video_arr"]) {
            VedioModel *vedioModel = [VedioModel modelWithDic:dic];
            [array addObject:vedioModel];
        }
        callBack(array, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callBack(nil, error);
    }];
   
}

- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

@end
