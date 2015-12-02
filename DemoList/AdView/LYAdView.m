//
//  LYAdView.m
//  LYDemo
//
//  Created by luoyan on 15/12/2.
//  Copyright © 2015年 lySoft. All rights reserved.
//

#import "LYAdView.h"

@interface LYAdView ()

#pragma mark property list
@property (nonatomic, strong) UIScrollView    *adScrollView;     
@property (nonatomic, strong) UIPageControl   *pageControl;
@property (nonatomic, retain) NSTimer         *adLoopTimer;
@property (nonatomic, strong) NSMutableArray  *pageControlConstraints;

@end

@implementation LYAdView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.adPeriodTime = 3.0f;
        self.adAutoPlay = YES;
        [self loadBaseView];
    }
    return self;
}

- (void)loadBaseView
{
    //初始化Scrollview
    self.adScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.adScrollView.pagingEnabled = YES;
    self.adScrollView.delegate = self;
    self.adScrollView.showsHorizontalScrollIndicator = NO;
    self.adScrollView.bounces = NO;
    [self addSubview:self.adScrollView];
    
    //初始化分页显示控件
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageControl.enabled = NO;
    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
    
    [self setPageControlPosition];
}

//修复该view在A页面时，当A页面销毁后，计时器还未销毁导致奔溃问题
- (void)dealloc
{
    if (self.adLoopTimer) {
        [self.adLoopTimer invalidate];
        self.adLoopTimer = nil;
    }
}

#pragma mark -加载并播放广告数据内容
- (void)reloadAdView
{
    if ([self.dataSource numberOfPages] == 0) {
        return;
    }
    
    if ([self.dataSource numberOfPages] > 1) {
        [self.adScrollView setContentSize:CGSizeMake(self.adScrollView.bounds.size.width*([self.dataSource numberOfPages]+2), self.adScrollView.bounds.size.height)];
        self.pageControl.numberOfPages = [self.dataSource numberOfPages];
        
        for (int i = 0; i < [self.dataSource numberOfPages]; i++)
        {
            UIView *adView = [self.dataSource pageAtIndex:i];
            adView.frame = CGRectMake((i+1)*self.adScrollView.bounds.size.width, 0, self.adScrollView.bounds.size.width,self.adScrollView.bounds.size.height);
            adView.tag = i;
            adView.userInteractionEnabled = YES;
            [adView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adViewClick)]];
            [self.adScrollView addSubview:adView];
        }
        
        UIView *lastAdView = [self.dataSource pageAtIndex:[self.dataSource numberOfPages]-1];
        lastAdView.frame = CGRectMake(0, 0, self.adScrollView.bounds.size.width, self.adScrollView.bounds.size.height);
        [self.adScrollView addSubview:lastAdView];
        
        
        UIView *firstAdView = [self.dataSource pageAtIndex:0];
        firstAdView.frame = CGRectMake(([self.dataSource numberOfPages] + 1)*self.adScrollView.bounds.size.width, 0, self.adScrollView.bounds.size.width, self.adScrollView.bounds.size.height);
        [self.adScrollView addSubview:firstAdView];
        
        
        [self.adScrollView setContentOffset:CGPointMake(self.adScrollView.bounds.size.width, 0)];
        
        if (self.adAutoPlay) {
            if (!self.adLoopTimer) {
                self.adLoopTimer = [NSTimer scheduledTimerWithTimeInterval:self.adPeriodTime target:self selector:@selector(loopAdView) userInfo:nil repeats:YES];
            }
        }
    } else {
        UIView *onlyOneView = [self.dataSource pageAtIndex:0];
        onlyOneView.frame = CGRectMake(0, 0, self.adScrollView.bounds.size.width, self.adScrollView.bounds.size.height);
        [self.adScrollView addSubview:onlyOneView];
        self.pageControl.hidden = YES;
        if (self.adLoopTimer) {
            [self.adLoopTimer invalidate];
            self.adLoopTimer = nil;
        }
    }
}

