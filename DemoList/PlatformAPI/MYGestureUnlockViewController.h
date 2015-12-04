//
//  MYGestureUnlockViewController.h
//  MobilePlatform
//
//  Created by Simon Dai on 5/15/14.
//  Copyright (c) 2014 Mysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYGestureUnlockViewController : UIViewController

typedef void (^MYGestureCodeUnLockEnterBlock)();

+ (BOOL)isGestureLockShowing;

+ (void)showGestureUnlockViewWithEnterBlock:(MYGestureCodeUnLockEnterBlock)enter;

+ (void)removeGestureUnlockView;

@end
