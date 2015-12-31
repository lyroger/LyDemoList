//
//  RunTimeMessage1ViewController.m
//  DemoList
//
//  Created by luoyan on 15/12/31.
//  Copyright © 2015年 luoyan. All rights reserved.
//

#import "RunTimeMessageViewController.h"
#import <objc/runtime.h>
#import "DisplayView.h"
#import "DisplayView2.h"

@interface RunTimeMessageViewController ()

@end

@implementation RunTimeMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelector:@selector(doSomething)];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

void dynamicMethodIMP (id self, SEL _cmd) {
    
    NSLog(@"doSomething SEL");
}

//第二步
+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(doSomething)) {
//        NSLog(@"add method here");
//        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
//        return YES;
//    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    Class class = NSClassFromString(@"DisplayView");
    DisplayView *view = class.new;
    if (aSelector == NSSelectorFromString(@"doSomething")) {
        NSLog(@"DisplayView do this !");
        return view;
    }
    
    return nil;
}

//消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [self methodSignatureForSelector:aSelector];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL selector = [anInvocation selector];
    DisplayView2 *view = [[DisplayView2 alloc] init];
    if ([view respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:view];
    }
}

- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSLog(@"doesNotRecognizeSelector");
}

@end
