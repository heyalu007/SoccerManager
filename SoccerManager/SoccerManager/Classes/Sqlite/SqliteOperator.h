//
//  SqliteOperator.h
//  SoccerManager
//
//  Created by ihandysoft on 16/1/24.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kExecuteSqliteCommandsFinish;

@interface SqliteOperator : NSOperation

+ (instancetype)sharedInstance;
- (void)executeSqliteWithCommands:(NSArray *)cmdStrings waitUntilDone:(BOOL)wait;
- (void)deleteFromSqliteWithCommands:(NSArray *)cmdStrings waitUntilDone:(BOOL)wait;
- (NSArray *)selectFromSqliteWithCommandString:(NSString *)cmdString;

//- (void)executeSqliteCommands:(NSArray *)cmdStrings;
//- (void)executeSqliteCommand:(NSString *)cmdString;

@end
