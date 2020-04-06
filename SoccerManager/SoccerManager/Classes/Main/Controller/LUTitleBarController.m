//
//  LUTitleBarController.m
//  SoccerManager
//
//  Created by ihandysoft on 16/1/6.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "LUTitleBarController.h"

@interface LUTitleBarController ()


@property (nonatomic ,strong) UIViewController *currentVC;
//@property (nonatomic ,strong) UIScrollView *headScrollView;  //  顶部滚动视图


@end

@implementation LUTitleBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"网易新闻Demo";
    
    self.headArray = @[@"头条",@"娱乐",@"体育"];
    /**
     *   automaticallyAdjustsScrollViewInsets   又被这个属性坑了
     *   我"UI高级"里面一篇文章着重讲了它,大家可以去看看
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 320, 40)];
//    self.headScrollView.backgroundColor = [UIColor purpleColor];
//    self.headScrollView.contentSize = CGSizeMake(560, 0);
//    self.headScrollView.bounces = NO;
//    self.headScrollView.pagingEnabled = YES;
//    [self.view addSubview:self.headScrollView];
    for (int i = 0; i < [self.headArray count]; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0 + i*80, 0, 80, 40);
        [button setTitle:[self.headArray objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = i + 100;
        [button addTarget:self action:@selector(didClickHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
    }
    
    /*
     苹果新的API增加了addChildViewController方法，并且希望我们在使用addSubview时，同时调用[self addChildViewController:child]方法将sub view对应的viewController也加到当前ViewController的管理中。
     对于那些当前暂时不需要显示的subview，只通过addChildViewController把subViewController加进去；需要显示时再调用transitionFromViewController方法。将其添加进入底层的ViewController中。
     这样做的好处：
     
     1.无疑，对页面中的逻辑更加分明了。相应的View对应相应的ViewController。
     2.当某个子View没有显示时，将不会被Load，减少了内存的使用。
     3.当内存紧张时，没有Load的View将被首先释放，优化了程序的内存释放机制。
     */
    
    /**
     *  在iOS5中，ViewController中新添加了下面几个方法：
     *  addChildViewController:
     *  removeFromParentViewController
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  willMoveToParentViewController:
     *  didMoveToParentViewController:
     */
    
    for (UIViewController *vc in self.viewControllers) {
        vc.view.frame = CGRectMake(0, 104, 320, 464);
    }
    
    UIViewController *firstVC = [self.viewControllers firstObject];
    [self addChildViewController:firstVC];
    [self.view addSubview:firstVC.view];
    self.currentVC = firstVC;
    
}

- (void)didClickHeadButtonAction:(UIButton *)button {
    //  点击处于当前页面的按钮,直接跳出
    UIViewController *newVC = [self.viewControllers objectAtIndex:button.tag - 100];
    if (self.currentVC == newVC) {
        return;
    }
    [self replaceController:self.currentVC newController:newVC];
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *			着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController	  当前显示在父视图控制器中的子视图控制器
     *  toViewController		将要显示的姿势图控制器
     *  duration				动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options				 动画效果(渐变,从下往上等等,具体查看API)
     *  animations			  转换过程中得动画
     *  completion			  转换完成
     */
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:2.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
            
        }else{
            
            self.currentVC = oldController;
            
        }
    }];
}

- (void)showInViewContoller:(UIViewController *)viewContoller {

    if (viewContoller.navigationController) {
        viewContoller.edgesForExtendedLayout = UIRectEdgeNone;
        //Review:如果viewContoller的容器是navigationController,则设置viewContoller.view的尺寸从navigationBar的下边沿开始算;
    }
    [viewContoller addChildViewController:self];
    [viewContoller.view addSubview:self.view];
}

@end
