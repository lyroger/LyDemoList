//
//  LYDIYAnimator.m
//  DemoList
//
//  Created by luoyan on 2018/1/10.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "LYDIYAnimator.h"
#import "LYDIYPopTransition.h"

@implementation LYDIYAnimator
#pragma mark -UIViewControllerTransitioningDelegateUIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [LYDIYPopTransition new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    //    NSLog(@"----------------------%@",self.interactiveHidden);
    return nil;
}

@end
