//
//  PhotoCell.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/10.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "PhotoCell.h"
#import "PhotoModel.h"
#import "UIImageView+WebCache.h"

@interface PhotoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor = [UIColor grayColor];
}

- (void)loadContent:(PhotoModel *)model {

    [self.imageView sd_setImageWithURL:model.imageUrl placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageCacheMemoryOnly];
}

/*
 Review:加边框和圆角;
 - (void)awakeFromNib {
 self.imageView.layer.borderWidth = 3;
 self.imageView.layer.borderColor = [UIColor yellowColor].CGColor;
 self.imageView.layer.cornerRadius = 3;
 self.imageView.clipsToBounds = YES;
 self.imageView.contentMode = UIViewContentModeScaleAspectFit;
 }
*/

/*
Review:copy的属性的写法;
@property (nonatomic, copy) NSString *image;
- (void)setImage:(NSString *)image {
    _image = [image copy];
    self.imageView.image = [UIImage imageNamed:image];
}
*/



@end
