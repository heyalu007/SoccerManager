//
//  OverMatchDayModel.m
//  SoccerManager
//
//  Created by ihandysoft on 16/1/9.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "OverMatchDayModel.h"
#import "OverMatchModel.h"

@implementation OverMatchDayModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        self.date = dic[@"date"];
        self.date_str = dic[@"date_str"];
        self.title = dic[@"title"];
        self.matchList = [self matchList:dic[@"match_arr"]];
    }
    return self;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic {
    
    return [[self alloc] initWithDic:dic];
}

- (NSArray *)matchList:(NSArray *)array {

    NSMutableArray *matchList = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        OverMatchModel *model = [OverMatchModel modelWithDic:dic];
        [matchList addObject:model];
    }
    return matchList;
}

@end
