//
//  CoreLocationCell.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/2/27.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "CoreLocationCell.h"

@interface CoreLocationCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CoreLocationCell


- (void)awakeFromNib {

    [super awakeFromNib];
    self.backgroundColor = [UIColor yellowColor];
}

- (void)loadContent:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            self.titleLabel.text = @"基本使用";
            break;
        case 1:
            self.titleLabel.text = @"汽车导航";
            break;
        default:
            break;
    }
}

@end
