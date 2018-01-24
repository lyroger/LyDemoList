//
//  LYBaseViewController.h
//  DemoList
//
//  Created by luoyan on 2017/6/20.
//  Copyright © 2017年 luoyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CancelTouchInView.h"

@interface LYBaseViewController : UIViewController

@property (nonatomic,assign) CGRect tabbarViewOriginFrame;
@property (nonatomic,strong) UIView *contentView;

@end
