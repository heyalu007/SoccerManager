//
//  OverMatchTeamsModel.h
//  SoccerManager
//
//  Created by ihandysoft on 16/1/9.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OverMatchTeamsModel : NSObject

@property (nonatomic, copy) NSString *host;
@property (nonatomic, copy) NSString *host_logo;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *visit;
@property (nonatomic, copy) NSString *visit_logo;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)modelWithDic:(NSDictionary *)dic;

@end
