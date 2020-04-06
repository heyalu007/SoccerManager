//
//  NewsCell.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/2/2.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "NewCell.h"
#import "NewModel.h"
#import "UIImageView+WebCache.h"

@interface NewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@end

@implementation NewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString *ID = @"cell";
    NewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)loadContent:(NewModel *)newModel {

    self.titleLabel.text = newModel.shortTitle;
    NSRange range = NSMakeRange(5, 11);
    self.timeLabel.text = [newModel.updatetime substringWithRange:range];
    NSURL *url = [NSURL URLWithString:newModel.thumbnail];
    [self.photoView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"news_icon.png"] completed:nil];
}

@end
