//
//  PhotoCell.h
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/10.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoModel;

@interface PhotoCell : UICollectionViewCell

- (void)loadContent:(PhotoModel *)model;

@end
