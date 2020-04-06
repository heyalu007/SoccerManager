//
//  ClearImageCacheTool.m
//  SoccerManager
//
//  Created by ihandysoft on 16/2/29.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "ClearImageCacheTool.h"
#import "SDImageCache.h"

@implementation ClearImageCacheTool

+ (long long)fileSize {

//    NSString *imageCachePath = [SDImageCache sharedImageCache].diskCachePath;
    NSString *imageCachePath = nil;
    long long fileSzie = [self fileSizeInPath:imageCachePath];
    return fileSzie;
}

+ (long long)fileSizeInPath:(NSString *)path
{
    // 1.文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.判断file是否存在
    BOOL isDirectory = NO;
    BOOL fileExists = [mgr fileExistsAtPath:path isDirectory:&isDirectory];
    // 文件\文件夹不存在
    if (fileExists == NO) return 0;
    
    // 3.判断file是否为文件夹
    if (isDirectory) { // 是文件夹
        NSArray *subpaths = [mgr contentsOfDirectoryAtPath:path error:nil];
        long long totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullSubpath = [path stringByAppendingPathComponent:subpath];
            totalSize += [self fileSizeInPath:fullSubpath];
        }
        return totalSize;
    }
    else
    {   // 不是文件夹, 文件
        // 直接计算当前文件的尺寸
        NSDictionary *attr = [mgr attributesOfItemAtPath:path error:nil];
        return [attr[NSFileSize] longLongValue];
    }
}

+ (void)clearImageCacheWithCompletion:(void(^)(BOOL finished))completion {

    // 清除缓存
    
    NSString *imageCachePath = nil;
//    imageCachePath = [SDImageCache sharedImageCache].diskCachePath;
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:imageCachePath error:nil];
    completion(YES);
}


@end
