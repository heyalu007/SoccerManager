//
//  VedioViewController.m
//  SoccerManager
//
//  Created by ihandysoft on 15/12/22.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import "VedioViewController.h"
#import "VedioViewModel.h"
#import "AFNetworking.h"
#import "VedioCell.h"
#import "VedioModel.h"
#import "YAActView.h"
#import "Util.h"

@interface VedioViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) VedioViewModel *vedioViewModel;
@property (nonatomic, copy) NSArray *vedioModelList;
@property (nonatomic, strong) YAActView *actView;

@end


@implementation VedioViewController

static NSString *const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.actView startAnimating];
    
    self.vedioViewModel = [[VedioViewModel alloc] init];
    __weak typeof(self) weakSelf = self;
    [self.vedioViewModel queryVedioInfo:^(NSArray *vedioList, NSError *error) {
        if (error) {
            [self.actView stopAnimatingWithTitle:@"请检查您的网络!"];
        } else {
            weakSelf.vedioModelList = vedioList;
            [weakSelf.collectionView reloadData];
        }
    }];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    DebugLog(@"%ld",indexPath.row);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    [self.actView stopAnimatingWithTitle:nil];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.vedioModelList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    VedioCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    VedioModel *vedioModel = [self.vedioModelList objectAtIndex:indexPath.row];
    [cell loadContent:vedioModel];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


/*
 
 如果需要显示每个section的headerView或footerView，则还需注册相应的UICollectionReusableView的子类到collectionView
 elementKind是header或footer的标识符，只有两种可以设置UICollectionElementKindSectionHeader和UICollectionElementKindSectionFooter
 - (void)registerClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier;
 PS:如果是用nib创建的话，使用下面这个函数来注册。
 - (void)registerNib:(UINib *)nib forSupplementaryViewOfKind:(NSString *)kind withReuseIdentifier:(NSString *)identifier;
 */

/*
 定义并返回每个headerView或footerView
 - (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
 
 上面这个方法使用时必须要注意的一点是，如果布局没有为headerView或footerView设置size的话(默认size为CGSizeZero)，则该方法不会被调用。所以如果需要显示header或footer，需要手动设置size。
 可以通过设置UICollectionViewFlowLayout的headerReferenceSize和footerReferenceSize属性来全局控制size。或者通过重载以下代理方法来分别设置
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
 */


#pragma mark - UICollectionViewDelegateFlowLayout

//返回每个cell的大小;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(kScreenWidth, 80);
}

//设置cell四周的间隙
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
#pragma mark - 懒加载

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        CGRect rect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49);
        UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
//        [_collectionView registerClass:[VedioCell class] forCellWithReuseIdentifier:ID];
        //Review:如果想关联xib文件，要这么写；
        [_collectionView registerNib:[UINib nibWithNibName:@"VedioCell" bundle:nil] forCellWithReuseIdentifier:ID];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSArray *)vedioModelList {

    if (_vedioModelList == nil) {
        _vedioModelList = [NSArray array];
    }
    return _vedioModelList;
}

- (YAActView *)actView {
    
    if (_actView == nil) {
        _actView = [[YAActView alloc] initWithSuperView:self.view andFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)];
    }
    return _actView;
}

@end
