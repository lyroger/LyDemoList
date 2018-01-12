//
//  LYDIYTransitionViewController.m
//  DemoList
//
//  Created by luoyan on 2018/1/11.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "LYDIYTransitionViewController.h"
#import "LYDIYAnimator.h"
#import "LYDIYPopTransition.h"
#import "LYDIYPushTransition.h"
#import "LYDIYSectionViewController.h"
#import "LYPercentDrivenInteractiveTransition.h"

@interface LYDIYTransitionViewController ()<UINavigationControllerDelegate>
{
    
}
@property (nonatomic,assign) UINavigationControllerOperation operation;
@property (nonatomic,strong) LYPercentDrivenInteractiveTransition *percentDrivenInteractive;
@end

@implementation LYDIYTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [testBtn addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    [testBtn setTitle:@"push" forState:UIControlStateNormal];
    testBtn.backgroundColor = [UIColor redColor];
    testBtn.frame = CGRectMake(50, 500, 100, 40);
    [self.view addSubview:testBtn];
    // Do any additional setup after loading the view.
}

- (void)dealloc
{
    
}

- (void)pushVC
{
    LYDIYSectionViewController *vc = [[LYDIYSectionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    self.operation = operation;
    if (operation == UINavigationControllerOperationPush) {
        _percentDrivenInteractive = [LYPercentDrivenInteractiveTransition new];
        [_percentDrivenInteractive addGestureToViewController:toVC];
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
    if (self.operation == UINavigationControllerOperationPop) {
        return _percentDrivenInteractive;
    }
    NSLog(@"interactionControllerForAnimationController");
    return nil;
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
