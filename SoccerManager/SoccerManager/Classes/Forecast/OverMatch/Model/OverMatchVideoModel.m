//
//  OverMatchVideoModel.m
//  SoccerManager
//
//  Created by ihandysoft on 16/1/9.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "OverMatchVideoModel.h"

@implementation OverMatchVideoModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        self.title = dic[@"title"];
    }
    return self;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic {
    
    return [[self alloc] initWithDic:dic];
}

@end
