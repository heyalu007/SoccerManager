//
//  LoopThread.h
//  SoccerManager
//
//  Created by ihandysoft on 16/1/23.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^onWorkThread)(void);

@interface LoopThread : NSObject

- (void)runUntilDone:(BOOL)wait bodyBlock:(onWorkThread)bodyBlock;

@end
