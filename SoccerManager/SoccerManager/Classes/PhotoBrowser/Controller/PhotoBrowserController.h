//
//  PhotoBrowserController.h
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/10.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowserController : UIViewController

@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, copy) NSArray *photoModelList;

- (void)show;

@end
