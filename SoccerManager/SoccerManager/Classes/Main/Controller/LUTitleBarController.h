//
//  LUTitleBarController.h
//  SoccerManager
//
//  Created by ihandysoft on 16/1/6.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LUTitleBarController : UIViewController

@property (nonatomic, strong) NSArray <UIViewController *> *viewControllers;
@property (nonatomic ,strong) NSArray <NSString *> *headArray;
- (void)showInViewContoller:(UIViewController *)viewContoller;

@end
