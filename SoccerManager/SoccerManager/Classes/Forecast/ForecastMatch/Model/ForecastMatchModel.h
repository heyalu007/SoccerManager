//
//  ForecastMatchModel.h
//  SoccerManager
//
//  Created by 何亚鲁 on 15/12/27.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastMatchModel : NSObject

@property (copy, nonatomic)  NSString *time;//比赛时间;
//@property (copy, nonatomic)  NSString *content;//
@property (copy, nonatomic)  NSString *home_team;//主队名;
@property (copy, nonatomic)  NSString *visit_team;//客队名;
@property (copy, nonatomic)  NSString *title;//
@property (copy, nonatomic)  NSString *type;//
@property (copy, nonatomic)  NSString *home_logo;//主队队徽;
@property (copy, nonatomic)  NSString *visit_logo;//客队队徽;
@property (assign, nonatomic)  BOOL isImportant;//是否为重要比赛;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
