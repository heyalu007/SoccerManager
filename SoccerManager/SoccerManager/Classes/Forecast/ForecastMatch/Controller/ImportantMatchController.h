//
//  ImportantMatchController.h
//  SoccerManager
//
//  Created by 何亚鲁 on 15/12/26.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ForecastMatchDayModel;

@interface ImportantMatchController : UIViewController

@property (nonatomic, strong) NSArray <ForecastMatchDayModel *> *matchDayList;

@end
