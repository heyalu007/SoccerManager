//
//  ClearImageCacheTool.h
//  SoccerManager
//
//  Created by ihandysoft on 16/2/29.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClearImageCacheTool : NSObject

+ (long long)fileSize;
+ (void)clearImageCacheWithCompletion:(void(^)(BOOL finished))completion;
@end
