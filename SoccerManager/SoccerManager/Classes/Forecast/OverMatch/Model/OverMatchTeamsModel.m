//
//  OverMatchTeamsModel.m
//  SoccerManager
//
//  Created by ihandysoft on 16/1/9.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "OverMatchTeamsModel.h"

@implementation OverMatchTeamsModel

- (instancetype)initWithDic:(NSDictionary *)dic {

    if (self = [super init]) {
        self.host = dic[@"host"];
        self.host_logo = dic[@"host_logo"];
        self.score = dic[@"score"];
        self.visit = dic[@"visit"];
        self.visit_logo = dic[@"visit_logo"];
    }
    return self;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic {

    return [[self alloc] initWithDic:dic];
}

@end
