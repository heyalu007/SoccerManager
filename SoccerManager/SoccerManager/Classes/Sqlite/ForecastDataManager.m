//
//  ForecastDataManager.m
//  SoccerManager
//
//  Created by ihandysoft on 16/1/23.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "ForecastDataManager.h"
#import "SqliteOperator.h"
#import "ForecastMatchDayModel.h"
#import "ForecastMatchModel.h"

@interface ForecastDataManager ()

@property (nonatomic, strong) dispatch_queue_t serialQueue;

@end


@implementation ForecastDataManager

/*
 Review:
 instancetype和id的不同点:
 instancetype可以返回和方法所在类相同类型的对象，id只能返回未知类型的对象；
 instancetype只能作为返回值，不能像id那样作为参数；
 
 只要一个方法返回的是它所在的类的自身的实例，用instancetype就有好处；
 instancetype的作用就是使那些非关联返回类型的方法返回所在类的类型；
 
*/

+ (instancetype)sharedInstance {

    static ForecastDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ForecastDataManager alloc] init];
    });
    return manager;
}

- (instancetype)init {

    if (self = [super init]) {
        _serialQueue = dispatch_queue_create([[NSString stringWithFormat:@"com.%@.soccerManager", [self class]] UTF8String], 0);
        
        NSMutableArray *cmds = [NSMutableArray array];
        NSString *creatMatchForecastTable = @"create table if not exists t_match_forecast (id integer primary key, date text, time text, home_team text, visit_team text, title text, type text, home_logo text, visit_logo text, isImportant integer);";
        [cmds addObject:creatMatchForecastTable];
        [[SqliteOperator sharedInstance] executeSqliteWithCommands:cmds waitUntilDone:YES];
    }
    return self;
}

- (void)insertIntoTableWithArray:(NSArray<ForecastMatchDayModel *> *)array {

    if (array.count <= 0) {
        return;
    }
    
    dispatch_async(self.serialQueue, ^{
        
        NSMutableArray *cmdArray = [NSMutableArray array];
        
        for (ForecastMatchDayModel *dayModel in array) {
            for (ForecastMatchModel *matchModel in dayModel.matchList) {
                
                NSString *cmdStr = nil;
                NSString *colums = @"";//Review:这里是空字符串，而不是nil，一定要注意；
                NSString *values = @"";
                
                colums = [colums stringByAppendingString:@"date"];
                values = [values stringByAppendingFormat:@"'%@'",dayModel.date];
                
                colums = [colums stringByAppendingString:@", time"];
                values = [values stringByAppendingFormat:@", '%@'",matchModel.time];
                
                colums = [colums stringByAppendingString:@", home_team"];
                values = [values stringByAppendingFormat:@", '%@'",matchModel.home_team];
                
                colums = [colums stringByAppendingString:@", visit_team"];
                values = [values stringByAppendingFormat:@", '%@'",matchModel.visit_team];
                
                colums = [colums stringByAppendingString:@", title"];
                values = [values stringByAppendingFormat:@", '%@'",matchModel.title];
                
                colums = [colums stringByAppendingString:@", type"];
                values = [values stringByAppendingFormat:@", '%@'",matchModel.type];
                
                colums = [colums stringByAppendingString:@", home_logo"];
                values = [values stringByAppendingFormat:@", '%@'",matchModel.home_logo];
                
                colums = [colums stringByAppendingString:@", visit_logo"];
                values = [values stringByAppendingFormat:@", '%@'",matchModel.visit_logo];
                
                colums = [colums stringByAppendingString:@", isImportant"];
                values = [values stringByAppendingFormat:@", %d",matchModel.isImportant];
                
                cmdStr = [NSString stringWithFormat:@"insert or replace into t_match_forecast(%@) values(%@);", colums, values];
                [cmdArray addObject:cmdStr];
            }
        }
        [[SqliteOperator sharedInstance] executeSqliteWithCommands:cmdArray waitUntilDone:NO];
    });
}

/**
 *  清空表
 */
- (void)clearTable {

    dispatch_async(self.serialQueue, ^{
        NSMutableArray *cmdArray = [NSMutableArray array];
        NSString *cmd = @"delete from t_match_forecast;";
        [cmdArray addObject:cmd];
        [[SqliteOperator sharedInstance] executeSqliteWithCommands:cmdArray waitUntilDone:YES];
    });
}

- (void)readMatchDataFromTable:(callBack)callBack {

    dispatch_async(self.serialQueue, ^{

//        NSString *cmd = @"select * from t_match_forecast where isImportant = 1;";
        NSString *cmd = @"select * from t_match_forecast;";
        NSArray *importList = [[SqliteOperator sharedInstance] selectFromSqliteWithCommandString:cmd];
        dispatch_async(dispatch_get_main_queue(), ^{
            callBack(importList);
        });
    });
}


@end
