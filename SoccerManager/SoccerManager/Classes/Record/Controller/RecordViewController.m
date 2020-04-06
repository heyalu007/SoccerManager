//
//  RecordViewController.m
//  SoccerManager
//
//  Created by ihandysoft on 15/12/22.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import "RecordViewController.h"
#import "YATitleBarController.h"

@interface RecordViewController ()

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(0, 100, 375, 50);
    YATitleBar *titleBar = [YATitleBar titleBarWithFrame:rect andTitles:@[@"重要",@"全部",@"已结束",@"哈哈"]];
    [self.view addSubview:titleBar];
}



@end
