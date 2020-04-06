//
//  RunLoopSource.m
//  SoccerManager
//
//  Created by ihandysoft on 16/1/23.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunLoopSource.h"

void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
}

void RunLoopSourcePerformRoutine (void *info)
{
}

void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
}

@implementation RunLoopSource

- (instancetype)initWithDelegate {
    CFRunLoopSourceContext context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL,
        &RunLoopSourceScheduleRoutine,
        RunLoopSourceCancelRoutine,
        RunLoopSourcePerformRoutine};
    
    _runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);
    return self;
}


- (void)addToRunLoop:(NSRunLoop *)rLoop {
    CFRunLoopRef runLoop = [rLoop getCFRunLoop];
    CFRunLoopAddSource(runLoop, _runLoopSource, kCFRunLoopDefaultMode);
}


- (void)fireCommandsOnRunLoop:(CFRunLoopRef)runloop {
    CFRunLoopSourceSignal(_runLoopSource);
    CFRunLoopWakeUp(runloop);
}

@end


@interface RunLoopContext ()

@property (readonly) CFRunLoopRef runLoop;
@property (weak, readonly) RunLoopSource *source;

/*
Review:
retain,让对象的引用计数器加1;
只能用于OC对象，不能用于CF对象(原因很明显，retain会增加对象的引用计数，基本数据类型或者CF对象都没有引用计数)；
*/

@end


@implementation RunLoopContext

- (id)initWithSource:(RunLoopSource *)src andLoop:(CFRunLoopRef)loop {
    self = [super init];
    _runLoop = loop;
    _source = src;
    return self;
}

@end
