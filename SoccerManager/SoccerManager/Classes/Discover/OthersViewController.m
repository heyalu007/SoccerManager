

#import "OthersViewController.h"
#import "Others.h"

@interface OthersViewController ()

@end

@implementation OthersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

//    [self loadFileCompression];
    
    YAShapeView *progressView = [[YAShapeView alloc] init];
    progressView.frame = CGRectMake(0, 64, 320, 500);
    [self.view addSubview:progressView];
}

- (void)loadBTView
{
    BtCentralController *bt = [[BtCentralController alloc] init];
    [self addChildViewController:bt];
    [self.view addSubview:bt.view];
}

- (void)loadCoreLocationView
{
    //review:CollectionView初始化一定要带上layout;
    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CoreLocationViewController *cl = [[CoreLocationViewController alloc] initWithCollectionViewLayout:layout];
    [self addChildViewController:cl];
    [self.view addSubview:cl.view];
}

- (void)loadCoreAnimation {

    animationGroupViewController *animationVC = [[animationGroupViewController alloc] init];
    [self addChildViewController:animationVC];
    [self.view addSubview:animationVC.view];
}

- (void)loadFileCompression {
    
    FileCompressionViewController *testVC = [[FileCompressionViewController alloc] init];
    [self addChildViewController:testVC];
    [self.view addSubview:testVC.view];
}


@end
