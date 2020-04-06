//
//  VedioViewModel.h
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/31.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBack)(NSArray *vedioList, NSError *error);

@interface VedioViewModel : NSObject

- (void)queryVedioInfo:(CallBack)callBack;

@end
