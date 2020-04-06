//
//  RunLoopSource.h
//  SoccerManager
//
//  Created by ihandysoft on 16/1/23.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunLoopSource : NSObject {
    CFRunLoopSourceRef _runLoopSource;
}

- (id)initWithDelegate;
- (void)addToRunLoop:(NSRunLoop*)rLoop;
- (void)fireCommandsOnRunLoop:(CFRunLoopRef)runloop;

@end

// RunLoopContext is a container object used during registration of the input source.

@interface RunLoopContext : NSObject

- (id)initWithSource:(RunLoopSource*)src andLoop:(CFRunLoopRef)loop;

@end