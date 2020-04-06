//
//  OverMatchModel.h
//  SoccerManager
//
//  Created by ihandysoft on 16/1/9.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OverMatchHighlightsModel;
@class OverMatchVideoModel;
@class OverMatchTeamsModel;

@interface OverMatchModel : NSObject

@property (nonatomic, strong) OverMatchHighlightsModel *highlights;
@property (nonatomic, strong) OverMatchVideoModel *vedio;
@property (nonatomic, strong) OverMatchTeamsModel *teams;
@property (nonatomic, copy) NSString *title;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)modelWithDic:(NSDictionary *)dic;

@end
