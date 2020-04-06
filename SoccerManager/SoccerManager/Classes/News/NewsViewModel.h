//
//  NewsViewModel.h
//  SoccerManager
//
//  Created by 何亚鲁 on 16/2/2.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBack)(NSArray *array, NSError *error);

@interface NewsViewModel : NSObject

- (void)queryNewsInfo:(CallBack)callBack;

@end
