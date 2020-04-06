//
//  LoopThread.m
//  SoccerManager
//
//  Created by ihandysoft on 16/1/23.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "LoopThread.h"
#import "LoopThreadBody.h"
#import "RunLoopSource.h"

@interface LoopThread ()

@property (nonatomic, strong) LoopThreadBody *loopThreadBody;

@end

@implementation LoopThread

- (id)init {
    if (self = [super init]) {
        LoopThreadBody * tempBody = [[LoopThreadBody alloc] init];
        self.loopThreadBody = tempBody;
    }
    return self;
}

- (void)dealloc {
    [self.loopThreadBody stop];
}

- (void)runUntilDone:(BOOL)wait bodyBlock:(onWorkThread)bodyBlock {
    [self.loopThreadBody runUntilDone:wait bodyBlock:bodyBlock];
}

- (void)waitALoop {
    [self.loopThreadBody waitALoop];
}

@end


/*
 
 Review:
 一般来讲，一个线程一次只能执行一个任务，执行完成后线程就会退出。如果我们需要一个机制，让线程能随时处理事件但并不退出，就需要runloop；
 RunLoop实际上就是一个对象，这个对象管理了其需要处理的事件和消息；
 iOS系统中，提供了两个这样的对象：NSRunLoop 和 CFRunLoopRef；
 CFRunLoopRef 是在 CoreFoundation 框架内的，它提供了纯 C 函数的 API，所有这些 API 都是线程安全的；
 NSRunLoop 是基于 CFRunLoopRef 的封装，提供了面向对象的 API，但是这些 API 不是线程安全的；
 
 线程和 RunLoop 之间是一一对应的，其关系是保存在一个全局的 Dictionary 里。线程刚创建时并没有 RunLoop，如果你不主动获取，那它一直都不会有。RunLoop 的创建是发生在第一次获取时，RunLoop 的销毁是发生在线程结束时。你只能在一个线程的内部获取其 RunLoop（主线程除外）；
 
 RunLoop监视操作系统的输入源，如果没有事件数据， 不消耗任何CPU 资源；
 
 4种使用runloop的场合：
 1.使用端口或自定义输入源和其他线程通信；
 2.子线程中使用了定时器；
 3.cocoa中使用任何performSelector到了线程中运行方法；
 4.使线程履行周期性任务，（我把这个理解与2相同）；
 如果我们在子线程中用了NSURLConnection异步请求，那也需要用到runloop，不然线程退出了，相应的delegate方法就不能触发。
 
 
 每一个线程都有其对应的RunLoop，但是默认非主线程的RunLoop是没有运行的，需要为RunLoop添加至少一个事件源，然后去run它。一般情况下我们是没有必要去启用线程的RunLoop的，除非你在一个单独的线程中需要长久的检测某个事件；
 
*/
