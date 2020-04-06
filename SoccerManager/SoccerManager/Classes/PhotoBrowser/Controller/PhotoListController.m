//
//  PhotoListController.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/10.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "PhotoListController.h"
#import "PhotoCell.h"
#import "PhotoModel.h"
#import "PhotoBrowserController.h"

@interface PhotoListController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<PhotoModel *> *photoList;

@end



@implementation PhotoListController

static NSString * const ID = @"cell";

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *urlArray = @[@"http://wenwen.soso.com/p/20100604/20100604213156-323142736.jpg",
                       @"http://c.hiphotos.baidu.com/zhidao/pic/item/b21c8701a18b87d60dd27606040828381f30fd13.jpg",
                       @"http://ww1.sinaimg.cn/mw600/bcfdc861tw1e6onhhpzykj20dc0a03yp.jpg",
                       @"http://imgsrc.baidu.com/forum/w%3D580/sign=6712d7096e81800a6ee58906813433d6/4ff995eef01f3a299bbffb489b25bc315d607c6a.jpg",
                       @"http://imgsrc.baidu.com/forum/w%3D580/sign=990d45556e81800a6ee58906813433d6/c82aae4bd11373f0ca57d345a60f4bfbfaed046c.jpg",
                       @"http://imgsrc.baidu.com/forum/w%3D580/sign=90c643e16f81800a6ee58906813433d6/4ff995eef01f3a296c6b6fa09a25bc315d607c6e.jpg"];
    for (NSString *urlString in urlArray) {
        PhotoModel *model = [[PhotoModel alloc] init];
        model.imageUrl = [NSURL URLWithString:urlString];
        [self.photoList addObject:model];
        [self.collectionView reloadData];
    }
    
    
}

#pragma mark - UICollectionViewDelegate

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 80);
}

//设置每一行的cell之间的间距;
//- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 2;
//}

//设置行间距;
- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}

//被选中;
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoBrowserController *photoBrowserVC = [[PhotoBrowserController alloc] init];
    photoBrowserVC.currentIndex = indexPath.row;
    photoBrowserVC.photoModelList = self.photoList;
    [photoBrowserVC show];
}


#pragma mark - UICollectionViewDataSource

//多少组;
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每一组多少个;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    PhotoModel *model = [self.photoList objectAtIndex:indexPath.row];
    [cell loadContent:model];
    return cell;
}



#pragma mark - 懒加载



- (UICollectionView *)collectionView {

    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGRect rect = self.view.frame;
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
        [_collectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:ID];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSMutableArray<PhotoModel *> *)photoList {

    if (_photoList == nil) {
        _photoList = [NSMutableArray array];
    }
    return _photoList;
}

@end
