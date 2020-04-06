//
//  RunLoopThread.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/28.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "RunLoopThread.h"
#import "RunLoopSource.h"

@interface RunLoopThread ()

@property (nonatomic, strong) NSThread *workThread;

@end

@implementation RunLoopThread

- (instancetype)init {
    if (self = [super init]) {
        [self start];
    }
    return self;
}

- (void)start {
    NSThread * tempThread = [[NSThread alloc] initWithTarget:self selector:@selector(prepareEnvironment) object:nil];
    self.workThread = tempThread;
    [self.workThread start];
}

- (void)prepareEnvironment {
    RunLoopSource * runLoopSource = [[RunLoopSource alloc] initWithDelegate];
    [runLoopSource addToRunLoop:[NSRunLoop currentRunLoop]];
    
    /*
     Review:
     RunLoop启动前内部必须要有至少一个Timer/Observer/Source,没有的话会自动结束;
     */
    
    while (![NSThread currentThread].isCancelled) {
        @autoreleasepool {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }
    /*
     Review:
     distantFuture   （不可达到的未来的某个时间点）
     distantPast     （不可达到的过去的某个时间点)
     */
}



- (void)executeOnWorkThread:(onWorkThread)bodyBlock {
        bodyBlock();
}


- (void)runUntilDone:(BOOL)wait bodyBlock:(onWorkThread)bodyBlock {
    if (self.workThread != nil && ![self.workThread isEqual:[NSThread currentThread]]) {
        [self performSelector:@selector(executeOnWorkThread:) onThread:self.workThread withObject:bodyBlock waitUntilDone:wait];
    }
    else {
        [self executeOnWorkThread:bodyBlock];
    }
}




- (void)stop {
    [self performSelector:@selector(cancelThread) onThread:self.workThread withObject:nil waitUntilDone:YES];
    self.workThread = nil;
}

- (void)cancelThread {
    [self.workThread cancel];
}

- (void)dealloc {
    [self stop];
}

@end
