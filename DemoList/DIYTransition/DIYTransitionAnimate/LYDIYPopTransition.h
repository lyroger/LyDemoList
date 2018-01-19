//
//  LYDIYTransition.h
//  DemoList
//
//  Created by luoyan on 2018/1/10.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PopTransitionEndBlock)(void);
@interface LYDIYPopTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic,copy) PopTransitionEndBlock popEndBlock;
@end
