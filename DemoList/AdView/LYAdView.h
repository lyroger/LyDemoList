//
//  LYAdView.h
//  LYDemo
//
//  Created by luoyan on 15/12/2.
//  Copyright © 2015年 lySoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYAdViewDelagate;
@protocol LYAdViewDataSource;

@interface LYAdView : UIView  <UIScrollViewDelegate>

@property (nonatomic, assign) BOOL                   hidePageControl;     // 隐藏 pageControl, 默认 NO
@property (nonatomic, assign) BOOL                   adAutoPlay;          // 是否自动播放广告,默认yes
@property (nonatomic, assign) CGFloat                adPeriodTime;        // 切换广告时间,默认3秒
@property (nonatomic, weak)   id<LYAdViewDelagate>   delegate;
@property (nonatomic, weak)   id<LYAdViewDataSource> dataSource;

#pragma mark method list
/**
 *  加载广告
 */
- (void)reloadAdView;

@end

@protocol LYAdViewDelagate <NSObject>

- (void)didClickPage:(LYAdView *)adView atIndex:(NSInteger)index;

@end

@protocol LYAdViewDataSource <NSObject>

@optional
- (NSInteger)numberOfPages;
- (UIView *)pageAtIndex:(NSInteger)index;

@end