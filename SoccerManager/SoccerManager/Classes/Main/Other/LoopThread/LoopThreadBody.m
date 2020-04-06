//
//  LoopThreadBody.m
//  SoccerManager
//
//  Created by ihandysoft on 16/1/23.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "LoopThreadBody.h"
#import "RunLoopSource.h"

@interface LoopThreadBody ()

@property (nonatomic, strong) NSThread * workThread;
@property (nonatomic, assign) BOOL isCancelled;

@end

@implementation LoopThreadBody

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
    self.isCancelled = NO;
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

- (void)cancelThread {
    [self.workThread cancel];
    self.isCancelled = YES;
}

- (void)stop {
    [self performSelector:@selector(cancelThread) onThread:self.workThread withObject:nil waitUntilDone:YES];
    self.workThread = nil;
}

- (void)executeOnWorkThread:(onWorkThread)bodyBlock {
    if (!self.isCancelled) {
        bodyBlock();
    }
}


- (void)runUntilDone:(BOOL)wait bodyBlock:(onWorkThread)bodyBlock {
    if (self.workThread != nil && ![self.workThread isEqual:[NSThread currentThread]]) {
        [self performSelector:@selector(executeOnWorkThread:) onThread:self.workThread withObject:bodyBlock waitUntilDone:wait];
    }
    else {
        [self executeOnWorkThread:bodyBlock];
    }
}

- (void)waitALoop {
    if (self.workThread != nil && ![[NSThread currentThread] isEqual:self.workThread]) {
        [self performSelector:@selector(changeThread) onThread:self.workThread withObject:nil waitUntilDone:YES];
    }
}

- (void)changeThread {
}


@end
