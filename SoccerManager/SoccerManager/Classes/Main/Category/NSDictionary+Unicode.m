//
//  NSDictionary+Unicode.m
//  SoccerManager
//
//  Created by 何亚鲁 on 15/12/24.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import "NSDictionary+Unicode.h"
#import <objc/runtime.h>

@implementation NSDictionary (Unicode)

+ (void)load {

    Method original, replaced;
    original = class_getInstanceMethod(self, @selector(description));
    replaced = class_getInstanceMethod(self, @selector(myDescription));
    method_exchangeImplementations(original, replaced);
}

- (NSString*)myDescription {
    NSString *desc = [self myDescription];
    desc = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return desc;
}

@end
