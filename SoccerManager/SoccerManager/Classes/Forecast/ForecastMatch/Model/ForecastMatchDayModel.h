//
//  ForecastMatchDayModel.h
//  SoccerManager
//
//  Created by ihandysoft on 15/12/28.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ForecastMatchDayModel : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, strong) NSArray *matchList;
@property (nonatomic, strong) NSArray *importantMatchList;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end