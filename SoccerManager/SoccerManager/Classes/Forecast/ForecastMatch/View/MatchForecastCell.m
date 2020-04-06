//
//  MatchForecastCell.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/3.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "MatchForecastCell.h"
#import "ForecastMatchModel.h"
#import "Util.h"
#import "UIImageView+WebCache.h"
#import <UIKit/UIKit.h>

@interface MatchForecastCell ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *liveLabel;//直播标签;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *homeTeamLabel;//主队名;
@property (nonatomic, strong) UILabel *visitTeamLabel;//客队名;
@property (nonatomic, strong) UIImageView *homeTeamLogo;//主队队徽;
@property (nonatomic, strong) UIImageView *visitTeamLogo;//客队队徽;
@property (nonatomic, strong) UIButton *alarmButton;
@property (nonatomic, strong) UIButton *liveButton;

@end

@implementation MatchForecastCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

/*
 
 Review:以后尽量不要这么写了,对于可变的cell来说,太不灵活;
 
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString *ID = @"match";
    MatchForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MatchForecastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
 */

/*
 + (instancetype)cellWithTabelView:(UITableView *)tableView {
 
 static NSString *ID = @"Cell";
 ImportantMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
 if(cell == nil) {
 cell = [[[NSBundle mainBundle] loadNibNamed:@"ImportantMatchCell" owner:nil options:nil] lastObject];
 }
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 return cell;
 }
 */

- (void)loadContent:(ForecastMatchModel *)model {
    
    
    CGFloat height = 60.0;
    if (![model.home_logo isEqualToString:@""] || ![model.visit_logo isEqualToString:@""]) {
        
        self.homeTeamLogo.frame = CGRectMake(70, 10, 40, 40);
        NSString *urlString = [NSString stringWithFormat:@"http://duihui.tu.qiumibao.com/zuqiu/%@.png",model.home_logo];
        NSURL *url = [NSURL URLWithString:urlString];
        [self.homeTeamLogo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhudui.png"] completed:nil];
        
        self.visitTeamLogo.frame = CGRectMake(kScreenWidth - 40 - 70, 10, 40, 40);
        urlString = [NSString stringWithFormat:@"http://duihui.tu.qiumibao.com/zuqiu/%@.png",model.visit_logo];
        url = [NSURL URLWithString:urlString];
        [self.visitTeamLogo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"kedui.png"] completed:nil];
        
        height = 80.0;
    }
    
    self.timeLabel.text = model.time;
    self.timeLabel.frame = CGRectMake(10, (height - 20)/2, 50, 20);
    
    self.titleLabel.text = model.title;
    self.titleLabel.frame = CGRectMake((kScreenWidth - 110)/2, 0, 110, 40);
    
    self.liveLabel.frame = CGRectMake((kScreenWidth - 30 - 10), (height - 30)/2, 50, 30);
    
    
    self.homeTeamLabel.text = model.home_team;
    self.visitTeamLabel.text = model.visit_team;
    
    if (height == 80.0) {
        self.homeTeamLabel.frame = CGRectMake(40, 55, 100, 20);
        self.visitTeamLabel.frame = CGRectMake((kScreenWidth - 100 - 40), 55, 100, 20);
    }
    else {
        self.homeTeamLabel.frame = CGRectMake(60, 5, 60, 50);
        self.visitTeamLabel.frame = CGRectMake((kScreenWidth - 60 - 60), 5, 60, 50);
    }
    
    self.alarmButton.frame = CGRectMake(kScreenWidth - 42, (height - 28)/2, 28, 28);
    self.liveButton.frame = CGRectMake((kScreenWidth - 42)/2, 38, 42, 20);
}

#pragma mark - 懒加载

- (UILabel *)timeLabel {

    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
//        _timeLabel.frame = CGRectMake(10, (self.cellHeight - 20)/2, 50, 20);
        _timeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)titleLabel {

    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)liveLabel {

    if (_liveLabel == nil) {
        _liveLabel = [[UILabel alloc] init];
        _liveLabel.text = @"Live";
        _liveLabel.hidden = YES;
        [self.contentView addSubview:_liveLabel];
    }
    return _liveLabel;
}

