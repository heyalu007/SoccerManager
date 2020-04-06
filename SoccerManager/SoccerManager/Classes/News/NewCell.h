//
//  NewsCell.h
//  SoccerManager
//
//  Created by 何亚鲁 on 16/2/2.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewModel;

@interface NewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)loadContent:(NewModel *)newModel;

@end
