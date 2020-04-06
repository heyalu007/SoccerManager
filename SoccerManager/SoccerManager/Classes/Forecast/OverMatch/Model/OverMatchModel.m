//
//  OverMatchModel.m
//  SoccerManager
//
//  Created by ihandysoft on 16/1/9.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "OverMatchModel.h"
#import "OverMatchHighlightsModel.h"
#import "OverMatchTeamsModel.h"
#import "OverMatchVideoModel.h"

@implementation OverMatchModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        if (dic[@"jijin"] != nil) {
            self.highlights = [OverMatchHighlightsModel modelWithDic:dic[@"jijin"]];
        }
        if (dic[@"teams"] != nil) {
            self.teams = [OverMatchTeamsModel modelWithDic:dic[@"teams"]];
        }
        if (dic[@"luxiang"] != nil) {
            self.vedio = [OverMatchVideoModel modelWithDic:dic[@"luxiang"]];
        }
        self.title = dic[@"title"];
    }
    return self;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic {
    
    return [[self alloc] initWithDic:dic];
}

@end
