//
//  Util.h
//  SoccerManager
//
//  Created by ihandysoft on 15/12/22.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

@end

#ifdef DEBUG // 处于开发阶段
#define DebugLog(...) NSLog(__VA_ARGS__)
#else // 处于发布阶段
#define DebugLog(...)
#endif

// RGB颜色
#define RGBColor(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 随机色
#define RandomColor RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 0.9)

#define ThemeColor [UIColor colorWithRed:54/255.0 green:162/255.0 blue:249/255.0 alpha:0.8]


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenBounds [UIScreen mainScreen].bounds
