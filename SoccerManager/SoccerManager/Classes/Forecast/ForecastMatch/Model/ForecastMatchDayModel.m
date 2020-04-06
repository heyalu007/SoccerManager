//
//  ForecastMatchDayModel.m
//  SoccerManager
//
//  Created by ihandysoft on 15/12/28.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import "ForecastMatchModel.h"
#import "ForecastMatchDayModel.h"

@implementation ForecastMatchDayModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        self.date = dict[@"date"];
        [self listFromArray:dict[@"list"]];
    }
    return self;
}


- (void)listFromArray:(NSArray *)array {
    
    NSMutableArray *matchList = [NSMutableArray array];
    NSMutableArray *importList = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        ForecastMatchModel *matchModel = [ForecastMatchModel modelWithDict:dict];
        if ([matchModel.type isEqualToString:@"football"]) {
            [matchList addObject:matchModel];
            if (matchModel.isImportant == YES) {
                [importList addObject:matchModel];
            }
        }
    }
    self.matchList = matchList;//全部比赛数组;
    self.importantMatchList = importList;//重要比赛数组;
}


+ (instancetype)modelWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}


@end
