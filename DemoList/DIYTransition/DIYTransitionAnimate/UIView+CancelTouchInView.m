//
//  UIView+CancelTouchInView.m
//  DemoList
//
//  Created by luoyan on 2018/1/23.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "UIView+CancelTouchInView.h"
#import <objc/runtime.h>

@implementation UIView(CancelTouchInView)

- (BOOL)ly_cancelTouchInviewValue
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) {
        return number.boolValue;
    }
    //默认值为NO；
    self.ly_cancelTouchInviewValue = NO;
    return NO;
}

- (void)setLy_cancelTouchInviewValue:(BOOL)value
{
    SEL key = @selector(ly_cancelTouchInviewValue);
    objc_setAssociatedObject(self, key, @(value), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
