//
//  MatchForecastViewModel.h
//  SoccerManager
//
//  Created by ihandysoft on 16/1/4.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBack)(NSArray *array, NSError *error);

@interface MatchForecastViewModel : NSObject

- (void)MatchForecastInfo:(CallBack)callBack;


@end
