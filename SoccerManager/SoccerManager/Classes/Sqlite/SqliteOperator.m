//
//  SqliteOperator.m
//  SoccerManager
//
//  Created by ihandysoft on 16/1/24.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "SqliteOperator.h"
#import <sqlite3.h>
#import "RunLoopThread.h"
#import "Util.h"

@interface SqliteOperator ()

@property (nonatomic, strong) NSArray *createTablesCommandStr;
@property (nonatomic, strong) RunLoopThread *loopThread;
@property (nonatomic, assign) sqlite3 *sqliteDB;

@end

NSString * const kExecuteSqliteCommandsFinish = @"ExecuteSqliteCommandsFinish";

@implementation SqliteOperator


+ (instancetype)sharedInstance {

    static SqliteOperator *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[SqliteOperator alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {

    if (self = [super init]) {
        self.loopThread = [[RunLoopThread alloc] init];
        [self createDB];
        [self createTable];
    }
    return self;
}



- (void)userWillLogout:(NSNotification *)notification {
    //主线程接受logout通知，需要同步切换到子线程关闭数据库
    [self.loopThread runUntilDone:YES bodyBlock:^{
        [self closeSqlite:self.sqliteDB];
        self.loopThread = nil;
    }];
}


/**
 *  创建数据库
 */
- (void)createDB {

    // 1.获取数据库的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths lastObject];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:@"SoccerManager.sqlite"];
    DebugLog(@"%@",dbPath);
    
    // 2.打开数据库（如果没有数据库，会创建一个）
    sqlite3 *sqliteDB;
    int result = sqlite3_open([dbPath UTF8String], &sqliteDB);
    if (result == SQLITE_OK) {
        self.sqliteDB = sqliteDB;
    }
    else {
        sqlite3_close(sqliteDB);
        self.sqliteDB = nil;
        DebugLog(@"create sqlite failed!");
    }
}

/**
 *  建表，如果需要建多个表，都写在这个里面；
 */
- (void)createTable {

    if (self.sqliteDB == nil) return;
    
    NSMutableArray *cmds = [NSMutableArray array];
    
    NSString *creatTestTable = @"create table if not exists t_test (id integer primary key, name text, age integer, height real);";
    [cmds addObject:creatTestTable];
    
    for (NSString * cmd in cmds) {
        sqlite3_exec(self.sqliteDB, [cmd UTF8String], NULL, NULL, NULL);
    }
}


/**
 *  执行单条数据库语句
 */
- (void)executeSqliteCommand:(NSString *)cmdString {
    
    if (self.sqliteDB == nil) return;

    sqlite3_exec(self.sqliteDB, [cmdString UTF8String], NULL, NULL, NULL);
}

/**
 *  执行多条数据库语句
 */
- (void)executeSqliteCommands:(NSArray *)cmdStrings {
    
    if (self.sqliteDB == nil) return;
    
    @synchronized(self) {
        @try {
            if(sqlite3_exec(self.sqliteDB, "BEGIN", NULL, NULL, NULL) == SQLITE_OK)
            {
                for (NSString *sqlStr in cmdStrings) {
                    [self executeSqliteCommand:sqlStr];
                }
                sqlite3_exec(self.sqliteDB, "COMMIT", NULL, NULL, NULL);
            }
        }
        @catch (NSException *exception) {
            sqlite3_exec(self.sqliteDB, "ROLLBACK", NULL, NULL, NULL);
        }
    }
}

/**
 *  从数据库读取数据
 */
- (NSArray *)selectFromSqliteWithCommandString:(NSString *)cmdString { 

    if (self.sqliteDB == nil) return nil;
    
    NSMutableArray *resultVal = [NSMutableArray array];
    @synchronized(self) {
        NSString *selectSqlStr = cmdString;
        sqlite3_stmt *statment;
        int sqlretcode = sqlite3_prepare_v2(self.sqliteDB, [selectSqlStr UTF8String], -1, &statment, nil);
        if (sqlretcode == SQLITE_OK) {
            while (sqlite3_step(statment) == SQLITE_ROW) {
                int colscount = sqlite3_column_count(statment);//查询结果包含列数
                NSMutableDictionary *subData = [NSMutableDictionary dictionary];
                for (int i=0; i<colscount; ++i) {
                    const char* columndata = sqlite3_column_name(statment, i);
                    NSString *columnNameStr = [[NSString alloc] initWithUTF8String:columndata];//取出对应列名
                    const unsigned char *rowdata = sqlite3_column_text(statment, i);//取出对应列值
                    if (rowdata != NULL) {
                        NSString *val = [[NSString alloc] initWithUTF8String:(const char*)rowdata];
                        [subData setObject:val forKey:columnNameStr];
                    }
                    else{
                        [subData setObject:@"" forKey:columnNameStr];
                    }
                }
                [resultVal addObject:subData];//一行完整统计结果
            }
            sqlite3_finalize(statment);
        }
        else
        {
            DebugLog(@"error:%d",sqlretcode);
        }
    }
    return resultVal;
}


- (void)executeSqliteWithCommands:(NSArray *)cmdStrings waitUntilDone:(BOOL)wait {
    
    if (self.sqliteDB == nil) return;
    
    [self.loopThread runUntilDone:wait bodyBlock:^{
        [self executeSqliteCommands:cmdStrings];
        dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kExecuteSqliteCommandsFinish object:nil userInfo:nil];
        });
    }];
}


- (void)deleteFromSqliteWithCommands:(NSArray *)cmdStrings waitUntilDone:(BOOL)wait {
    
    if (self.sqliteDB == nil) return;
    
    [self.loopThread runUntilDone:wait bodyBlock:^{
        [self executeSqliteCommands:cmdStrings];
    }];
}

- (int)closeSqlite:(sqlite3 *)sqlite3DB{
    if (sqlite3DB) {
        return sqlite3_close(sqlite3DB);
    }
    return SQLITE_ERROR;
}

@end
