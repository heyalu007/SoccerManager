//
//  PhotoBrowserController.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/10.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "PhotoBrowserController.h"
#import "UIImageView+WebCache.h"
#import "PhotoModel.h"
#import "PhotoView.h"
#import "Util.h"

@interface PhotoBrowserController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
//Review:NSInteger不是对象,不能存在NSMutableArray中;
//@property (nonatomic, strong) NSMutableArray<NSInteger> *indexList;
//@property (nonatomic, strong) NSMutableSet<NSNumber *> *indexSet;
@property (nonatomic, strong) NSMutableDictionary *photoViewList;
@property (nonatomic, strong) UIButton *hideButton;

@end

@implementation PhotoBrowserController

/*

Review:
这里如果写了loadView就无法加载xib了;
 
- (void)loadView {
    [super loadView];
}
 
 loadView 方法在控制器的 view 为 nil 的时候被调用。 此方法用于以编程的方式创建 view 的时候用到。loadView 是使用代码生成视图的时候，当视图第一次载入的时候调用的方法。用于使用（写）代码来实现控件。用于使用代码生成控件的函数。
*/

- (void)viewDidLoad {

    [super viewDidLoad];
//    self.hideButton;
}

- (void)show {

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
    [self showPhotoAtIndex:self.currentIndex];
}

- (void)showPhotoAtIndex:(NSInteger)index {

    self.scrollView.contentOffset = CGPointMake(index * kScreenWidth, 0);
    [self preLoadPhotoNearyIndex:index];
}

- (void)preLoadPhotoNearyIndex:(NSInteger)index {
    
    if (index < 0 || index >= self.photoModelList.count) {
        return;
    }
    NSInteger firstIndex = index - 1;
    if (firstIndex < 0) {
        firstIndex = 0;
    }
    NSInteger lastIndex = index + 1;
    if (lastIndex >= self.photoModelList.count) {
        lastIndex = self.photoModelList.count - 1;
    }
    for (NSInteger i = firstIndex; i <= lastIndex; i++) {
        [self loadPhotoViewAtIndex:i];
    }
}

- (void)removePhotoViewAtIndex:(NSInteger)index {

    if (index < 0 || index >= self.photoModelList.count) {
        return;
    }
    if ([[self.photoViewList allKeys] containsObject:@(index)]) {
        PhotoView *photoView = [self.photoViewList objectForKey:@(index)];
        [photoView removeFromSuperview];
        [self.photoViewList removeObjectForKey:@(index)];
        DebugLog(@"移除了照片%ld",index);
    }
}

- (void)loadPhotoViewAtIndex:(NSInteger)index {

    if (index < 0 || index >= self.photoModelList.count) {
        return;
    }
    if (![[self.photoViewList allKeys] containsObject:@(index)]) {
        PhotoView *photoView = [[PhotoView alloc] init];
        CGRect rect = self.scrollView.frame;
        rect.origin.x = rect.size.width * index;
        photoView.frame = rect;
        photoView.contentMode = UIViewContentModeScaleAspectFit;
        PhotoModel *model = [self.photoModelList objectAtIndex:index];
        [photoView loadContentWithUrl:model.imageUrl];
        [self.scrollView addSubview:photoView];
        [self.photoViewList setObject:photoView forKey:@(index)];
        DebugLog(@"加载了照片%ld",index);
    }
}


- (void)hide {

    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    NSInteger firstIndex = index - 1;
    if (firstIndex < 0) {
        firstIndex = 0;
    }
    NSInteger lastIndex = index + 1;
    if (lastIndex >= self.photoModelList.count) {
        lastIndex = self.photoModelList.count - 1;
    }
    
    //移除不需要的photoView;
    for (NSNumber *number in [self.photoViewList allKeys]) {
        NSInteger index = [number integerValue];
        if(index < firstIndex || index > lastIndex) {
            [self removePhotoViewAtIndex:index];
        }
    }
    //添加新的photoView;
    for (NSInteger i = firstIndex; i <= lastIndex; i++) {
        [self loadPhotoViewAtIndex:i];
    }
}



#pragma mark - 懒加载

- (UIScrollView *)scrollView {

    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.frame;
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.photoModelList.count, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor yellowColor];
//        [self.view insertSubview:self.scrollView atIndex:0];
        self.scrollView.delegate = self;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

//- (NSMutableSet<NSNumber *> *)indexSet {
//
//    if (_indexSet == nil) {
//        _indexSet = [NSMutableSet set];
//    }
//    return _indexSet;
//}

- (NSMutableDictionary *)photoViewList {

    if (_photoViewList == nil) {
        _photoViewList = [NSMutableDictionary dictionary];
    }
    return _photoViewList;
}

- (UIButton *)hideButton {

    if (_hideButton == nil) {
        _hideButton = [[UIButton alloc] init];
        _hideButton.frame = CGRectMake(100, 0, 40, 40);
        _hideButton.backgroundColor = [UIColor redColor];
        [_hideButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchDragInside];
        [self.view addSubview:_hideButton];
        [self.view insertSubview:_hideButton aboveSubview:self.scrollView];
    }
    return _hideButton;
}

@end
