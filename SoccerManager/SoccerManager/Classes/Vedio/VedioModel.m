//
//  VedioModel.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/31.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "VedioModel.h"

@implementation VedioModel

- (instancetype)initWithDic:(NSDictionary *)dic {

    if (self = [super init]) {
        self.title = dic[@"title"];
        self.updatetime = dic[@"updatetime"];
        self.filename = dic[@"filename"];
    }
    return self;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic {

    return [[self alloc] initWithDic:dic];
}

@end
