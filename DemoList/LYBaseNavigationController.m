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

@interface LYBaseNavigationController ()<UINavigationControllerDelegate>
{
    
}
@property (nonatomic,assign) UINavigationControllerOperation operation;
@property (nonatomic,strong) LYPercentDrivenInteractiveTransition *percentDrivenInteractive;
@end

@implementation LYBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    // Do any additional setup after loading the view.
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

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
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
        return animator;
    } else {
        return nil;
    }
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if (_operation == UINavigationControllerOperationPush) {
        return nil;
    }else{
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
