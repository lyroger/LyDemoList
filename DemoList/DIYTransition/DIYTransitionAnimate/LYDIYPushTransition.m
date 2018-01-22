//
//  LYDIYPushTransition.m
//  DemoList
//
//  Created by luoyan on 2018/1/11.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "LYDIYPushTransition.h"
@interface LYDIYPushTransition ()

@property (nonatomic, weak) UIView *blackMask;
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation LYDIYPushTransition
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    
    UIView *maskView = [[UIView alloc] initWithFrame:fromView.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0;
    [fromView addSubview:maskView];
    
    toView.layer.transform = CATransform3DMakeTranslation(screenWidth,0,0);
    [UIView animateWithDuration:0.3 animations:^{

        maskView.alpha = 0.35;
        fromView.layer.transform = CATransform3DMakeScale(0.95,0.95,1);
        toView.layer.transform = CATransform3DIdentity;

    } completion:^(BOOL finished){
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            fromView.layer.transform = CATransform3DIdentity;
            
        } else {
            [transitionContext completeTransition:YES];
            fromView.layer.transform = CATransform3DIdentity;
        }
        [maskView removeFromSuperview];
    }];
}
@end
