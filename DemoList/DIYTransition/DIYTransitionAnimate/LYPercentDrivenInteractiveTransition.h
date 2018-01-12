//
//  LYPercentDrivenInteractiveTransition.h
//  DemoList
//
//  Created by luoyan on 2018/1/12.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (readonly, assign, nonatomic) BOOL isInteractive;
- (void)addGestureToViewController:(UIViewController *)vc;
@end
