//
//  ForecastMatchModel.m
//  SoccerManager
//
//  Created by 何亚鲁 on 15/12/27.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//


#import "ForecastMatchModel.h"
#import "ForecastMatchDayModel.h"
#import <UIKit/UIKit.h>

@implementation ForecastMatchModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        self.time = dict[@"time"];
        self.home_team = dict[@"home_team"];
        self.visit_team = dict[@"visit_team"];
        self.type = dict[@"type"];
        self.home_logo = dict[@"home_logo"];
        self.visit_logo = dict[@"visit_logo"];
        self.title = [self titleFromString:dict[@"title"]];
        self.isImportant = [self isImportantWithTitle:self.title];
    }
    return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

- (NSString *)titleFromString:(NSString *)title {
    
    if (![self.type isEqualToString:@"football"]) {//如果不是足球比赛，则退出;
        return nil;
    }
    
    /*
     下面一段代码是截取title中的标题,如下面两个例子中的"英超第19轮"和"英冠";
     title = "<b>英超第19轮</b> 埃弗顿 - 斯托克城";
     title = "英冠 博尔顿 - 布莱克本";
     */
    NSRange startRange = [title rangeOfString:@"<b>"];
    NSUInteger startLocation = startRange.length;
    NSRange endRange1 = [title rangeOfString:@"</b>"];
    NSRange endRange2 = [title rangeOfString:@" "];
    
    if (endRange1.length || endRange2.length) {
        NSUInteger endLocation = MIN(endRange1.location, endRange2.location);
        NSRange range = NSMakeRange(startLocation, endLocation - startLocation);
        return [title substringWithRange:range];
    }
    return title;
}


- (BOOL)isImportantWithTitle:(NSString *)title {

    if (title == nil) {
        return NO;
    }
    if ([title hasPrefix:@"英超"]
        ||[title hasPrefix:@"西甲"]
        ||[title hasPrefix:@"意甲"]
        ||[title hasPrefix:@"德甲"]) {
        return YES;
    }
    return NO;
}

- (BOOL)isImportantWithDict:(NSDictionary *)dict {
    
    if (![dict[@"type"] isEqualToString:@"football"]) {//如果不是足球比赛，则退出;
        return NO;
    }
    NSString *homeTeamLogoName = [NSString stringWithFormat:@"%@%@",dict[@"home_logo"],@".png"];
    NSString *visitTeamLogoName = [NSString stringWithFormat:@"%@%@",dict[@"visit_logo"],@".png"];
    UIImage *homeTeamLogo = [UIImage imageNamed:homeTeamLogoName];
    UIImage *visitTeamLogo = [UIImage imageNamed:visitTeamLogoName];
    if (homeTeamLogo != nil || visitTeamLogo != nil) {
        return YES;
    }
    return NO;
}


@end
