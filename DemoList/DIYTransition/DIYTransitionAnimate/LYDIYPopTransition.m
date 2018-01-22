//
//  LYDIYTransition.m
//  DemoList
//
//  Created by luoyan on 2018/1/10.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "LYDIYPopTransition.h"

@implementation LYDIYPopTransition
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    
    UIView *maskView = [[UIView alloc] initWithFrame:fromView.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.35;
    [toView addSubview:maskView];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    toView.layer.transform = CATransform3DMakeScale(0.95,0.95,1);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        maskView.alpha = 0;
        fromView.layer.transform = CATransform3DMakeTranslation(screenWidth,0,0);
        toView.layer.transform = CATransform3DIdentity;
        
    } completion:^(BOOL finished){
        [maskView removeFromSuperview];
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            toView.layer.transform = CATransform3DIdentity;
            fromView.layer.transform = CATransform3DIdentity;
        } else {
            [transitionContext completeTransition:YES];
            if (self.popEndBlock) {
                self.popEndBlock();
            }
        }
    }];
}
@end
