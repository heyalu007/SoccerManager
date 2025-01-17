
#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController


/**
 *  async -- 并发队列（最常用）
 *  会不会创建线程：会，一般同时开多条
 *  任务的执行方式：并发执行
 */
- (void)asyncGlobalQueue
{
    // 获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 将 任务 添加 全局队列 中去 异步 执行
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片5---%@", [NSThread currentThread]);
    });
}

/**
 *  async -- 串行队列（有时候用）
 *  会不会创建线程：会，一般只开1条线程
 *  任务的执行方式：串行执行（一个任务执行完毕后再执行下一个任务）
 */
- (void)asyncSerialQueue
{
    // 1.创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("cn.heima.queue", NULL);
    
    // 2.将任务添加到串行队列中 异步 执行
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片5---%@", [NSThread currentThread]);
    });
    
    // 3.非ARC，需要释放创建的队列
    //    dispatch_release(queue);
}

/**
 *  async -- 主队列(很常用)
 */
- (void)asyncMainQueue
{
    // 1.主队列(添加到主队列中的任务，都会自动放到主线程中去执行)
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 2.添加 任务 到主队列中 异步 执行
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片5---%@", [NSThread currentThread]);
    });
}

/**
 *  sync -- 主队列(不能用---会卡死)
 */
- (void)syncMainQueue
{
    NSLog(@"syncMainQueue----begin--");
    
    // 1.主队列(添加到主队列中的任务，都会自动放到主线程中去执行)
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 2.添加 任务 到主队列中 异步 执行
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片3---%@", [NSThread currentThread]);
    });
    
    NSLog(@"syncMainQueue----end--");
}

/**-------------------------------------华丽的分割线-----------------------------------------------------**/

/**
 *  sync -- 并发队列
 *  会不会创建线程：不会
 *  任务的执行方式：串行执行（一个任务执行完毕后再执行下一个任务）
 *  并发队列失去了并发的功能
 */
- (void)syncGlobalQueue
{
    // 获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 将 任务 添加到 全局并发队列 中 同步 执行
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片5---%@", [NSThread currentThread]);
    });
}

/**
 *  sync -- 串行队列
 *  会不会创建线程：不会
 *  任务的执行方式：串行执行（一个任务执行完毕后再执行下一个任务）
 */
- (void)syncSerialQueue
{
    // 创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("cn.heima.queue", NULL);
    
    // 将 任务 添加到 串行队列 中 同步 执行
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片5---%@", [NSThread currentThread]);
    });
}



@end