- (UILabel *)homeTeamLabel {

    if (_homeTeamLabel == nil) {
        _homeTeamLabel = [[UILabel alloc] init];
//        _homeTeamLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
        _homeTeamLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
        _homeTeamLabel.textAlignment = NSTextAlignmentCenter;
        _homeTeamLabel.numberOfLines = 0;
        [self.contentView addSubview:_homeTeamLabel];
    }
    return _homeTeamLabel;
}

- (UILabel *)visitTeamLabel {

    if (_visitTeamLabel == nil) {
        _visitTeamLabel = [[UILabel alloc] init];
        _visitTeamLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
        _visitTeamLabel.textAlignment = NSTextAlignmentCenter;
        _visitTeamLabel.numberOfLines = 0;
        [self.contentView addSubview:_visitTeamLabel];
    }
    return _visitTeamLabel;
}

- (UIImageView *)homeTeamLogo {

    if (_homeTeamLogo == nil) {
        _homeTeamLogo = [[UIImageView alloc] init];
        [self.contentView addSubview:_homeTeamLogo];
    }
    return _homeTeamLogo;
}

- (UIImageView *)visitTeamLogo {

    if (_visitTeamLogo == nil) {
        _visitTeamLogo = [[UIImageView alloc] init];
        [self.contentView addSubview:_visitTeamLogo];
    }
    return _visitTeamLogo;
}

- (UIButton *)alarmButton {

    if (_alarmButton == nil) {
        _alarmButton = [[UIButton alloc] init];
        [_alarmButton setImage:[UIImage imageNamed:@"clock"] forState:UIControlStateNormal];
        [_alarmButton setImage:[UIImage imageNamed:@"clocked"] forState:UIControlStateSelected];
        [self.contentView addSubview:_alarmButton];
    }
    return _alarmButton;
}


- (UIButton *)liveButton {

    if (_liveButton == nil) {
        _liveButton = [[UIButton alloc] init];
        _liveButton.backgroundColor = RGBColor(108, 180, 247, 0.7);
        _liveButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
        [_liveButton setTitle:@"直播" forState:UIControlStateNormal];
        [self.contentView addSubview:_liveButton];
    }
    return _liveButton;
}

//ImportantMatchCell *cell = [ImportantMatchCell cellWithTabelView:tableView];
//
//ForecastMatchDayModel *matchDayModel = [self.matchList objectAtIndex:indexPath.section];
//ForecastMatchModel *matchModel = [matchDayModel.importantMatchList objectAtIndex:indexPath.row];
//
//cell.homeTeamLabel.text = matchModel.home_team;
//cell.visitTeamLabel.text = matchModel.visit_team;
//cell.timeLabel.text = matchModel.time;
//cell.titleLabel.text = matchModel.title;
//cell.homeTeamLogo.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",matchModel.home_logo,@".png"]];
//cell.visitTeamLogo.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",matchModel.visit_logo,@".png"]];

/*
+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    
    static NSString *ID = @"Cell";
    ImportantMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ImportantMatchCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
*/

/*
 
 使用纯代码自定义一个tableview的步骤
 
 1.新建一个继承自UITableViewCell的类
 
 2.重写initWithStyle:reuseIdentifier:方法
 
 添加所有需要显示的子控件(不需要设置子控件的数据和frame,  子控件要添加到contentView中)
 
 进行子控件一次性的属性设置(有些属性只需要设置一次, 比如字体\固定的图片)
 
 3.提供2个模型
 
 数据模型: 存放文字数据\图片数据
 
 frame模型: 存放数据模型\所有子控件的frame\cell的高度
 
 4.cell拥有一个frame模型(不要直接拥有数据模型)
 
 5.重写frame模型属性的setter方法: 在这个方法中设置子控件的显示数据和frame
 
 6.frame模型数据的初始化已经采取懒加载的方式(每一个cell对应的frame模型数据只加载一次)
 
 */


@end
