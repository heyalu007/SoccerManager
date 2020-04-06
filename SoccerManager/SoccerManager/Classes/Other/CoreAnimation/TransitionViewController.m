//
//  TransitionViewController.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/3/1.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "TransitionViewController.h"

@interface TransitionViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, strong) CATransition *anim;

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _index = 1;
    NSString *fileName = [NSString stringWithFormat:@"%li",_index];
    _imageView.image = [UIImage imageNamed:fileName];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    _index++;
    
    if (_index == 4) {
        _index = 1;
    }
    NSString *fileName = [NSString stringWithFormat:@"%li",_index];
    _imageView.image = [UIImage imageNamed:fileName];
    
    CATransition *anim = [CATransition animation];
    _anim = anim;
    anim.delegate = self;
    
//    anim.type = @"pageCurl";
//    anim.type = @"push";
    anim.type = @"reveal";
    
    anim.subtype = kCATransitionFromLeft;
//    anim.startProgress = 0.5;//翻页的起点,默认是0;
    
    anim.duration = 2;
//    anim setAnimationDidStopSelector
    
    [_imageView.layer addAnimation:anim forKey:@"123"];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    if ([_imageView.layer valueForKey:@"123"] == anim) {
        ;
    }
}

@end
