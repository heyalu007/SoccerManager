//
//  RunLoopThread.h
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/28.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^onWorkThread)(void);

@interface RunLoopThread : NSObject

- (void)runUntilDone:(BOOL)wait bodyBlock:(onWorkThread)bodyBlock;

@end
