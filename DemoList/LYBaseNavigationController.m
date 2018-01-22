//
//  LYBaseNavigationController.m
//  DemoList
//
//  Created by luoyan on 2018/1/12.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "LYBaseNavigationController.h"
#import "LYDIYAnimator.h"
#import "LYDIYPopTransition.h"
#import "LYDIYPushTransition.h"
#import "LYDIYSectionViewController.h"
#import "LYPercentDrivenInteractiveTransition.h"
#import "LYMainTabBarController.h"

@interface LYBaseNavigationController ()<UINavigationControllerDelegate>
{
    BOOL _isPush;
}
@property (nonatomic,assign) UINavigationControllerOperation operation;
@property (nonatomic,strong) LYPercentDrivenInteractiveTransition *percentDrivenInteractive;
@end

@implementation LYBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count == 1) {
        //要想让tabbar一起做动画，则需要把tabbar添加到跟控制器中的视图中。
        _isPush = YES;
        LYBaseViewController *vc = (LYBaseViewController*)self.topViewController;
        LYMainTabBarController *tabbarVC = (LYMainTabBarController*)vc.tabBarController;
        [tabbarVC switchTabBarToRootViewVC:vc];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LYPercentDrivenInteractiveTransition*)percentDrivenInteractive
{
    if (!_percentDrivenInteractive) {
        _percentDrivenInteractive = [LYPercentDrivenInteractiveTransition new];
    }
    return _percentDrivenInteractive;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated
{
    [self.percentDrivenInteractive addGestureToViewController:viewController];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    self.operation = operation;
    if (operation == UINavigationControllerOperationPush) {
        [self.percentDrivenInteractive addGestureToViewController:toVC];
        LYDIYPushTransition *animator = [LYDIYPushTransition new];
        return animator;
    } else if (operation == UINavigationControllerOperationPop) {
        LYDIYPopTransition *animator = [LYDIYPopTransition new];
        animator.popEndBlock = ^{
            //pop完成后（不管是点击返回还是手势返回，都会触发），将tabbar重新添加到tabbarviewcontroller上去。
            if (_isPush && self.viewControllers.count == 1) {
                _isPush = NO;
                LYBaseViewController *vc = (LYBaseViewController*)self.topViewController;
                LYMainTabBarController *tabbarVC = (LYMainTabBarController*)vc.tabBarController;
                [tabbarVC switchTabBarToTabBarVC];
            }
        };
        return animator;
    } else {
        return nil;
    }
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if (self.operation == UINavigationControllerOperationPush) {
        return nil;
    } else {
        return self.percentDrivenInteractive.isInteractive ? self.percentDrivenInteractive : nil ;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
