//
//  LoopThreadBody.h
//  SoccerManager
//
//  Created by ihandysoft on 16/1/23.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoopThread.h"

@interface LoopThreadBody : NSObject

- (void)runUntilDone:(BOOL)wait bodyBlock:(onWorkThread)bodyBlock;
- (void)stop;
- (void)waitALoop;

@end
