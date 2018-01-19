//
//  LYMainTabBarController.h
//  DemoList
//
//  Created by luoyan on 2017/6/20.
//  Copyright © 2017年 luoyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYBaseViewController.h"

@interface LYMainTabBarController : UITabBarController
- (void)switchTabBarToBaseViewVC:(LYBaseViewController*)baseVC;
- (void)switchTabBarToTabBarVC;
@end
