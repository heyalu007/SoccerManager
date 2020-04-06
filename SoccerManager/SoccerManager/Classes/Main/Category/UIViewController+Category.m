//
//  UIViewController+Category.m
//  SoccerManager
//
//  Created by ihandysoft on 15/12/26.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import "UIViewController+Category.h"
#import <objc/runtime.h>
#import "Util.h"

@implementation UIViewController (Category)

+(void)load {

    Method original, replaced;
    original = class_getInstanceMethod(self, @selector(viewDidLoad));
    replaced = class_getInstanceMethod(self, @selector(myViewDidLoad));
    method_exchangeImplementations(original, replaced);
}


- (void)myViewDidLoad {

    [self myViewDidLoad];
    CGRect rect = CGRectMake(0, 0, 600, 600);
    //
    if ([NSStringFromCGRect(self.view.frame) isEqualToString: NSStringFromCGRect(rect)] ) {
        self.view.frame = kScreenBounds;
    }
}

@end
