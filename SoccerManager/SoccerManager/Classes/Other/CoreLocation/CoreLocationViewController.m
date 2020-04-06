//
//  CoreLocationViewController.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/2/27.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "CoreLocationViewController.h"
#import "CoreLocationCell.h"
#import "BasicUseViewController.h"
#import "CarNavigationViewController.h"

@interface CoreLocationViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@end

@implementation CoreLocationViewController

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.backgroundColor = [UIColor whiteColor];
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //Review:自定义cell的时候,一定要改注册这里;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CoreLocationCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}



#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            {
                BasicUseViewController *vc0 = [[BasicUseViewController alloc] init];
                [self presentViewController:vc0 animated:YES completion:nil];
            }
            break;
            case 1:
            {
                CarNavigationViewController *vc1 = [[CarNavigationViewController alloc] init];
                [self presentViewController:vc1 animated:YES completion:nil];
            }
            break;
            
        default:
            break;
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 10;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CoreLocationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell loadContent:indexPath];
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(100, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    UIEdgeInsets inset = {10, 0, 0, 0};
    return inset;
}

@end
