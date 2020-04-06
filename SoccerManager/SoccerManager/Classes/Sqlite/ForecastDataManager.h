//
//  ForecastDataManager.h
//  SoccerManager
//
//  Created by ihandysoft on 16/1/23.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ForecastMatchDayModel;

typedef void(^callBack)(NSArray *importList);

@interface ForecastDataManager : NSObject

+ (instancetype)sharedInstance;
- (void)insertIntoTableWithArray:(NSArray<ForecastMatchDayModel *> *)array;
- (void)clearTable;
- (void)readMatchDataFromTable:(callBack)callBack;

@end