#pragma mark - 循环播放
- (void)loopAdView
{
    CGFloat pageWidth = self.adScrollView.frame.size.width;
    int currentPage = self.adScrollView.contentOffset.x/pageWidth;
    if (currentPage == 0) {
        self.pageControl.currentPage = self.pageControl.numberOfPages-1;
    }
    else if (currentPage == self.pageControl.numberOfPages+1) {
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = currentPage-1;
    }
    
    __block NSInteger currPageNumber = self.pageControl.currentPage;
    CGSize viewSize = self.adScrollView.frame.size;
    CGRect rect = CGRectMake((currPageNumber+2)*pageWidth, 0, viewSize.width, viewSize.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.adScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
        currPageNumber++;
        if (currPageNumber == self.pageControl.numberOfPages) {
            [self.adScrollView setContentOffset:CGPointMake(self.adScrollView.bounds.size.width, 0)];
            currPageNumber = 0;
        }
    }];
    
    currentPage = self.adScrollView.contentOffset.x/pageWidth;
    if (currentPage == 0)
    {
        self.pageControl.currentPage = self.pageControl.numberOfPages-1;
    }
    else if (currentPage == self.pageControl.numberOfPages+1)
    {
        self.pageControl.currentPage = 0;
    }
    else
    {
        self.pageControl.currentPage = currentPage-1;
    }
}

#pragma mark---- UIScrollView delegate methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentAdPage = self.adScrollView.contentOffset.x/self.adScrollView.bounds.size.width;
    if (currentAdPage == 0)
    {
        [scrollView scrollRectToVisible:CGRectMake(self.adScrollView.bounds.size.width*self.pageControl.numberOfPages, 0, self.adScrollView.bounds.size.width, self.adScrollView.bounds.size.height) animated:NO];
        currentAdPage = self.pageControl.numberOfPages-1;
    }
    else if (currentAdPage == (self.pageControl.numberOfPages+1))
    {
        [scrollView scrollRectToVisible:CGRectMake(self.adScrollView.bounds.size.width, 0, self.adScrollView.bounds.size.width, self.adScrollView.bounds.size.height) animated:NO];
        currentAdPage = 0;
    }
    else
    {
        currentAdPage = currentAdPage-1;
    }
    
    self.pageControl.currentPage = currentAdPage;
    
    if (self.adAutoPlay && [self.dataSource numberOfPages] > 1) {
        if (!self.adLoopTimer) {
            self.adLoopTimer = [NSTimer scheduledTimerWithTimeInterval:self.adPeriodTime target:self selector:@selector(loopAdView) userInfo:nil repeats:YES];
        }
    } else {
        if (self.adLoopTimer) {
            [self.adLoopTimer invalidate];
            self.adLoopTimer = nil;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //开始拖动scrollview的时候 停止计时器控制的跳转
    if (self.adAutoPlay) {
        if (self.adLoopTimer) {
            [self.adLoopTimer invalidate];
            self.adLoopTimer = nil;
        }
    }
}

- (void)setPageControlPosition
{
    NSString *vFormat = @"V:[pageControl]-0-|";
    NSString *hFormat = @"H:|[pageControl]|";
    
    if (!self.pageControlConstraints) {
        self.pageControlConstraints = [[NSMutableArray alloc] init];
    }
    [self removeConstraints:self.pageControlConstraints];
    
    NSArray *pageControlVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:vFormat
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    NSArray *pageControlHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hFormat
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    [self.pageControlConstraints removeAllObjects];
    [self.pageControlConstraints addObjectsFromArray:pageControlVConstraints];
    [self.pageControlConstraints addObjectsFromArray:pageControlHConstraints];
    
    [self addConstraints:self.pageControlConstraints];
    
}

- (void)setHidePageControl:(BOOL)hidePageControl
{
    self.pageControl.hidden = hidePageControl;
}

#pragma mark - 点击
- (void)adViewClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [self.delegate didClickPage:self atIndex:self.pageControl.currentPage];
    }
}
@end
