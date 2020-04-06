//
//  OverMatchDayModel.h
//  SoccerManager
//
//  Created by ihandysoft on 16/1/9.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OverMatchModel;

@interface OverMatchDayModel : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *date_str;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray <OverMatchModel *> *matchList;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)modelWithDic:(NSDictionary *)dic;

@end
