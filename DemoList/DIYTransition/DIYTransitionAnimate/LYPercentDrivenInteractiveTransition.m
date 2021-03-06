//
//  LYPercentDrivenInteractiveTransition.m
//  DemoList
//
//  Created by luoyan on 2018/1/12.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "LYPercentDrivenInteractiveTransition.h"
#import "UIView+CancelTouchInView.h"

@interface LYPercentDrivenInteractiveTransition ()<UIGestureRecognizerDelegate>
{
    BOOL _isInter;
}

@property (nonatomic, weak  ) UIViewController *vc;  //
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat percent;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, assign) CGFloat beginX;
@property (nonatomic, assign) CGFloat lastX;

@end
@implementation LYPercentDrivenInteractiveTransition

- (UIPanGestureRecognizer*)pan
{
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        _pan.delegate = self;
//        _pan.delaysTouchesBegan = NO;
//        _pan.cancelsTouchesInView = NO;
    }
    return _pan;
}

- (void)addGestureToViewController:(UIViewController *)vc
{
    [self.vc.view removeGestureRecognizer:self.pan];
    self.vc = vc;
    [vc.view addGestureRecognizer:self.pan];
}

//接收到touch后，决定手势是否需要响应，如果return yes 则响应手势，return NO则不响应手势。
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint location = [touch locationInView:touch.view];
    BOOL ret = (0 < location.x && location.x <= 40);
    if (ret) {
        return ret;
    } else {
        return !touch.view.ly_cancelTouchInviewValue;
    }
}
//如果 gestureRecognizer:shouldReceiveTouch 返回yes 则该方法会响应
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    // 侧滑手势触发位置
    CGPoint location = [gestureRecognizer locationInView:self.vc.view];
    CGPoint offSet = [gestureRecognizer translationInView:gestureRecognizer.view];
    BOOL ret = (0 < offSet.x && location.x <= 40);
    return ret;
}

/// 只有当系统侧滑手势失败了，才去触发ScrollView的滑动
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)panAction:(UIPanGestureRecognizer *)pan
{
    _percent = 0.0;
    CGFloat totalWidth = pan.view.bounds.size.width;
    CGFloat x = [pan translationInView:pan.view].x;
    _percent = x/totalWidth;
    NSLog(@"_percent = %.3f",_percent);
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            self.beginX = x;
            self.lastX = x;
        }
            break;
        case UIGestureRecognizerStateChanged:{
            if ([self judgeRightSwipe:x]) {
                _isInter = YES;
                [_vc.navigationController popViewControllerAnimated:YES];
            }
            [self updateInteractiveTransition:_percent];
            self.lastX = x;
        }
            break;
        case UIGestureRecognizerStateEnded:{
            if (_isInter) {
                _isInter = NO;
                [self continueAction];
            }
        }
            break;
        default:
            break;
    }
}

- (BOOL)judgeRightSwipe:(CGFloat)pointX
{
    if (pointX - self.beginX > 0 && pointX - self.lastX > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isInteractive
{
    return _isInter;
}

//手势结束后，页面如任未完成关闭或还原，则通过定时器完成更新
- (void)continueAction
{
    if (_displayLink) {
        return;
    }
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateUI)];
    [_displayLink  addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)updateUI
{
    CGFloat timeDistance = 2.0/60;
    if (_percent > 0.4) {
        _percent += timeDistance;
    }else {
        _percent -= timeDistance;
    }
    [self updateInteractiveTransition:_percent];
    
    if (_percent >= 1.0) {
        [self finishInteractiveTransition];
        [_displayLink invalidate];
        _displayLink = nil;
    }
    
    if (_percent <= 0.0) {
        [_displayLink invalidate];
        _displayLink = nil;
        [self cancelInteractiveTransition];
    }
}


@end
