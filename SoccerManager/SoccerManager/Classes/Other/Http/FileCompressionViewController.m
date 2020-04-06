
#import "FileCompressionViewController.h"
#import "SSZipArchive.h"

@interface FileCompressionViewController ()

@end


// 1.导入libz.tbd
// 2.导入框架SSZipArchive


@implementation FileCompressionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self unZipTest];
}

- (void)zipTest {

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imagePath = [caches stringByAppendingPathComponent:@"images"];
    NSString *zipFile = [caches stringByAppendingPathComponent:@"image.zip"];
    
    dispatch_async(queue, ^{
        
        BOOL result = [SSZipArchive createZipFileAtPath:zipFile withContentsOfDirectory:imagePath];
        if (result) {
            NSLog(@"压缩完成");
        }
    });
}


- (void)unZipTest {

//    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/images.zip"];
//    NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        [SSZipArchive unzipFileAtPath:location.path toDestination:caches];
//    }];
//    [task resume];
    
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imagePath = [caches stringByAppendingPathComponent:@"images"];
    NSString *zipFile = [caches stringByAppendingPathComponent:@"image.zip"];
    
    BOOL result = [SSZipArchive unzipFileAtPath:zipFile toDestination:imagePath];
    if (result) {
        NSLog(@"解压缩完成");
    }
}





- (void)dealloc {
    ;
    //即使控制器销毁了，在子线程压缩也能顺利完成；
}

/*
 
 + (BOOL)createZipFileAtPath:(NSString *)path withContentsOfDirectory:(NSString *)directoryPath;
 + (BOOL)createZipFileAtPath:(NSString *)path withFilesAtPaths:(NSArray *)paths;
 
 两个方法的区别在于，前者是把要压缩的文件打包成一个文件夹，然后把文件夹的路径带入；
 后者是把要压缩的文件的路径，做成一个数组，带入；
 */


@end
