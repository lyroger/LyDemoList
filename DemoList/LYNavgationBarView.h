//
//  LYNavgationBarView.h
//  DemoList
//
//  Created by luoyan on 2018/1/18.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kNavgationHeight 64

typedef void(^NavgationBackBlock)();
@interface LYNavgationBarView : UIView
@property (nonatomic,copy) NavgationBackBlock backBlock;
- (void)title:(NSString*)title;
- (void)hideBackButton:(BOOL)hide;
@end
