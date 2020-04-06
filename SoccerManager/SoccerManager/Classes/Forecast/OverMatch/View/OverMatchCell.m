//
//  OverMatchCell.m
//  SoccerManager
//
//  Created by ihandysoft on 16/1/9.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "OverMatchCell.h"
#import "OverMatchModel.h"
#import "OverMatchTeamsModel.h"
#import "UIImageView+WebCache.h"

@interface OverMatchCell ()

@property (weak, nonatomic) IBOutlet UIImageView *hostTeamLogo;
@property (weak, nonatomic) IBOutlet UIImageView *visitTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *highlightsLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostTeamName;
@property (weak, nonatomic) IBOutlet UILabel *visitTeamName;

@end

@implementation OverMatchCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {

    NSString *ID = @"cell";
    OverMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OverMatchCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)loadContent:(OverMatchModel *)matchModel {

    if (matchModel.teams != nil) {
        self.titleLabel.text = matchModel.teams.score;
        self.hostTeamName.text = matchModel.teams.host;
        self.visitTeamName.text = matchModel.teams.visit;
        NSString *urlString = [NSString stringWithFormat:@"http://duihui.tu.qiumibao.com/zuqiu/%@.png",matchModel.teams.host_logo];
        NSURL *url = [NSURL URLWithString:urlString];
        [self.hostTeamLogo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhudui.png"] completed:nil];
        
        urlString = [NSString stringWithFormat:@"http://duihui.tu.qiumibao.com/zuqiu/%@.png",matchModel.teams.visit_logo];
        url = [NSURL URLWithString:urlString];
        [self.visitTeamLogo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"kedui.png"] completed:nil];
    }
    else {
        self.titleLabel.text = matchModel.title;
        self.hostTeamName.text = @"";
        self.visitTeamName.text = @"";
        self.hostTeamLogo.image = [UIImage imageNamed:@"zhudui.png"];
        self.visitTeamLogo.image = [UIImage imageNamed:@"kedui.png"];
    }
    if (matchModel.highlights != nil) {
        self.highlightsLabel.text = @"集锦";
        self.highlightsLabel.textColor = [UIColor whiteColor];
        self.highlightsLabel.backgroundColor = [UIColor colorWithRed:108/255.0 green:180/255.0 blue:247/255.0 alpha:0.8];
    }
}

@end
