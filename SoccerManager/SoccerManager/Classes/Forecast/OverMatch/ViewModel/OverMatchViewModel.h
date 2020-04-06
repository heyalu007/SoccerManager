//
//  OverMatchViewModel.h
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/8.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBack)(NSArray *array, NSError *error);

@interface OverMatchViewModel : NSObject

- (void)overMatchInfo:(CallBack)callBack;

@end
