//
//  NewsViewModel.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/2/2.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "NewsViewModel.h"
#import "NewModel.h"
#import "AFNetworking.h"
#import "Util.h"
#import "YYModel.h"
#import "MJExtension.h"

@implementation NewsViewModel


- (void)queryNewsInfo:(CallBack)callBack {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = ({
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"key"] = @"1454413756";
        dic[@"appname"] = @"zhibo8";
        dic[@"platform"] = @"ios";
        dic[@"version_code"] = @"4.1.9.11";
        //        [NSDictionary dictionaryWithDictionary:params];
        dic;//Review:默认返回最后一行代码的值；
    });
    
    NSString *urlString = ({
        NSDate *date = [NSDate date];
        NSString *dateString = [self stringFromDate:date];
        [NSString stringWithFormat:@"http://m.zhibo8.cc/json/news/zuqiu/%@.json",dateString];
    });
    
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = [NewModel objectArrayWithKeyValuesArray:responseObject[@"video_arr"]];
        if (array != nil) {
            callBack(array, nil);
        } else {
            NSError *error = [[NSError alloc] init];
            callBack(nil, error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callBack(nil, error);
    }];
}

- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}


@end
