//
//  LYPercentDrivenInteractiveTransition.m
//  DemoList
//
//  Created by luoyan on 2018/1/12.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "LYPercentDrivenInteractiveTransition.h"
@interface LYPercentDrivenInteractiveTransition ()
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
    }
    return _pan;
}

- (void)addGestureToViewController:(UIViewController *)vc
{
    [self.vc.view removeGestureRecognizer:self.pan];
    self.vc = vc;
    [vc.view addGestureRecognizer:self.pan];
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
                [self updateInteractiveTransition:_percent];
            }
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
    if (pointX - self.beginX > 40 || pointX - self.lastX > 0) {
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
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(UIChange)];
    [_displayLink  addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)UIChange
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
