//
//  OverMatchCell.h
//  SoccerManager
//
//  Created by ihandysoft on 16/1/9.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OverMatchModel;

@interface OverMatchCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)loadContent:(OverMatchModel *)matchModel;

@end
