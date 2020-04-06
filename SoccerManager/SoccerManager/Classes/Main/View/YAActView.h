//
//  YAActView.h
//  SoccerManager
//
//  Created by 何亚鲁 on 15/12/30.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import <UIKit/UIKit.h>


#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


@interface YAActView : UIView

- (instancetype)initWithSuperView:(UIView *)superView andFrame:(CGRect)actViewFrame;
- (void)startAnimating;
- (void)stopAnimatingWithTitle:(NSString *)title;

@end
