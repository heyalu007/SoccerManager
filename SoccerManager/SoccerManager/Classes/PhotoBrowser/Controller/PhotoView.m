//
//  PhotoView.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/12.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "PhotoView.h"
#import "UIImageView+WebCache.h"

@interface PhotoView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *actView;

@end

@implementation PhotoView

- (instancetype)init {

    if (self = [super init]) {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)loadContentWithUrl:(NSURL *)url {

//    __weak typeof(self) weakSelf = self;

//    [self.imageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        ;
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [weakSelf.actView stopAnimating];
////        weakSelf.imageView.hidden = NO;
//    }];
    [self.imageView  sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageCacheMemoryOnly];
}


#pragma mark - 懒加载

- (UIImageView *)imageView {

    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = self.frame;
        _imageView.backgroundColor = [UIColor colorWithRed:100 green:100 blue:100 alpha:0.5];
//        _imageView.hidden = YES;
        [self insertSubview:_imageView atIndex:0];
    }
    return _imageView;
}

- (UIActivityIndicatorView *)actView {

    if (_actView == nil) {
        _actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _actView.center = self.center;
        [self addSubview:_actView];
        [_actView startAnimating];
    }
    return _actView;
}

@end
