//
//  MatchForecastCell.h
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/3.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ForecastMatchModel;

@interface MatchForecastCell : UITableViewCell

//+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)loadContent:(ForecastMatchModel *)model;

@end
