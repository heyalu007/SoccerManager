//
//  VedioModel.h
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/31.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VedioModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *filename;
+ (instancetype)modelWithDic:(NSDictionary *)dic;

@end
